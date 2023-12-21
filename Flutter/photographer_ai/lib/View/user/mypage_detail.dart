import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photographer_ai/View/user/widget/filter_widget.dart';
import 'package:photographer_ai/ViewModel/Main/author_vm.dart';
import 'package:photographer_ai/ViewModel/User/purchase_vm.dart';
import 'package:photographer_ai/ViewModel/User/user_vm.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    
    final authorController = Get.put(AuthorController());
    final purchaseController = Get.put(PurchaseController());

    return Center(
      child: Column(
        children: [
          const Text('안녕하세요!'),
          Text(' ${userController.userid.value} 님'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          ElevatedButton(
            onPressed: () {
              if (purchaseController.isView.value) {
                purchaseController.isView.value = false;
              } else{
                purchaseController.isView.value = true;
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 40),
              backgroundColor: Colors.grey[700],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            child: const Text('구매목록'),
          ),
          ElevatedButton(
            onPressed: () {
              //
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 40),
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            child: const Text('필터 추천'),
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          // Obx(() => purchaseController.isView.value
          //   ? FutureBuilder(
          //     future: purchaseController.fetchFilterHive(userController.userid.value),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const CircularProgressIndicator(); // 로딩 중일 때 로딩 인디케이터 표시
          //       } else if (snapshot.hasError) {
          //         return Text('Server Closed');//${snapshot.error}'); // 오류 발생 시 오류 메시지 표시
          //       } else if (!snapshot.hasData){
          //         return const Text('보유하고 있는 필터가 없습니다.');
          //       }
          //       else{
          //         authorController.fetchAuthorsHive();
          //         return ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: purchaseController.data.length,
          //           itemBuilder: (context, index) {
          //             return Card(
          //               color: Colors.amber[400],
          //               child: Row(
          //                 children: [
          //                   const Padding(padding: EdgeInsets.all(8)),
          //                   Text(
          //                     '${purchaseController.getNicknameBySeq(authorController.data, purchaseController.data[index]['seq'])} 작가 필터',
          //                   ),
          //                   const Padding(padding: EdgeInsets.all(15)),
          //                   Text('남은 필터 수 : ${purchaseController.data[index]['expired']}')
          //                 ],
          //               ),
          //             );
          //           },
          //         );
          //       }
          //     }
          //   )
          //   : const Padding(
          //     padding: EdgeInsets.all(20)
          //   )
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                filterPurchaseList(context, author: 'AI', remain: 3),
                filterPurchaseList(context, author: 'OSM', remain: 7),
                filterPurchaseList(context, author: 'Seola', remain: 5),
                filterPurchaseList(context, author: 'Oh-Kang', remain: 300),
              ]
            ),
          )
        ],
      ),
    );
  }
}