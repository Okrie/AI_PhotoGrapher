import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';


class AuthorController extends GetxController{

  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  RxBool pload = false.obs;
  RxInt pseq = 99.obs;

  // 작가의 데이터를 받아온다
  Future<List<Map<String, dynamic>>> fetchAuthors() async {
    if (!pload.value){
      final response = await http.get(Uri.parse('http://flask.okrie.kro.kr:8000/getauthors'));

      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        for (var item in list) {
          Map<String, dynamic> resultJson = item;
          data.add(resultJson);
        }
        pload.value = true;
        return data;
      } else {
        throw Exception('Failed to connect Server');
      }
    } else {
      return data;
    }
  }

  // 작가의 데이터를 받아온다
  Future<List<Map<String, dynamic>>> fetchAuthorsHive() async {
    if (!pload.value){
      final response = await Hive.openBox('authors').toString();
      if (response != null) {
        var list = response;
        // 수정 중 
        
        pload.value = true;
        return data;
      } else {
        throw Exception('Failed to connect Server');
      }
    } else {
      return data;
    }
  }
}