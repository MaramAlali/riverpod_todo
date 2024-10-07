import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:riverpod_todo/common/utlis/app_const.dart';
import 'package:riverpod_todo/common/widgets/reusable.dart';
import 'package:riverpod_todo/common/widgets/width_spacer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/widgets/app_style.dart';
import '../widgets/page_one.dart';
import '../widgets/page_two.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}
class _OnBoardingState extends State<OnBoarding> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              PageOne(),
              PageTwo(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.ease);
                        },
                        child: const Icon(
                          Ionicons.chevron_forward_circle,
                          size: 30,
                          color: AppConst.white,
                        ),
                      ),
                      const WidthSpacer(width: 5),
                      ReusableText(
                          text: "Skip",
                          style: appStyle(50, AppConst.white, FontWeight.w500)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.ease);
                    },
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 2,
                      effect: const WormEffect(
                        dotColor: AppConst.grey,
                        spacing: 5,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
