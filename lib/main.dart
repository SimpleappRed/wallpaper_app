import 'package:flutter/material.dart';
import 'package:wallpaper_app/home.dart';

void main() {
  runApp(Myapp());

}

class Myapp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Wallpaper',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Home(),
    );
  }
}

