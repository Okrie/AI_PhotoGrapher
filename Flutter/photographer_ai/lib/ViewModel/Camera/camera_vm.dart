import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraViewController extends GetxController {
  late CameraController _controller;
  late List<CameraDescription> _cameras;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras.first, ResolutionPreset.medium);

    await _controller.initialize();

    update(); // 상태 변경 알림
  }

  CameraController get controller => _controller;

  @override
  void onClose() {
    super.onClose();
    _controller.dispose();
  }
}
