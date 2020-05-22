import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutterapp/app_screen/first_screen.dart';

void main() =>  runApp(new MyFlutterApp());


class MyFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
        debugShowCheckedModeBanner: false,
        title: "Lucky Number Generator",
        home: Scaffold(
          appBar: AppBar(title: Text("Lucky Number Generator"),),
          body: FirstScreen(),
        )
    );
    throw UnimplementedError();
  }

}