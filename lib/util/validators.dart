class Validators {
  static String? requiredTextValidator(String? s, [int? minLength = 0]) {
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (minLength != null && s.length < minLength) {
      return '$minLength karakterden az olamaz.';
    }
    return null;
  }

  static String? numberValidator(String? s) {
    var regex = RegExp(r'^[0-9]*$');
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (!regex.hasMatch(s)) {
      return 'Hatalı sayı girişi. Sadece rakamları kullanınız';
    }
    return null;
  }
}