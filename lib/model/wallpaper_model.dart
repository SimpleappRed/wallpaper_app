class WallpaperModel {
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;

  WallpaperModel(
      {  required this.url,
       required this.photographer,
     required this.photographerId,
      required this.photographerUrl,
        required this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        url: jsonData["url"],
        photographer: jsonData["photographer"],
        photographerId: jsonData["photographer_id"],
        photographerUrl: jsonData["photographer_url"],
        src: SrcModel.fromMap(jsonData["src"]));
  }

}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel({  required this.portrait, required  this.landscape, required this.large,  required this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}
