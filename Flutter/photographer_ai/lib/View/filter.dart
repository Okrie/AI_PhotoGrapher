import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photographer_ai/Model/aiImage/ai_image.dart';
import 'package:photographer_ai/ViewModel/filter/filter_vm.dart';


// 단일 이미지 받아옴 테스트
Future<String> _fetchImage() async {
  final response = await http.get(Uri.parse('http://121.130.179.94:8000/pred'));

  if (response.statusCode == 200) {
    List<dynamic> list = jsonDecode(response.body);
    Map<String, dynamic> result = jsonDecode(list[0]['result']); // 리스트의 첫 번째 요소에 접근
    String imageBase64 = result['image'];
    return imageBase64;
  } else {
    throw Exception('Failed to load image');
  }
}

// 여러개의 생성된 이미지를 받아온다.
Future<List<String>> _fetchImages() async {
  final response = await http.get(Uri.parse('http://121.130.179.94:8000/pred'));

  if (response.statusCode == 200) {
    List<dynamic> list = jsonDecode(response.body);
    List<String> images = [];

    for (var item in list) {
      if (item is Map) {
        List<dynamic> results = item['result']; // 'result' 키의 값이 리스트
        for (var res in results) {
          Map<String, dynamic> resultJson = jsonDecode(res); // 리스트의 각 요소는 문자열로 된 JSON
          String imageBase64 = resultJson['image']; // JSON에서 'image' 키의 값을 가져옴
          images.add(imageBase64);
        }
      }
    }

    return images;
  } else {
    throw Exception('Failed to load images');
  }
}


class PhotoGrapherFilter extends StatelessWidget{
  const PhotoGrapherFilter({super.key});

  @override
  Widget build(BuildContext context){

    FilterController fcontroller;

    try{
      fcontroller = Get.find();
    } catch (e){
      fcontroller = Get.put(FilterController());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI PhotoGrapher'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => fcontroller.getImage(ImageSource.gallery),
            icon: const Icon(Icons.folder, color: Colors.amber),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Obx(() => fcontroller.image.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_not_supported_outlined, size: 85, color: Colors.grey[400]),
                  ],
                )
              : Image.file(File(fcontroller.image.value)),
            )
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50)
          ),
          const Text('AI Recommend Filter'),
          SingleChildScrollView(
            child: Obx(() => fcontroller.image.value.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child:
                      Text('사진을 찍거나\n상단 버튼을 통해 사진을 올려주세요.', textAlign: TextAlign.center),
                )
              : FutureBuilder<List<String>>(
                future: _fetchImages(),
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // 로딩 중일 때는 로딩 인디케이터 표시
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // 오류 발생 시 오류 메시지 표시
                  } else {
                    return ListView.builder( // 이미지 데이터 로드 완료 시 리스트뷰로 표시
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String imageBase64 = snapshot.data![index];
                        Uint8List bytes = base64Decode(imageBase64);
                    
                        return Image.memory(bytes); // base64 인코딩된 이미지 데이터를 이미지로 변환하여 표시
                      },
                    );
                  }
                },
              )
            ),
          )
        ],
      ),
    );
  }
}