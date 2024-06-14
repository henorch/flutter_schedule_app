import 'package:flutter/material.dart';
import '../../model/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40.0),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(model.image),
            height:  model.height * 0.45,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TextDisplay(context, model.title, 30.0),
              _TextDisplay(context, model.subTitle, 20.0),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
         _TextDisplay(context, model.counter, 30.0),
        ],
      ),
    );
  }

  Text _TextDisplay(context, title, font_size) {
    return Text(
      title,
      style: TextStyle(
        fontSize: font_size,
        fontFamily: 'PoetsenOne',
      ),
    );
  }
}
