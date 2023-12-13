import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:photographer_ai/ViewModel/User/user_vm.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late TextEditingController userIdController; // 아이디
  late TextEditingController passwordController; // 비밀번호
  late TextEditingController password2Controller; //2차 비밀번호 중복확인
  late TextEditingController phoneController; //핸드폰번호
  final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userIdController = TextEditingController();
    passwordController = TextEditingController();
    password2Controller = TextEditingController();
    phoneController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  inputFormatters: <TextInputFormatter>[
                    //한글을 제외한 영어 대,소문자,숫자 입력 가능
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  ],
                  controller: userIdController,
                  decoration: const InputDecoration(
                    labelText: '아이디을 입력해주세요',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  inputFormatters: <TextInputFormatter>[
                    //특수문자를 제외한 문자,숫자 입력 가능
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9가-힣]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) {},
                  controller: passwordController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    labelText: '비밀번호를 입력해주세요',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  inputFormatters: <TextInputFormatter>[
                    //특수문자를 제외한 문자,숫자 입력 가능
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9가-힣]'),),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: password2Controller,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(labelText: '다시 한번 비밀번호를 입력해주세요'),
                ),
              ),
              // TextField(
              //   controller: phoneController,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
              //     LengthLimitingTextInputFormatter(13),
              //   ],
              //   onChanged: (value) {
              //     final RegExp phoneRegex =
              //         RegExp(r'^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$');
              //     if (phoneRegex.hasMatch(value)) {
              //     } else {}
              //   },
              //   decoration: const InputDecoration(
              //     labelText: '전화번호를 입력해주세요',
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    //텍스트 필드 미입력시 팝업
                    onPressed: () async {
                      if (userIdController.text.trim().isEmpty) {
                        Get.snackbar(
                          '알림',
                          '아이디를 입력해주세요.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } 
                      if (passwordController.text.trim().isEmpty) {
                        Get.snackbar(
                          '알림',
                          '패스워드를 입력해주세요.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } 
                      if (password2Controller.text.trim().isEmpty) {
                        Get.snackbar(
                          '알림',
                          '재비밀번호를 입력해주세요.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else if(passwordController.text.trim() != password2Controller.text.trim()){
                        Get.snackbar(
                          '알림',
                          '재비밀번호를 확인해주세요.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      // } else if (phoneController.text.trim().isEmpty) {
                      //   Get.snackbar(
                      //     '알림',
                      //     '전화번호를 입력해주세요.',
                      //     snackPosition: SnackPosition.BOTTOM,
                      //   );
                      } else {
                        // 이전 화면으로 돌아가기
                        // Get.back();
                        var result = await userController.userRegister(userIdController.text, passwordController.text);
                        if (result){
                          _showDialog();
                          Get.back();
                        } else{
                          //
                        }
                      }
                      
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      backgroundColor: Colors.orange[100],
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: const Text('회원가입'),
                  ),
                  const SizedBox(
                    height: 70,
                    width: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      backgroundColor: Colors.orange[100],
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child:const Text('취소하기')
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('입력'),
          content: Text('${userIdController.text} 회원님의 입력이 완료 되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}