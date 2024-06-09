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
      padding: EdgeInsets.all(40.0),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(model.image),
            height: model.height * 0.45,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'PoetsenOne',
                ),
              ),
              Text(
                model.subTitle,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            model.counter,
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'PoetsenOne',
            ),
          ),
        ],
      ),
    );
  }
}
