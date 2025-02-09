import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utueji/src/core/resources/icons/app_icons.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/images/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                AppImages.me,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppIcons.heart,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppIcons.bell,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              children: [
                Text(
                  "Olá! Lela Fieta",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 5),
                Image.asset(
                  AppImages.wave,
                  width: 16,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Text(
              "Sua mudança torna algumas vidas melhores",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Pesquise campanhas, caridades...",
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    AppIcons.search,
                    width: 14,
                    color: Colors.grey,
                  ),
                ),
                suffixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    AppIcons.microphone,
                    width: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                enableInfiniteScroll: false,
                padEnds: false,
                viewportFraction: 0.93,
              ),
              carouselController: CarouselSliderController(),
              items: [1, 2, 3, 4, 5].map((i) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.blue,
                        AppColors.primaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "JUNTOS",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "PODEMOS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "OFEREÇA\nO SEU TEMPO",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                "Trabalho em equipe faz o sonho funcionar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Image.asset(AppImages.child)
                    ],
                  ),
                );
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Text(
                        'text $i',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 90,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      child: Container(
                        width: 60,
                        height: 60,
                        child: Center(child: Text("2")),
                      ),
                    ),
                    const Text("Medical"),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: [
        SafeArea(
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Image.asset(
                  AppImages.me,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            // title: Text("data"),
            trailing: Container(
              width: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppIcons.heart,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppIcons.bell,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
