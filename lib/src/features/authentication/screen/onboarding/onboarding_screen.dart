import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:world_times/pages/login.dart';
import 'package:world_times/src/constants/color.dart';
import 'package:world_times/src/constants/image_strings.dart';
import 'package:world_times/src/constants/text_string.dart';
import '../../model/model_on_boarding.dart';
import 'onboardingpagewidget.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      OnBoardingPageWidget(
          model: OnBoardingModel(
              image: honBoardingImage1,
              title: honboardingTitle1,
              subTitle: honboardingSubtitle1,
              bgColor: honBoardingPage1Color,
              height: size.height,
              counter: honboardingCount1)),
      OnBoardingPageWidget(
          model: OnBoardingModel(
              image: honBoardingImage2,
              title: honboardingTitle2,
              subTitle: honboardingSubtitle2,
              bgColor: honBoardingPage2Color,
              height: size.height,
              counter: honboardingCount2)),
      OnBoardingPageWidget(
          model: OnBoardingModel(
              image: honBoardingImage3,
              title: honboardingTitle3,
              subTitle: honboardingSubtitle3,
              bgColor: honBoardingPage3Color,
              height: size.height,
              counter: honboardingCount3)),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            liquidController: controller,
            waveType: WaveType.liquidReveal,
            pages: pages,
            onPageChangeCallback: OnPageChangeCallback,
            slideIconWidget: Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
              top: 80.0,
              right: 30.0,
              child: OutlinedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black),
                    foregroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: () => {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()))
                },
                child: const Text(
                  "SKIP",
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
              bottom: 60.0,
              child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      side: const BorderSide(color: Colors.black),
                      shape: const CircleBorder()),
                  onPressed: () {
                    int nextPage = controller.currentPage + 1;
                    controller.animateToPage(page: nextPage);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )))),
          Positioned(
              bottom: 10.0,
              child: AnimatedSmoothIndicator(
                  effect: const WormEffect(
                    activeDotColor: Colors.purple,
                    dotHeight: 10.0,
                  ),
                  activeIndex: controller.currentPage,
                  count: 3))
        ],
      ),
    );
  }

  void OnPageChangeCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
