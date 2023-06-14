enum PageType {
  grid,
  album,
  text,
}

extension PageTypeExtension on PageType {
  String getTitle(){
    switch(this) {
      case PageType.grid: return 'Grid';
      case PageType.album: return 'Albüm';
      case PageType.text: return 'Yazı';
    }
  }
}