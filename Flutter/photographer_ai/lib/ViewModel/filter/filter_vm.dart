import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class FilterController extends GetxController{

  RxString image = ''.obs;
  RxBool isLoaded = false.obs;
  RxBool imgUpLoad = false.obs;
  // RxList<AiImage> aiImageList = <AiImage>[].obs;
  

  Future<void> getImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: imageSource);
    
    if (pickedImage != null) {
      image.value = XFile(pickedImage.path).path;
      imgUpLoad.value = true;
    } else{
      image.value = '';
    }
  }

  // 선택, 올린 스크린샷 기준으로 이미지 업로드
  Future<void> uploadImage() async {
    // 서버의 엔드포인트 URL
    var uri = Uri.parse('http://121.130.179.94:8000/pred');

    // MultipartRequest
    var request = http.MultipartRequest('POST', uri);

    // 이미지 파일을 MultipartFile로 변환
    var multipartFile = await http.MultipartFile.fromPath(
      'image', // 서버가 요구하는 파라미터명
      image.value,
      contentType: MediaType('image', 'jpeg'),
    );

    // MultipartFile을 request에 추가
    request.files.add(multipartFile);

    // request를 서버로 보냄
    var response = await request.send();

    // 응답 확인
    if (response.statusCode == 200) {
      print('Image uploaded successfully.');
      imgUpLoad.value = true;
    } else {
      print('Image upload failed.');
      imgUpLoad.value = false;
    }
  }


  // 여러개의 생성된 이미지를 받아온다.
  Future<List<String>> fetchImages() async {
    if (!imgUpLoad.value){

      final response = await http.get(Uri.parse('http://121.130.179.94:8000/pred'));

      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        List<String> images = [];

        for (var item in list) {
          if (item is Map) {
            List<dynamic> results = item['result']; // 'result' 키의 값이 리스트
            for (var res in results) {
              Map<String, dynamic> resultJson = jsonDecode(res); // 리스트의 각 요소는 문자열로 된 JSON
              String imageBase64 = resultJson['image']; // JSON에서 'image' 키의 값을 가져옴
              images.add(imageBase64);
            }
          }
        }
        
        return images;
      } else {
        throw Exception('Failed to load images');
      }    
    } else {
      throw Exception('Failed to Upload images');
    }
  }

  // 이미지 업로드 후 이미지 데이터 가져오기
  Future<List<String>> uploadImageAndFetchData() async {
    var uri = Uri.parse('http://121.130.179.94:8000/pred'); // 이미지 업로드 및 데이터 가져올 URL

    var request = http.MultipartRequest('POST', uri);

    var multipartFile = await http.MultipartFile.fromPath(
      'image', // 서버가 요구하는 파라미터명
      image.value,
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully.');

      var responseData = await response.stream.bytesToString();
      List<dynamic> list = jsonDecode(responseData);
      List<String> images = [];

      for (var item in list) {
        if (item is Map) {
          List<dynamic> results = item['result'];
          for (var res in results) {
            Map<String, dynamic> resultJson = jsonDecode(res);
            String imageBase64 = resultJson['image'];
            images.add(imageBase64);
          }
        }
      }

      return images;
    } else {
      print('Image upload failed.');
      throw Exception('Failed to upload image');
    }
  }
}