import 'dart:io';

import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  late List<String> recommendedList;
  late List<String> recommendedAuthor;

  @override
  void initState() {
    super.initState();
    recommendedList = [];
    recommendedAuthor = [];
    addFun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today PhotoGrapher'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Image.asset(
                  'images/banner.png',
                  width: MediaQuery.of(context).size.width*0.6,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('PhotoGraphers'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: ListView.builder(
                  // count = 보여줄것
                  itemCount: recommendedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        children: [
                          Image.asset(
                            recommendedList[index],
                            width: 250,
                            height: 100,
                            fit: BoxFit.fitWidth,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 30)
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Text('${recommendedAuthor[index].toString()} 작가'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addFun(){
    recommendedList.add('images/author1.png');
    recommendedAuthor.add('Lucia');
    recommendedList.add('images/author2.png');
    recommendedAuthor.add('Rain');
    recommendedList.add('images/author3.png');
    recommendedAuthor.add('Edward');
  }
}


