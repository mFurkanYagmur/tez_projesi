class SliderContentModel {
  String? beforeSliderText;
  String? afterSliderText;
  List<String>? sliderContent;
  String? partiUrl;
  String? backgroundImage;
  String? instagramUrl;
  String? facebookUrl;
  String? twitterUrl;

  SliderContentModel();

  SliderContentModel.fromMap(Map<String, dynamic> map) {
    beforeSliderText = map['beforeSliderText'];
    afterSliderText = map['afterSliderText'];
    sliderContent = (map['sliderContent'] as List).map((e) => e as String).toList();
    partiUrl = map['partiUrl'];
    backgroundImage = map['backgroundImage'];
    instagramUrl = map['instagramUrl'];
    facebookUrl = map['facebookUrl'];
    twitterUrl = map['twitterUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'beforeSliderText': beforeSliderText,
      'afterSliderText': afterSliderText,
      'sliderContent': sliderContent,
      'partiUrl': partiUrl,
      'backgroundImage': backgroundImage,
      'instagramUrl': instagramUrl,
      'facebookUrl': facebookUrl,
      'twitterUrl': twitterUrl,
    };
  }

  @override
  String toString() {
    return 'SliderContentModel{beforeSliderText: $beforeSliderText, afterSliderText: $afterSliderText, sliderContent: $sliderContent, partiUrl: $partiUrl, backgroundImage: $backgroundImage, instagramUrl: $instagramUrl, facebookUrl: $facebookUrl, twitterUrl: $twitterUrl}';
  }
}