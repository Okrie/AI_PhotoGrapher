import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class PurchaseController{
  RxBool isLoad = false.obs;
  RxInt seq = 99.obs;
  RxBool isView = false.obs;
  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;


  // 필터 조회 및 구매
  Future<List<Map<String, dynamic>>> fetchFilter(userid) async {
    if (!isLoad.value){
      if (isView.value){
        var url = Uri.parse('http://flask.okrie.kro.kr:8000/userinfo?userid=${userid}');
        var response = await http.get(url);
        if (response.statusCode == 201) {
          List<dynamic> list = jsonDecode(response.body)[0]['result'];
          for (var item in list) {
            Map<String, dynamic> resultJson = item;
            data.add(resultJson);
          }
          isLoad.value = true;
          return data;
        } else {
          throw Exception('Failed to connect Server');
        }
      } else {
        return data;
      }
    }
    return data;
  }


  // 필터 조회 및 구매
  Future<List<Map<String, dynamic>>> fetchFilterHive(userid) async {
    await Hive.openBox("filter");
    print("result = ${Hive.box("filter").get(userid)}");

    if(Hive.box("filter").get(userid) != null){
      data = Hive.box("filter").get(userid);
      if (isView.value){
        List list = data;

        isLoad.value = true;
        return data;
      } else {
        throw Exception('구매한 필터가 없어요!');
      }
    }

    return data;
  }

  // Nickname 가져오기
  String getNicknameBySeq(List<Map<String, dynamic>> data, int seq) {
    for (var item in data) {
      if (item['seq'] == seq) {
        return item['pnickname'];
      }
    }
    return ''; // 해당 seq를 가진 아이템이 없을 경우 빈 문자열 반환 또는 원하는 예외 처리 추가
  }
}