import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '郵便番号入力'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    child: Text(
                      '郵便番号',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    width: 90),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: '郵便番号を入力'),
                  ),
                ),
                OutlinedButton(
                  child: Text('検索'),
                  onPressed: () {
                    searchAddress('0010001');
                  },
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    child: Text(
                      '住所',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    width: 90),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchAddress(String zipCode) async {
    // URL
    String url = 'https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode';
    var result = await get(Uri.parse(url));

    // json形式(key/value)なのでMapを使用
    Map<String, dynamic> data = jsonDecode(result.body);
    // 後は呼び出し元に返却でも出力でも任意の操作で！
    print(data);
  }
}
