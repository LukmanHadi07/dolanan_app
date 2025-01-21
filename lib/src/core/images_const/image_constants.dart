class ImageConstants {
  ImageConstants._init();
  static ImageConstants? _instace;
  static ImageConstants get instance => _instace ??= ImageConstants._init();
  String get textBanner => toPng("banner");
  String get garudaKencanaImage => toPng("wisnu");
  String toJpg(String name) => "assets/images/$name.jpg";
  String toSvg(String name) => "assets/images/$name.svg";
  String toPng(String name) => "assets/images/$name.png";
}
