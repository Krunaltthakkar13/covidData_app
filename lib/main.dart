import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

import 'Headers.dart';

void main() {
  runApp(listViewApp());
}

class listViewApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<Headers>;
              return ListView.builder(
                  itemCount: items == null ? 0 : items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          items[index].fieldOne.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldTwo.toString()),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldThree.toString()),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldFour.toString()),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldFive.toString()),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldSix.toString()),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldSeven.toString()),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldEight.toString()),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldNine.toString()),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(items[index].fieldTen.toString()),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
    );
  }

  Future<List<Headers>> ReadJsonData() async {

    List<Headers> lstModelData=<Headers>[];
    final jsondatas = await rootBundle.rootBundle.loadString("assets/covid-19.json");
    final lists = json.decode(jsondatas);

    var jsonFieldsData=lists["fields"];
    List<String> listDataHeader = <String>[];
    for(int i=0;i<jsonFieldsData.length;i++){
      var strLable=jsonFieldsData[i];
      String strLabless=strLable["label"];
      listDataHeader.add(strLabless);
    }
    var jsonDatas=   lists["data"];
    List<List<String>> rowDataCollection = [];
    for(int i=0;i<jsonDatas.length;i++) {
      var lblStr = jsonDatas[i];
      Headers data=new Headers();
      data.fieldOne=listDataHeader[0]+" : "+lblStr[0];
      data.fieldTwo=listDataHeader[1]+" : "+lblStr[1];
      data.fieldThree=listDataHeader[2]+" : "+lblStr[2];
      data.fieldFour=listDataHeader[3]+" : "+lblStr[3];
      data.fieldFive=listDataHeader[4]+" : "+lblStr[4];
      data.fieldSix=listDataHeader[5]+" : "+lblStr[5];
      data.fieldSeven=listDataHeader[6]+" : "+lblStr[6];
      data.fieldEight=listDataHeader[7]+" : "+lblStr[7];
      data.fieldNine=listDataHeader[8]+" : "+lblStr[8];
      data.fieldTen=listDataHeader[9]+" : "+lblStr[9];
      lstModelData.add(data);
      List<String> listDataRow = <String>[];
      for (int i = 0; i < lblStr.length; i++) {
        listDataRow.add(lblStr[i]);

      }
      rowDataCollection.add(listDataRow);
    }
    return lstModelData;
  }
}

