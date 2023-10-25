import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photographer_ai/Model/aiImage/ai_image.dart';
import 'package:photographer_ai/ViewModel/filter/filter_vm.dart';

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
      body: Center(
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
            Obx(() => fcontroller.image.value.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child:
                      Text('사진을 찍거나\n아래 버튼을 통해 사진을 올려주세요.', textAlign: TextAlign.center),
                )
              : Center(
              child: fcontroller.image.value.isNotEmpty
                ? Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    itemCount: fcontroller.aiImageList.length, // 필터 개수에 맞게 변경해야 함
                    itemBuilder: (context, index) {
                      final AiImage aiImage = fcontroller.aiImageList[index]; // 필터 정보를 가져와서 사용해야 함

                      return GestureDetector(
                        onTap: () {
                          // 필터 선택 시 동작 구현
                        },
                        child: Card(
                          // 웹에서 정보 받아와서 뿌려줄 것
                          // getJSONData();
                          // aiImageList[index].data;
                          child: Text(aiImage.toString()), // 예시로 필터 이름을 표시함
                        ),
                      );
                    },
                  ),
                )
                : const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

// class PhotoGrapherFilter extends StatefulWidget {
//   const PhotoGrapherFilter({super.key});

//   @override
//   State<PhotoGrapherFilter> createState() => _PhotoGrapherFilterState();
// }

// class _PhotoGrapherFilterState extends State<PhotoGrapherFilter> {

//   late List<AiImage> aiImageList;
//   XFile? _image;
//   final ImagePicker picker = ImagePicker();
//   var value = Get.arguments ?? '__';
//   bool isLoaded = false;
//   bool imgLoad = false;

//   @override
//   void initState() {
//     super.initState();
//     aiImageList = [];
//     isLoaded = value != '__' ? false : true;
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AI PhotoGrapher'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               getImage(ImageSource.gallery).then((value) => setState(() {
//                 if(_image != null){
//                   print(_image!.path);
//                   imgLoad = true;
//                   print(imgLoad);
//                 }
//               }));
//             },
//             icon: const Icon(Icons.folder, color: Colors.amber),
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 150,
//               width: MediaQuery.of(context).size.width,
//               child: value == '__' || !imgLoad ?
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.image_not_supported_outlined, size: 85, color: Colors.grey[400],),
//                 ],
//               )
//               : Image.file(
//                 File(!imgLoad ? value[1] : _image!.path),
//               ),
//             ),
//             const Text('AI Recommend Filter'),
//             value == '__' || _image == null
//             ? Padding(
//               padding: const EdgeInsets.only(top: 50),
//               child: Text('사진을 찍거나\n아래 버튼을 통해 사진을 올려주세요.', textAlign: TextAlign.center)
//             )
//             : Center(
//               child: isLoaded
//                 ? Container(
//                   height: MediaQuery.of(context).size.height*0.5,
//                   child: ListView.builder(
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           //
//                         },
//                         child: Card(
//                           // 웹에서 정보 받아와서 뿌려줄것
//                           // getJSONData();
//                           // aiImageList[index].data;
//                         ),
//                       );
//                     },
//                   )
//                 )
//                 : const Padding(
//                   padding: EdgeInsets.only(top: 20),
//                   child: CircularProgressIndicator(),
//                 ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   getJSONData() async {
//     var url = Uri.parse(
//         'http://localhost:8080/Flutter/dup_check_select_flutter.jsp?userid=${0}');
//     var response = await http.get(url);
//     // data.clear();
//     var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
//     String result = dataConvertedJSON['result'];
//     setState(() {});
//     print(result);
//     if (result == 'success') {
//       // aiImageList.add(value);
//     } else {
//       // 
//     }
//   }

  // //이미지를 가져오는 함수
  // Future getImage(ImageSource imageSource) async {
  //   //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
  //   final XFile? pickedFile = await picker.pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
  //     });
  //   } else{
  //     _image = null;
  //   }
  // }
// }