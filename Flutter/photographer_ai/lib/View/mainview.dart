import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  late List<int> recommendedList;

  @override
  void initState() {
    super.initState();
    recommendedList = [];
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
                child: Image.network(
                  'https://img.lovepik.com/free-png/20210919/lovepik-vector-material-of-black-vip-banner-design-png-image_400382402_wh1200.png',
                  width: MediaQuery.of(context).size.width*0.6,
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
                          Image.network(
                            'https://thumb.silhouette-ac.com/t/09/098cf87b0e781687780c8fbb9c7a5872_t.jpeg',
                            //'${recommendedList[index].toString()}',
                            height: 100,
                            width: 300,
                          ),
                          SizedBox(
                            height: 100,
                            width: 50,
                            child: Center(
                              child: Text('${recommendedList[index].toString()} 작가'),
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
    recommendedList.add(1);
    recommendedList.add(2);
    recommendedList.add(3);
  }
}


