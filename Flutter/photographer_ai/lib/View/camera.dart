import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:photographer_ai/View/home.dart';
import 'package:photographer_ai/ViewModel/Camera/camera_vm.dart';
import 'package:photographer_ai/ViewModel/filter/filter_vm.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView>{

  final CameraViewController cameraController = Get.find();
  final _filController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[200],
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Attempt to take a picture and then get the location
            // where the image file is saved.
            final image = await cameraController.controller.takePicture();

            _filController.image.value = image.path;

            if (!mounted) return;

            _filController.imgUpLoad.value = true;
            // If the picture was taken, display it on a new screen.
            await Get.offAll(() => const Home(), arguments: 2);

          } catch (e) {
            // If an error occurs, log the error to the console.
            Text('권한이 없어 이용 할 수 없어요.');
            print(e);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: Center(
        child:
        (cameraController.controller.value.isInitialized)
              ? CameraPreview(cameraController.controller)
              : const Center(child:CircularProgressIndicator()),
      ),
    );
  }
}