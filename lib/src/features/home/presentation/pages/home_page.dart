import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utueji/src/core/resources/icons/app_icons.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_values.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> titles = [
    "Médico",
    "Educação",
    "Olfã",
    "Animal",
    "Idosos",
    "Desporto",
    "Desastre",
    "Outros"
  ];
  List<String> iconsPath = [
    AppIcons.doctor,
    AppIcons.graduationCap,
    AppIcons.familyDress,
    AppIcons.paw,
    AppIcons.oldPeople,
    AppIcons.tennis,
    AppIcons.triangleWarning,
    AppIcons.menuDots
  ];

  @override
  void initState() {
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Column(
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
                }).toList(),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 90,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(18),
                            child: SvgPicture.asset(
                              iconsPath[index],
                              width: 12,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        Text(titles[index].toString()),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemCount: titles.length,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Necessidades Urgentes",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(onPressed: () {}, child: Text("Ver mais"))
                ],
              ),
            ),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 420.0,
                  enableInfiniteScroll: false,
                  padEnds: false,
                  viewportFraction: 0.93,
                ),
                carouselController: CarouselSliderController(),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            width: 400,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.asset(AppImages.image1),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.blue.withOpacity(.4),
                                                AppColors.primaryColor
                                                    .withOpacity(.4),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      (i != 1)
                                          ? SizedBox.shrink()
                                          : Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                width: 120,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 110, 32, 27),
                                                      Color.fromARGB(
                                                          255, 248, 101, 99),
                                                    ],
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "EMERGÊNCIA",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                )),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Dê o teu suporte para os estudos das crianças",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: SvgPicture.asset(
                                                  AppIcons.heart)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                              text: "\$ ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                            ),
                                            TextSpan(
                                              text: "1.000.000",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                            ),
                                            TextSpan(text: "/"),
                                            TextSpan(text: "800.000")
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              color: AppColors.strokeColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          Positioned(
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.6,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                color: Colors.black87,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "75%",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 16,
                                                child: Stack(
                                                  children: [
                                                    _contributeUserItem(
                                                        0,
                                                        0,
                                                        0,
                                                        AppImages.me,
                                                        Colors.black),
                                                    _contributeUserItem(
                                                        8,
                                                        0,
                                                        0,
                                                        AppImages.me,
                                                        Colors.red),
                                                    _contributeUserItem(
                                                        16,
                                                        0,
                                                        0,
                                                        AppImages.me,
                                                        Colors.green),
                                                    _contributeUserItem(
                                                        24,
                                                        0,
                                                        0,
                                                        AppImages.me,
                                                        AppColors.primaryColor,
                                                        text: "+16"),
                                                    _contributeUserDescription(
                                                        60,
                                                        0,
                                                        0,
                                                        AppImages.me,
                                                        Colors.transparent,
                                                        text: "Contributos"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.timelapse_rounded,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Faltando 2 dias",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              AppValues.s10,
                                            ), // Define o raio da borda aqui
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text("Doar"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // SizedBox(
            //   height: 400,
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     physics: const ClampingScrollPhysics(),
            //     scrollDirection: Axis.horizontal,
            //     padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: Container(
            //           width: 300,
            //           child: Column(
            //             children: [
            //               ClipRRect(
            //                 borderRadius: const BorderRadius.only(
            //                   topLeft: Radius.circular(10),
            //                   topRight: Radius.circular(10),
            //                 ),
            //                 child: Stack(
            //                   children: [
            //                     Image.asset(AppImages.image1),
            //                     Positioned(
            //                       left: 0,
            //                       right: 0,
            //                       bottom: 0,
            //                       top: 0,
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           gradient: LinearGradient(
            //                             colors: [
            //                               AppColors.blue.withOpacity(.4),
            //                               AppColors.primaryColor
            //                                   .withOpacity(.4),
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               Container(
            //                 padding: EdgeInsets.all(10),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         Expanded(
            //                           child: Text(
            //                             "Dê o teu suporte para os estudos das crianças",
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .titleSmall,
            //                           ),
            //                         ),
            //                         IconButton(
            //                             onPressed: () {},
            //                             icon: SvgPicture.asset(AppIcons.heart)),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //                     RichText(
            //                       text: TextSpan(
            //                         style: DefaultTextStyle.of(context).style,
            //                         children: [
            //                           TextSpan(
            //                             text: "\$ ",
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .titleSmall!
            //                                 .copyWith(
            //                                     fontWeight: FontWeight.bold,
            //                                     fontSize: 18),
            //                           ),
            //                           TextSpan(
            //                             text: "1.000.000",
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .titleSmall!
            //                                 .copyWith(
            //                                     fontWeight: FontWeight.bold,
            //                                     fontSize: 18),
            //                           ),
            //                           TextSpan(text: "/"),
            //                           TextSpan(text: "800.000")
            //                         ],
            //                       ),
            //                     ),
            //                     const SizedBox(
            //                       height: 10,
            //                     ),
            //                     Stack(
            //                       children: [
            //                         Container(
            //                           width: double.infinity,
            //                           height: 15,
            //                           decoration: BoxDecoration(
            //                             color: AppColors.strokeColor,
            //                             borderRadius:
            //                                 BorderRadius.circular(100),
            //                           ),
            //                         ),
            //                         Positioned(
            //                           child: Container(
            //                             width:
            //                                 MediaQuery.sizeOf(context).width *
            //                                     0.6,
            //                             height: 15,
            //                             decoration: BoxDecoration(
            //                               color: Colors.black87,
            //                               borderRadius:
            //                                   BorderRadius.circular(100),
            //                             ),
            //                             child: const Center(
            //                               child: Text(
            //                                 "75%",
            //                                 style: TextStyle(
            //                                     color: Colors.white,
            //                                     fontSize: 10,
            //                                     fontWeight: FontWeight.w600),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     const SizedBox(
            //                       height: 10,
            //                     ),
            //                     Container(
            //                       child: Row(
            //                         children: [
            //                           Expanded(
            //                             child: Container(
            //                               height: 16,
            //                               child: Stack(
            //                                 children: [
            //                                   _contributeUserItem(0, 0, 0,
            //                                       AppImages.me, Colors.black),
            //                                   _contributeUserItem(8, 0, 0,
            //                                       AppImages.me, Colors.red),
            //                                   _contributeUserItem(16, 0, 0,
            //                                       AppImages.me, Colors.green),
            //                                   _contributeUserItem(
            //                                       24,
            //                                       0,
            //                                       0,
            //                                       AppImages.me,
            //                                       AppColors.primaryColor,
            //                                       text: "+16"),
            //                                   _contributeUserDescription(
            //                                       60,
            //                                       0,
            //                                       0,
            //                                       AppImages.me,
            //                                       Colors.transparent,
            //                                       text: "Contributos"),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                           const Icon(
            //                             Icons.timelapse_rounded,
            //                             size: 16,
            //                           ),
            //                           const SizedBox(
            //                             width: 5,
            //                           ),
            //                           Text(
            //                             "Faltando 2 dias",
            //                             style: TextStyle(
            //                               fontSize: 12,
            //                             ),
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 10),
            //                 child: ElevatedButton(
            //                   style: ButtonStyle(
            //                     shape: MaterialStateProperty.all<
            //                         RoundedRectangleBorder>(
            //                       RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(
            //                           AppValues.s10,
            //                         ), // Define o raio da borda aqui
            //                       ),
            //                     ),
            //                   ),
            //                   onPressed: () {},
            //                   child: Text("Doar"),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //     separatorBuilder: (context, index) {
            //       return const SizedBox(width: 10);
            //     },
            //     itemCount: titles.length,
            //   ),
            // ),

            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Próximos Eventos",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(onPressed: () {}, child: Text("Ver mais"))
                ],
              ),
            ),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  enableInfiniteScroll: false,
                  padEnds: false,
                  viewportFraction: 0.93,
                ),
                carouselController: CarouselSliderController(),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Card(
                      child: Container(
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Image.asset(AppImages.image1),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.blue.withOpacity(.4),
                                            AppColors.primaryColor
                                                .withOpacity(.4),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Limpeza numa instituição de caridade",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.black54),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        AppIcons.heartBold,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Sábado, 11 Abril 10:35",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Centro Fieta' Caridade",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 16,
                                            child: Stack(
                                              children: [
                                                _contributeUserItem(0, 0, 0,
                                                    AppImages.me, Colors.black),
                                                _contributeUserItem(8, 0, 0,
                                                    AppImages.me, Colors.red),
                                                _contributeUserItem(16, 0, 0,
                                                    AppImages.me, Colors.green),
                                                _contributeUserItem(
                                                    24,
                                                    0,
                                                    0,
                                                    AppImages.me,
                                                    AppColors.primaryColor,
                                                    text: "+16"),
                                                _contributeUserDescription(
                                                    60,
                                                    0,
                                                    0,
                                                    AppImages.me,
                                                    Colors.transparent,
                                                    text: "Contributos"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ONG's Populares",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(onPressed: () {}, child: Text("Ver mais"))
                ],
              ),
            ),

            SizedBox(
              height: 190,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      width: 320,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(10),
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 55,
                                height: 55,
                                color: Colors.black12,
                              ),
                            ),
                            title: Text(
                              "Organização bem da população",
                            ),
                            subtitle: Text("sociedade sem fome"),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Divider(
                                  color: AppColors.grey,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 16,
                                          child: Stack(
                                            children: [
                                              _contributeUserItem(0, 0, 0,
                                                  AppImages.me, Colors.black),
                                              _contributeUserItem(8, 0, 0,
                                                  AppImages.me, Colors.red),
                                              _contributeUserItem(16, 0, 0,
                                                  AppImages.me, Colors.green),
                                              _contributeUserItem(
                                                  24,
                                                  0,
                                                  0,
                                                  AppImages.me,
                                                  AppColors.primaryColor,
                                                  text: "+16"),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.add,
                                        color: AppColors.primaryColor,
                                      ),
                                      const Text(
                                        "Juntar-se",
                                        style: TextStyle(
                                            color: AppColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemCount: titles.length,
              ),
            ),
          ],
        ),
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

  Positioned _contributeUserItem(
      double left, double top, double bottom, String imagePath, Color color,
      {String? text}) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: (text != null) ? 30 : 16,
          height: 16,
          color: color,
          child: (text == null)
              ? Image.asset(imagePath)
              : Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Positioned _contributeUserDescription(
      double left, double top, double bottom, String imagePath, Color color,
      {String? text}) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 16,
          color: color,
          child: (text == null)
              ? Image.asset(imagePath)
              : Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
