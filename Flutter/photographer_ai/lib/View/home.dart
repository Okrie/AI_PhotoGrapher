import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photographer_ai/View/camera.dart';
import 'package:photographer_ai/View/filter.dart';
import 'package:photographer_ai/View/login/login.dart';
import 'package:photographer_ai/View/mainview.dart';
import 'package:photographer_ai/View/mypage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  // Property
  late TabController _tabController;
  late bool login;
  var index = Get.arguments ?? 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.index = index != 0 ? index[0] : 0;
    login = false;
    _initSharedpreferences();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: login 
        ? const [
          MainView(),
          CameraView(),
          PhotoGrapherFilter(),
          MyPageView()
        ]
        : const [
          MainView(),
          CameraView(),
          PhotoGrapherFilter(),
          LoginView()
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.blue,
        
        tabs: login
        ? const [
          Tab(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            child: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 62, 53, 194),
            ),
            child: Text('Camera'),
          ),
          Tab(
            icon: Icon(
              Icons.camera,
              color: Color.fromARGB(255, 62, 53, 194),
            ),
            child: Text('AI Filter'),
          ),
          Tab(
            icon: Icon(
              Icons.manage_accounts,
              color: Color.fromARGB(255, 191, 207, 102),
            ),
            child: Text('Mypage'),
          ),
        ]
        : const [
          Tab(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            child: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 62, 53, 194),
            ),
            child: Text('Camera'),
          ),
          Tab(
            icon: Icon(
              Icons.camera,
              color: Color.fromARGB(255, 62, 53, 194),
            ),
            child: Text('AI Filter'),
          ),
          Tab(
            icon: Icon(
              Icons.account_circle,
              color: Color.fromARGB(255, 191, 207, 102),
            ),
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  Future<void> _initSharedpreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // userid = prefs.getString('userid') ?? "";
    // password = prefs.getString('password') ?? "";
    // login = userid.trim().isEmpty;
    setState(() {
      
    });
  }
  
  Future<void> _disposeSharedpreferences() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear(); 
  }
}