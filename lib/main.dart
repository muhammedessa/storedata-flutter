import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  var myStoredData = await readData();

  if(myStoredData != null){
    print(myStoredData);
  }

  runApp(new MaterialApp(
     home: new Home() ,
    title: 'Muhammed Essa' ,
  ));
}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }

}

class HomeState extends State<Home>{

  TextEditingController myController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Store Data'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: new Container(
        padding: EdgeInsets.only(top: 55.9),
        margin: EdgeInsets.all(22.2),
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: 'Please put your name',
                icon: new Icon(
                  Icons.storage,
                  color: Colors.deepPurple,
                  size: 22.2,
                ),

              ),
            ),

            new Padding(padding: EdgeInsets.only(top: 12.0)),
            new RaisedButton(onPressed: (){
              writeData(myController.text);
              print('saved !');
            },
              child: new Text(
                'Save',
                style: new TextStyle(
                  fontSize: 22.2,
                  color: Colors.deepPurple,
                ),),
            ),

            new Padding(padding: EdgeInsets.only(top: 12.0)),
            new FutureBuilder(
              future: readData(),
                builder: (BuildContext context , AsyncSnapshot<String> data){
                  if(data.hasData != null){
                   return new Text(
                     '${data.data.toString()}',
                     style: new TextStyle(
                       fontSize: 52.2,
                       color: Colors.blue,
                     ),);
                  }else{
                    return new Text(
                      'No data saved !',
                      style: new TextStyle(
                        fontSize: 22.2,
                        color: Colors.blue,
                      ),);
                  }

                }
            )


          ],
        ),
      ),
    );
  }

}

Future<String> get localPath async{
  final path = await getApplicationDocumentsDirectory();
  return path.path;
}

Future<File> get localFile  async{
  final file = await localPath;
  return new File('$file/data.txt');
}


Future<File>   writeData(String value)  async{
  final file = await localFile;
  return file.writeAsString('$value');
}

Future<String> readData() async{

  try{
    final file = await localFile;
    String data = await file.readAsString();
        return data;
}catch(e){
    return 'error: empty file';
}

}