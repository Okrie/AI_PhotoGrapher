import 'package:flutter/material.dart';
import 'package:photographer_ai/View/user/mypage_detail.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
        centerTitle: true,
      ),
      body: UserDetail(),
    );
  }
}