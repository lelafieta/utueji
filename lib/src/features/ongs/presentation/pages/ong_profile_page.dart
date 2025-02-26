import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../domain/entities/ong_entity.dart';

class OngProfilePage extends StatefulWidget {
  final OngEntity ong;
  const OngProfilePage({super.key, required this.ong});

  @override
  State<OngProfilePage> createState() => _OngProfilePageState();
}

class _OngProfilePageState extends State<OngProfilePage> {
  ValueNotifier<Color> color = ValueNotifier(AppColors.whiteColor);
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        if (innerBoxIsScrolled) {
          color.value = Colors.black;
        }
        return [
          ValueListenableBuilder(
            valueListenable: color,
            builder: (context, value, _) {
              return SliverAppBar(
                expandedHeight: 280.0,
                floating: false,
                pinned: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: value,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      color: value,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  // title: Text(widget.campaign.title!),
                  background: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: widget.ong.coverImageUrl!,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Container(
                          color: Colors.black26,
                        ),
                      )
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(120.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        // color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: double.infinity,
                            height: 120,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        Positioned(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      width: 5,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                ),
                                margin: const EdgeInsets.only(left: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.ong.profileImageUrl!,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                // color: Colors.red,
                                height: 70,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.ong.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    Text(widget.ong.bio!),
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
            },
          ),
        ];
      },
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "1.000",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Suportes",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "|",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "230",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Serviços",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(AppColors.whiteColor),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                          side: MaterialStatePropertyAll(
                            BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Juntar-se",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(AppColors.blackColor),
                          side: MaterialStatePropertyAll(
                            BorderSide(
                              color: Colors.black12,
                              width: 2,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Chat",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(AppColors.blackColor),
                          minimumSize: MaterialStatePropertyAll(
                            Size(50, 50),
                          ),
                          side: MaterialStatePropertyAll(
                            BorderSide(
                              color: Colors.black12,
                              width: 2,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Icon(Icons.phone),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Sobre",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(widget.ong.about!),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: SvgPicture.asset(
                                    AppIcons.lightbulbOn,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Visão",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  widget.ong.vision!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: SvgPicture.asset(
                                    AppIcons.bullseyeArrow,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Missão",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  widget.ong.mission!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Divider(),
            //     Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           const Icon(Icons.access_time_sharp),
            //           const SizedBox(width: 10),
            //           Text(
            //               "${AppUtils.formatDate(data: widget.event.startDate!, showTime: true)}\n${AppUtils.formatDate(data: widget.event.startDate!, showTime: true)}"),
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: [
            //           const Icon(Icons.location_on),
            //           const SizedBox(width: 10),
            //           Text(widget.event.location!),
            //         ],
            //       ),
            //     ),
            //     const Divider(),
            //     Padding(
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            //       child: Text(
            //         "Detalhes do Evento",
            //         style: Theme.of(context)
            //             .textTheme
            //             .titleMedium!
            //             .copyWith(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Text(
            //         widget.event.description!,
            //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            //         textAlign: TextAlign.justify,
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.all(10),
            //       child: Container(
            //         child: Row(
            //           children: [
            //             Expanded(
            //               child: SizedBox(
            //                 height: 16,
            //                 child: Stack(
            //                   children: [
            //                     AppUtils.contributeUserItem(
            //                         0, 0, 0, AppImages.me, Colors.black),
            //                     AppUtils.contributeUserItem(
            //                         8, 0, 0, AppImages.me, Colors.red),
            //                     AppUtils.contributeUserItem(
            //                         16, 0, 0, AppImages.me, Colors.green),
            //                     AppUtils.contributeUserItem(24, 0, 0,
            //                         AppImages.me, AppColors.primaryColor,
            //                         text: "+16"),
            //                     AppUtils.contributeUserDescription(
            //                         60, 0, 0, AppImages.me, Colors.transparent,
            //                         text: "Contributos"),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             TextButton(
            //                 onPressed: () {}, child: const Text("Ver mais"))
            //           ],
            //         ),
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10),
            //         child: ElevatedButton(
            //           style: ButtonStyle(
            //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(
            //                   AppValues.s10,
            //                 ), // Define o raio da borda aqui
            //               ),
            //             ),
            //           ),
            //           onPressed: () {},
            //           child: Text("Participar"),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
