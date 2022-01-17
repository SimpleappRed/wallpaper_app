import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/Widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';

class Search extends StatefulWidget {
    String searchquery;

  Search({@required this.searchquery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController serachcontroller = new TextEditingController();
  List<WallpaperModel> wallpapers = [];

  getsearchwallpaper(String query) async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=100"),
        headers: {"Authorization": apikey});
    print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      WallpaperModel wallpaperModel = WallpaperModel(
        url: jsonData["url"],
        photographer: jsonData["photographer"],
        photographerId: jsonData["photographer_id"],
        photographerUrl: jsonData["photographer_url"],
        src: SrcModel.fromMap(jsonData["src"]));;
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
      //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
    });
    //it creates the newly updated screen
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getsearchwallpaper(widget.searchquery);
    serachcontroller.text = widget.searchquery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandname(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Row(children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: serachcontroller,
                      decoration: InputDecoration(
                          hintText: "Search Wallpaper",
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getsearchwallpaper(serachcontroller.text);
                    },
                    child: Container(child: Icon(Icons.search)),
                  )
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              wallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
