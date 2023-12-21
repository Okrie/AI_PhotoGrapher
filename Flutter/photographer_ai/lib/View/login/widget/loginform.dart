import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:photographer_ai/View/home.dart';
import 'package:photographer_ai/View/login/register.dart';
import 'package:photographer_ai/ViewModel/User/user_vm.dart';

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
  late var box;

  @override
  void initState() {
    super.initState();
    useridController = TextEditingController();
    passwordController = TextEditingController();
    box = Hive.openBox("user");
  }

  @override
  void dispose() {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // 회원가입
                  onPressed: () {
                    Get.to(const RegisterView());
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  child: const Text('회원가입'),
                ),
                const SizedBox(
                  height: 100,
                  width: 50,
                ),
                ElevatedButton(
                  // 로그인
                  onPressed: () async {
                  var result = await usercontroller.userLoginHive(useridController.text, passwordController.text);
                    if (result) {
                      usercontroller.isLogin.value = true;
                      usercontroller.userid.value = useridController.text;
                      Get.snackbar('Login', '${usercontroller.userid.value}님, 어서오세요');
                      Get.offAll(const Home(), arguments: 0);
                    } else {
                      Get.snackbar('로그인', '실패');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  child: const Text('login'),
                ),
              ],
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
}
