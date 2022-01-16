import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';

Widget brandname() {
  return RichText(text:TextSpan(text:'',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
  children: <TextSpan>[
    TextSpan(text:'Wallpaper',style: TextStyle(color:Colors.black87)),
   TextSpan(text:'Hub',style: TextStyle(color:Colors.blue))
  ]));
}


Widget wallpapersList({required List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
                     onTap: () {
  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageView(
                imgUrl: wallpaper.src.portrait,
              )
            ));
              },
              child: Hero(
                tag: wallpaper.src.portrait,
                child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          wallpaper.src.portrait,
                          fit: BoxFit.cover,
                        ))),
              ),
            ));
      }).toList(),
    ),
  );
}
