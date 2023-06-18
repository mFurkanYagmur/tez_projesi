class SliderContentModel {
  String? beforeSliderText;
  String? afterSliderText;
  List<String>? sliderContent;
  String? partiUrl;

  SliderContentModel();

  SliderContentModel.fromMap(Map<String, dynamic> map) {
    beforeSliderText = map['beforeSliderText'];
    afterSliderText = map['afterSliderText'];
    sliderContent = map['sliderContent'];
    partiUrl = map['partiUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'beforeSliderText': beforeSliderText,
      'afterSliderText': afterSliderText,
      'sliderContent': sliderContent,
      'partiUrl': partiUrl,
    };
  }

  @override
  String toString() {
    return 'SliderContentModel{beforeSliderText: $beforeSliderText, afterSliderText: $afterSliderText, sliderContent: $sliderContent, partiUrl: $partiUrl}';
  }
}