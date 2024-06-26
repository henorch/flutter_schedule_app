import 'dart:ui';

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;
  final Color bgColor;
  final String counter;
  final double height;

  OnBoardingModel(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.bgColor,
      required this.height,
      required this.counter});
}
