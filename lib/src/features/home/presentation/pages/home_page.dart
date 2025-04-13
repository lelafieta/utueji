import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:utueji/src/app/app_entity.dart';
import 'package:utueji/src/features/categories/data/models/category_model.dart';
import 'package:utueji/src/features/events/presentation/widgets/event_skeleton_widget.dart';
import 'package:utueji/src/features/home/presentation/cubit/home_campaign_cubit/home_campaign_cubit.dart';
import 'package:utueji/src/features/ongs/presentation/widgets/ong_skeleton_widget.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/cache/secure_storage.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../campaigns/presentation/widgets/campaign_skeleton_widget.dart';
import '../../../campaigns/presentation/widgets/campaign_widget.dart';
import '../../../events/presentation/cubit/event_cubit.dart';
import '../../../events/presentation/cubit/event_state.dart';
import '../../../events/presentation/widgets/event_widget.dart';
import '../../../favorites/presentation/cubit/favorite_cubit.dart';
import '../../../ongs/presentation/cubit/ong_cubit.dart';
import '../../../ongs/presentation/cubit/ong_state.dart';
import '../../../ongs/presentation/widgets/ong_widget.dart';
import '../../../solidary/cubit/solidary_cubit.dart';
import '../cubit/home_campaign_cubit/home_campaign_state.dart';
import '../cubit/home_profile_data_cubit/home_profile_data_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SecureCacheHelper secureCacheHelper = SecureCacheHelper();
  String fullName = "";
  String avatarUrl = "";
  @override
  void initState() {
    super.initState();
    // getUserData();
    context.read<FavoriteCubit>().getAllFavorites();
    context.read<HomeCampaignCubit>().getLatestUrgentCampaigns();
    context.read<EventCubit>().getLatestEvents();
    context.read<OngCubit>().getLatestOngs();
  }

  Future<void> getUserData() async {
    secureCacheHelper.getData(key: "fullName").then((value) {
      setState(() {
        fullName = value!;
      });
    });
    secureCacheHelper.getData(key: "avatarUrl").then((value) {
      setState(() {
        avatarUrl = value!;
      });
    });
  }

  String formatarDataPersonalizada(DateTime data) {
    String diaSemana = DateFormat.EEEE('pt_BR').format(data); // Sábado
    String dia = DateFormat.d().format(data); // 11
    String mes = DateFormat.MMMM('pt_BR').format(data); // Abril
    String horaMinuto = DateFormat('HH:mm').format(data); // 10:35

    return '$diaSemana, $dia $mes $horaMinuto';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolidaryCubit, SolidaryState>(
      builder: (context, state) {
        return Column(
          children: [
            SafeArea(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.profileRoute);
                  },
                  child: (state is GetUserDataSuccessState)
                      ? (state.user.avatarUrl!.isEmpty)
                          ? Image.asset(AppImages.avatar)
                          : Container(
                              margin: EdgeInsets.only(left: 16),
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    state.user.avatarUrl!),
                              ),
                            )
                      : SizedBox.shrink(),
                ),
                trailing: Container(
                  width: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.favoriteRoute);
                        },
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
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Row(
                        children: [
                          (state is GetUserDataSuccessState)
                              ? Text(
                                  "Olá! ${state.user.fullName}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                )
                              : Text("Olá! Ajuda-me"),
                          const SizedBox(width: 5),
                          Image.asset(
                            AppImages.wave,
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Text(
                        "Sua mudança torna algumas vidas melhores",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "JUNTOS",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.categoryCampaignsRoute,
                                arguments: categories[index],
                              );
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      padding: const EdgeInsets.all(18),
                                      child: SvgPicture.asset(
                                        categories[index].iconPath!,
                                        width: 12,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(categories[index].name.toString()),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 10);
                        },
                        itemCount: categories.length,
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Necessidades Urgentes",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.campaignUrgentsRoute);
                              },
                              child: Text("Ver mais"))
                        ],
                      ),
                    ),
                    BlocBuilder<HomeCampaignCubit, HomeCampaignState>(
                      builder: (context, state) {
                        if (state is HomeCampaignLoading) {
                          return HomeCampaignSkeletonWidget();
                        } else if (state is HomeCampaignError) {
                          return Text("${state.message}");
                        } else if (state is HomeCampaignLoaded) {
                          if (state.campaigns.isEmpty) {
                            return const Center(
                              child: Text("Sem campanhas"),
                            );
                          }

                          return CarouselSlider.builder(
                            itemCount: state.campaigns.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              final camapaign = state.campaigns[itemIndex];
                              return CampaignWidget(campaign: camapaign);
                            },
                            options: CarouselOptions(
                              height: 420,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.95,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              animateToClosest: false,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                        }
                        return Text("ERRRO ${state}");
                      },
                    ),
                    // SizedBoxAppUtils.
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
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                    BlocBuilder<EventCubit, EventState>(
                      builder: (context, state) {
                        if (state is EventLoading) {
                          return CarouselSlider.builder(
                            itemCount: 8,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              return const EventSkeletonWidget();
                            },
                            options: CarouselOptions(
                              height: 300,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.95,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              animateToClosest: false,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                          );
                        } else if (state is EventLoaded) {
                          if (state.events.isEmpty) {
                            return Center(
                                child: Text("Sem eventos registados"));
                          } else {
                            final events = state.events;
                            return CarouselSlider(
                              options: CarouselOptions(
                                height: 300,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.95,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                animateToClosest: false,
                                reverse: false,
                                autoPlay: false,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: false,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: events.map((event) {
                                return EventWidget(
                                  event: event,
                                );
                              }).toList(),
                            );
                          }
                        }
                        return Text("data");
                      },
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
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

                    BlocBuilder<OngCubit, OngState>(
                      builder: (context, state) {
                        if (state is OngLoading) {
                          return CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 165,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              animateToClosest: false,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                            itemBuilder: (context, index, pageViewIndex) {
                              return const OngSkeletonWidget();
                            },
                            itemCount: 8,
                          );
                        } else if (state is OngLoaded) {
                          if (state.ongs.isEmpty) {
                            return const Center(
                                child: Text("Sem ongs registadas"));
                          }
                          return CarouselSlider(
                            options: CarouselOptions(
                              height: 190,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              animateToClosest: false,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: state.ongs.map((ong) {
                              return OngWidget(
                                ong: ong,
                              );
                            }).toList(),
                          );
                        }
                        return Text("data");
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class HomeCampaignSkeletonWidget extends StatelessWidget {
  const HomeCampaignSkeletonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 8,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return const CampaignSkeletonWidget();
      },
      options: CarouselOptions(
        height: 420,
        aspectRatio: 16 / 9,
        viewportFraction: 0.95,
        initialPage: 0,
        enableInfiniteScroll: false,
        animateToClosest: false,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
