extension StringFormat on String {
  String toUpperCaseLocalized() {
    return replaceAll('ğ', 'Ğ').replaceAll('ü', 'Ü').replaceAll('ş', 'Ş').replaceAll('i', 'İ').replaceAll('ö', 'Ö').replaceAll('ç', 'Ç').toUpperCase();
  }

  String toLowerCaseLocalized() {
    return replaceAll('Ğ', 'ğ').replaceAll('Ü', 'ü').replaceAll('Ş', 'ş').replaceAll('İ', 'i').replaceAll('Ö', 'ö').replaceAll('Ç', 'ç').toLowerCase();
  }
}