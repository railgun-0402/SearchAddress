import 'package:flutter/material.dart';

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
                    print('pressButton');
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
}
