import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photographer_ai/Model/aiImage/ai_image.dart';

class FilterController extends GetxController{

  RxString image = ''.obs;
  RxBool isLoaded = false.obs;
  RxBool imgLoad = false.obs;
  RxList<AiImage> aiImageList = <AiImage>[].obs;
  

  Future<void> getImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: imageSource);
    
    if (pickedImage != null) {
      image.value = XFile(pickedImage.path).path;
    } else{
      image.value = '';
    }
  }
}