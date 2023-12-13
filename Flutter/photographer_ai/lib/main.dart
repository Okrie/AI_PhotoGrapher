import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photographer_ai/View/home.dart';
import 'package:photographer_ai/ViewModel/Camera/camera_vm.dart';

Future<void> main() async{
  // Init Hive
  await Hive.initFlutter();
  await Hive.openBox('testbox');

  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  final cameraController = Get.put(CameraViewController());
  await initialization(null, cameraController);

  runApp(const MyApp());
}

Future initialization(BuildContext? context, CameraViewController cameraController) async{
  /// Load Resources
  await Future.delayed(const Duration(seconds: 2));

  // Ensure that the camera is initialized.
  await cameraController.initializeCamera();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AI PhotoGrapher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}