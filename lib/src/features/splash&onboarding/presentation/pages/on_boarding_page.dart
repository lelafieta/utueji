import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:utueji/src/config/routes/app_routes.dart';
import 'package:utueji/src/core/resources/images/app_images.dart';

import '../../../../config/themes/app_colors.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  ValueNotifier<double> valueNotifier = ValueNotifier<double>(30);

  final List<Map<String, String>> pages = [
    {
      'title': 'Faça\nDoações',
      'description':
          'A sua contribuição importa, doe agora e seja catalisador para impacto positivo',
      'imagePath': AppImages.splash1, // Substitua por AppImages.splash1
    },
    {
      'title': 'Começe\numa Campanha',
      'description': 'Levante a mão e apoie as pessoas que precisam de ajuda',
      'imagePath': AppImages.splash2, // Substitua por AppImages.splash2
    },
    {
      'title': 'Conecte com\nas pessoas',
      'description':
          'Unir corações, unir mãos: juntos, capacitamos a mudança para ONGs',
      'imagePath': AppImages.splash3, // Substitua por AppImages.splash3
    },
  ];

  int paginateIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: pages.length,
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                paginateIndex = value;
                if (value == 0) {
                  valueNotifier.value = 30;
                } else if (value == 1) {
                  valueNotifier.value = 75;
                } else if (value == 2) {
                  valueNotifier.value = 100;
                } else {
                  Get.toNamed(AppRoutes.loginRoute);
                }
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(
                context,
                title: pages[index]['title']!,
                description: pages[index]['description']!,
                imagePath: pages[index]['imagePath']!,
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              // color: Colors.red,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: _dotController(),
                    ),
                  ),
                  ValueListenableBuilder<double>(
                    builder: (context, value, _) {
                      return InkWell(
                        onTap: () {
                          if (paginateIndex == 2) {
                            Get.toNamed(AppRoutes.loginRoute);
                          } else {
                            _controller.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: (paginateIndex == 2)
                                ? Colors.green
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: DashedCircularProgressBar.square(
                            dimensions: 50,
                            progress: value,
                            maxProgress: 100,
                            startAngle: 0,
                            foregroundColor: Colors.green,
                            backgroundColor: Colors.white,
                            foregroundStrokeWidth: 7,
                            backgroundStrokeWidth: 7,
                            foregroundGapSize: 5,
                            foregroundDashSize: 55,
                            backgroundGapSize: 5,
                            backgroundDashSize: 55,
                            animation: false,
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: (paginateIndex == 2)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                    valueListenable: valueNotifier,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Container(
              // color: Colors.red,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pages[paginateIndex]['title']!,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(height: 1.2, color: AppColors.whiteColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    pages[paginateIndex]['description']!,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _dotController() {
    double selectedWidth = 20;
    double selectedHeight = 6;

    double unSelectedWidth = 6;
    double unSelectedHeight = 6;

    return Row(
      children: [
        Container(
          width: (paginateIndex == 0) ? selectedWidth : unSelectedWidth,
          height: (paginateIndex == 0) ? selectedHeight : unSelectedHeight,
          decoration: BoxDecoration(
            color: (paginateIndex == 0) ? Colors.white54 : Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: (paginateIndex == 1) ? selectedWidth : unSelectedWidth,
          height: (paginateIndex == 1) ? selectedHeight : unSelectedHeight,
          decoration: BoxDecoration(
            color: (paginateIndex == 1) ? Colors.white54 : Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: (paginateIndex == 2) ? selectedWidth : unSelectedWidth,
          height: (paginateIndex == 2) ? selectedHeight : unSelectedHeight,
          decoration: BoxDecoration(
            color: (paginateIndex == 2) ? Colors.white54 : Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ],
    );
  }

  Widget _buildPage(BuildContext context,
      {required String title,
      required String description,
      required String imagePath}) {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black54,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: MediaQuery.of(context).size.height / 2,
          bottom: 0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black45,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
