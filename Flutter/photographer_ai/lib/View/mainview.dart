import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photographer_ai/View/home.dart';
import 'package:photographer_ai/ViewModel/Main/author_vm.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {

    final authorcontroller = Get.put(AuthorController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today PhotoGrapher'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Obx(() => authorcontroller.pload.value
                  ? Image.network(
                    authorcontroller.data[Random().nextInt(authorcontroller.data.length)]['pimage'],
                    width: MediaQuery.of(context).size.width*0.6,
                    fit: BoxFit.fitWidth,
                  )
                  : const CircularProgressIndicator()
                ) 
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('PhotoGraphers'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: FutureBuilder(
                future: authorcontroller.fetchAuthors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // 로딩 중일 때 로딩 인디케이터 표시
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // 오류 발생 시 오류 메시지 표시
                  } else {
                    return ListView.builder( // 데이터 로드 완료 시 리스트뷰로 표시
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {                    
                        return GestureDetector(
                          onTap: () {
                            Get.snackbar('Author Filter', '${authorcontroller.data[index]['pnickname']}작가로 적용됩니다.', backgroundColor: Colors.amber[50], snackPosition: SnackPosition.BOTTOM);
                            authorcontroller.pseq.value = authorcontroller.data[index]['seq'];
                            Get.offAll(() => const Home(), arguments: 2);
                          },
                          child: Card(
                            color: const Color.fromARGB(255, 237, 241, 231),
                            child: Row(
                              children: [
                                Image.network(
                                  authorcontroller.data[index]['pimage'],
                                  width: 250,
                                  height: 100,
                                  fit: BoxFit.fitWidth,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 30)
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: Text('${authorcontroller.data[index]['pnickname']} 작가'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );// base64 인코딩된 이미지 데이터를 이미지로 변환하여 표시
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MainView extends StatefulWidget {
//   const MainView({super.key});

//   @override
//   State<MainView> createState() => _MainViewState();
// }

// class _MainViewState extends State<MainView> {

//   late List<String> recommendedList;
//   late List<String> recommendedAuthor;

//   @override
//   void initState() {
//     super.initState();
//     recommendedList = [];
//     recommendedAuthor = [];
//     addFun();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Today PhotoGrapher'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 15),
//               child: Container(
//                 height: 200,
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.black,
//                 child: Image.asset(
//                   'images/banner.png',
//                   width: MediaQuery.of(context).size.width*0.6,
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top: 20),
//               child: Text('PhotoGraphers'),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 5),
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height*0.5,
//                 child: ListView.builder(
//                   itemCount: recommendedList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             recommendedList[index],
//                             width: 250,
//                             height: 100,
//                             fit: BoxFit.fitWidth,
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(left: 30)
//                           ),
//                           SizedBox(
//                             height: 100,
//                             width: 100,
//                             child: Center(
//                               child: Text('${recommendedAuthor[index].toString()} 작가'),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   addFun(){
//     recommendedList.add('images/author1.png');
//     recommendedAuthor.add('Lucia');
//     recommendedList.add('images/author2.png');
//     recommendedAuthor.add('Rain');
//     recommendedList.add('images/author3.png');
//     recommendedAuthor.add('Edward');
//   }
// }


