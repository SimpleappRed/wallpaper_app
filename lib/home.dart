import 'dart:convert';



import 'package:flutter/material.dart';

import 'package:wallpaper_app/Widget/widget.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/categories_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/categorie.dart';

import 'package:wallpaper_app/views/search.dart';

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  TextEditingController serachcontroller = new TextEditingController();

  gettreandwallpaper() async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=15"),
        headers: {"Authorization": apikey});
    print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      WallpaperModel wallpaperModel =WallpaperModel(
      );
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
      //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
    });
    //it creates the newly updated screen
    setState(() {});
  }

  @override
  void initState() {
    gettreandwallpaper();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(
                                    searchquery: serachcontroller.text,
                                  )));
                    },
                    child: Container(child: Icon(Icons.search)),
                  )
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      // wallpapers[index].
                      return CategoriesTile(
                          title: categories[index].categorieName,
                          imgUrl: categories[index].imgUrl);
                    }),
              ),
              SizedBox(
                height: 16,
              ),
              wallpapersList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}

//!categories tiels
class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;

  CategoriesTile({Key key, @required this.imgUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Catagory(
                categorieName: title.toLowerCase(),
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget>[
           
             
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imgUrl,
                      height: 50,
                      width: 100,
                      fit: BoxFit.cover,
                    )),
           
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );

 }


 
}
// api key - 563492ad6f917000010000011e608929d503495699bfb1d548acc5e3
