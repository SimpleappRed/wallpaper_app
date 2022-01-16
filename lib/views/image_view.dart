import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// import 'package:flutter/foundation.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';


import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:wallpaper_app/Widget/widget.dart';
// import 'package:wallpaper_app/data/data.dart';
// import 'package:flutter/foundation.dart';


import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
class ImageView extends StatefulWidget {
  final String imgUrl;

  ImageView({required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
   Future<void>  setwallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    String result = await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

 
  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
          
                  child: Image.network(widget.imgUrl, fit: BoxFit.cover)
             
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      setwallpaper();
                        // _save();
                    
                      //Navigator.pop(context);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white24, width: 1),
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Set Wallpaper",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  
                                     
                                      "Image will be saved in gallery",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white70),
                                ),
                              ],
                            )),
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//   _save() async {
//     if(Platform.isAndroid){
//  await _askPermission();
//     }
   
//     var response = await Dio().get(widget.imgUrl,
//         options: Options(responseType: ResponseType.bytes));
//     final result =
//         await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//     print(result);
//     Navigator.pop(context);
//   }

//  _askPermission()  {
//     if (Platform.isIOS) {
//       /*Map<PermissionGroup, PermissionStatus> permissions =
//           */PermissionHandler()
//               .requestPermissions([PermissionGroup.photos]);
//     } else {
//      /* PermissionStatus permission = */ PermissionHandler()
//           .checkPermissionStatus(PermissionGroup.storage);
//     }
//   }
}