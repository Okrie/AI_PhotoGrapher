import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:photographer_ai/View/filter.dart';
import 'package:photographer_ai/View/home.dart';
import 'package:photographer_ai/ViewModel/Camera/camera.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView>{

  final cameraController = Get.put(CameraViewController()); // 카메라 컨트롤러 인스턴스 생성 및 등록

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
            // Ensure that the camera is initialized.
            await cameraController.initializeCamera();

            // Attempt to take a picture and then get the location
            // where the image file is saved.
            final image = await cameraController.controller.takePicture();

            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            await Get.offAll(() => const Home(), arguments: [2, image.path]);

          } catch (e) {
            // If an error occurs, log the error to the console.
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
        // You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        FutureBuilder<void>(
          future: cameraController.initializeCamera(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(cameraController.controller);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  

}