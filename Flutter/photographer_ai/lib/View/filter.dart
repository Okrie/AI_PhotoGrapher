import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photographer_ai/ViewModel/Filter/filter_vm.dart';

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
      body: SingleChildScrollView(
        child: Column(
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
            Obx(() => !fcontroller.imgUpLoad.value
              ? const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child:
                      Text('사진을 찍거나\n상단 버튼을 통해 사진을 올려주세요.', textAlign: TextAlign.center),
                )
              : SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: FutureBuilder<List<String>>(
                  future: fcontroller.uploadImageAndFetchData(),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // 로딩 중일 때는 로딩 인디케이터 표시
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // 오류 발생 시 오류 메시지 표시
                    } else {
                      return ListView.builder( // 이미지 데이터 로드 완료 시 리스트뷰로 표시
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String imageBase64 = snapshot.data![index];
                          Uint8List bytes = base64Decode(imageBase64);
                      
                          return Card(
                            child: Image.memory(bytes)
                          ); // base64 인코딩된 이미지 데이터를 이미지로 변환하여 표시
                        },
                      );
                    }
                  },
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}