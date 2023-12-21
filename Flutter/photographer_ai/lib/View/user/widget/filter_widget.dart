import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget filterPurchaseList(BuildContext context, {required String author, required int remain}){
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.125,
    child: Column(
      children: [
        const Divider(),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$author 작가',
                  ),
                  Text(
                    '남은 필터 수 : $remain',
                    style: const TextStyle(
                      fontSize: 10
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: '$author 작가',
                    titleStyle: const TextStyle(
                      fontSize: 18
                    ),
                    middleText:  '$author 작가의 필터를 구매 하시겠습니까?',
                    middleTextStyle: const TextStyle(
                      fontSize: 13
                    ),
                    confirm: TextButton(
                      onPressed: () {
                        remain++;
                        Get.back();
                        Get.snackbar(
                          '구매',
                          '$author 작가의 필터를 구매 하였습니다.',
                          snackPosition: SnackPosition.BOTTOM
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue[800]
                      ),
                      child: const Text('구매'),
                    ),
                    cancel: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600]
                      ),
                      child: const Text('취소'),
                    ),
                  );
                },
                child: Row(
                  children : [
                    Text(
                      '구매하기',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue[800]
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}