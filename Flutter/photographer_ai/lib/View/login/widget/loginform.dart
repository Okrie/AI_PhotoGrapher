import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:photographer_ai/View/home.dart';
import 'package:photographer_ai/View/login/register.dart';
import 'package:photographer_ai/ViewModel/User/user_vm.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usercontroller = Get.put(UserController());

  late TextEditingController useridController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    useridController = TextEditingController();
    passwordController = TextEditingController();
    _initSharedpreferences();
  }

  @override
  void dispose() {
    _disposeSharedpreferences();
    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form fields are valid, proceed with login process.
      // print('Id: $id, Password: $password');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: useridController,
                decoration: const InputDecoration(
                  labelText: '아이디를 입력해주세요',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호를 입력해주세요',
                ),
                obscuringCharacter: '*',
                obscureText: true,
              ),
            ),
            ElevatedButton(
              // 로그인
              onPressed: () async {
                print('id=${useridController.text}&password=${passwordController.text}');
                var url = Uri.parse('http://flask.okrie.kro.kr:8000/auth/user');
                var headers = { 'Content-Type': 'application/json', 'accept': 'application/json',};
                var body = jsonEncode({'id': useridController.text, 'password': passwordController.text});
                var response = await http.post(
                  url,
                  headers: headers,
                  body: body
                );
                print(response.body);
                print(response.statusCode);
                if (response.statusCode == 201){
                  var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
                  String result = dataConvertedJSON[0]['result'];
                  print("result = $result");
                  if (result == 'Success') {
                    usercontroller.isLogin.value = true;
                    usercontroller.userid.value = useridController.text;
                    _disposeSharedpreferences();
                    _saveSharedpreferences();
                    Get.offAll(const Home(), arguments: 0);
                  } else {
                    Get.snackbar('로그인', '실패');
                  }
                }
              },
              child: const Text('login'),
            ),
            ElevatedButton(
              // 회원가입
              onPressed: () {
                Get.to(const RegisterView());
              },
              child: const Text('회원가입'),
            ),
            // //카카오톡 로그인 버튼
            // //유저 상황에 따른 조건식 진행
            // ElevatedButton(
            //   onPressed: () async {
            //     if (await isKakaoTalkInstalled()) {
            //       try {
            //         await UserApi.instance.loginWithKakaoTalk();
            //          Get.to(Home(), arguments: kakaoinfo);
            //         print('카카오톡으로 로그인 성공');
            //       } catch (error) {
            //         print('카카오톡으로 로그인 실패 $error');

            //         // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
            //         // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
            //         if (error is PlatformException &&
            //             error.code == 'CANCELED') {
            //           return;
            //         }
            //         // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
            //         try {
            //           await UserApi.instance.loginWithKakaoAccount();
            //           print('카카오계정으로 로그인 성공');
            //           Get.to(Home(), arguments: kakaoinfo);
            //         } catch (error) {
            //           print('카카오계정으로 로그인 실패 $error');
            //         }
            //       }
            //     } else {
            //       try {
            //         await UserApi.instance.loginWithKakaoAccount();
            //         print('카카오계정으로 로그인 성공');
            //         Get.to(Home(), arguments: kakaoinfo);
            //       } catch (error) {
            //         print('카카오계정으로 로그인 실패 $error');
            //       }
            //     } 
            //     Get.to(Home());
            //   },
            //   child: const Text('카카오 로그인'),
            // ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Future<void> _initSharedpreferences() async {
    final prefs = await SharedPreferences.getInstance();
    useridController.text = prefs.getString('userid') ?? "";
    passwordController.text = prefs.getString('password') ?? "";

    //앱을 종료하고 다시 실행하면 SharedPreferences에 남아 있으므로 앱을 종료시 정리해야한다.
    print(useridController);
    print(passwordController);
  }

  _saveSharedpreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userid', useridController.text);
    print("shared saved!");
    setState(() {});
  }

  _disposeSharedpreferences() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
