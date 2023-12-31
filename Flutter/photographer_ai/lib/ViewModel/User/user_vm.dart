import 'dart:ffi';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserController extends GetxController{

  RxString userid = ''.obs;
  RxBool isLogin = false.obs;


  // 유저 회원가입
  Future<bool> userRegister(id, password) async {
    var url = Uri.parse('http://flask.okrie.kro.kr:8000/auth/user/register');
    var headers = {'accept': 'application/json', 'Content-Type': 'application/json',};
    var body = jsonEncode({'id': id, 'password': password});
    var response = await http.post(
      url,
      headers: headers,
      body: body
    );

    if (response.statusCode == 201){
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      String result = dataConvertedJSON[0]['result'];
      print("result = $result");
      if (result == 'Success') {
        return true;
      } else{
        Get.snackbar(
          '회원가입에 실패하셨습니다.',
          '동일한 아이디가 존재 합니다.',
        );
      }
    }
    return false;
  }

  // 유저 로그인
  Future<bool> userLogin(id, password) async {
    var url = Uri.parse('http://flask.okrie.kro.kr:8000/auth/user');
    var headers = {'accept': 'application/json', 'Content-Type': 'application/json',};
    var body = jsonEncode({'id': id, 'password': password});
    var response = await http.post(
      url,
      headers: headers,
      body: body
    );

    if (response.statusCode == 201){
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      String result = dataConvertedJSON[0]['result'];
      print("result = $result");
      if (result == 'Success') {
        return true;
      } else{
        Get.snackbar(
          '회원가입에 실패하셨습니다.',
          '동일한 아이디가 존재 합니다.',
        );
      }
    }
    return false;
  }

}