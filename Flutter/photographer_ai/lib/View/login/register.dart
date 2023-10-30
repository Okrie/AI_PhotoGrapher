import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  inputFormatters: <TextInputFormatter>[
                    //한글을 제외한 영어 대,소문자,숫자 입력 가능
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  ],
                  controller: userIdController,
                  decoration: const InputDecoration(
                    labelText: '아이디을 입력해주세요',
                  ),
                ),
                TextField(
                  inputFormatters: <TextInputFormatter>[
                    //특수문자를 제외한 문자,숫자 입력 가능
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9가-힣]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) {},
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호를 입력해주세요',
                  ),
                ),
                TextField(
                  inputFormatters: <TextInputFormatter>[
                    //특수문자를 제외한 문자,숫자 입력 가능
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9가-힣]'),),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: password2Controller,
                  decoration: const InputDecoration(labelText: '다시 한번 비밀번호를 입력해주세요'),
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
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
                          } else if (passwordController.text.trim().isEmpty) {
                            Get.snackbar(
                              '알림',
                              '패스워드를 입력해주세요.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else if (password2Controller.text.trim().isEmpty) {
                            Get.snackbar(
                              '알림',
                              '재비밀번호를 입력해주세요.',
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
                            Get.back();
                          }
          
                          var url = Uri.parse(
                              'http://localhost:8000/Flutter/dup_check_select_flutter.jsp?userid=${userIdController.text}');
                          var response = await http.get(url);
                          var dataConvertedJSON =
                              json.decode(utf8.decode(response.bodyBytes));
                          String result = dataConvertedJSON['result'];
                          print(result);
                          if (result == 'success') {
                            Get.snackbar(
                              '회원가입에 실패하셨습니다.',
                              '동일한 아이디가 존재 합니다.',
                            );
                          } else {
                            // Get.to(LoginPage());
                            _showDialog();
                          }
                        },
                        child: const Text('회원가입'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child:const Text('취소하기')
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  insertAction() async {
    var url = Uri.parse(
        'http://localhost:8000/Flutter/login_insert_flutter.jsp?userid=${userIdController.text}&password=${passwordController.text}&phone=${phoneController.text}');
    await http.get(url);
  }

  getJSONData() async {
    var url = Uri.parse(
        'http://localhost:8000/Flutter/dup_check_select_flutter.jsp?userid=${userIdController.text}'); //uri는 정보를 주고 가져오는 것
    var response = await http.get(url);
    // data.clear();
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    String result = dataConvertedJSON['result'];
    setState(() {});
    print(result);
    if (result == 'fail') {
      Get.snackbar(
        '회원가입에 실패하셨습니다.',
        '동일한 아이디가 존재 합니다.',
      );
    } else {
      // Get.to(LoginPage());
      _showDialog();
    }
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('입력'),
          content: Text('${userIdController.text}회원님의 입력이 완료 되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}