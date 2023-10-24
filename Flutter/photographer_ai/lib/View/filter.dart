import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoGrapherFilter extends StatefulWidget {
  const PhotoGrapherFilter({super.key});

  @override
  State<PhotoGrapherFilter> createState() => _PhotoGrapherFilterState();
}

class _PhotoGrapherFilterState extends State<PhotoGrapherFilter> {

  var value = Get.arguments ?? '__';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI PhotoGrapher'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: value == '__' ?
              const Text('Select Image')
              : Image.file(
                File(value[1]),
                
              ),
            ),

          ],
        ),
      ),
    );
  }
}