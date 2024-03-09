enum ImageJPG { background_image }

extension ImageJPGExtension on ImageJPG {
  String getPath() {
    return "assets/$name.jpg";
  }
}
