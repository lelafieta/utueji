import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_sharing_plus/social_sharing_plus.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';

import '../../../../core/utils/campaign_status_extension.dart';
import '../../../events/presentation/cubit/event_cubit.dart';
import '../../../events/presentation/cubit/event_state.dart';
import '../../../events/presentation/widgets/event_widget.dart';

import '../../domain/entities/campaign_entity.dart';
import '../../domain/entities/campaign_params.dart';
import '../../domain/enums/campaign_status.dart';
import '../cubit/my_campaign_cubit/my_campaign_cubit.dart';
import '../cubit/my_campaign_cubit/my_campaign_state.dart';
import '../widgets/my_campaign_skeleton_widget.dart';
import '../widgets/my_campaign_widget.dart';

class MyCampaignPage extends StatefulWidget {
  const MyCampaignPage({super.key});

  @override
  State<MyCampaignPage> createState() => _MyCampaignPageState();
}

class _MyCampaignPageState extends State<MyCampaignPage> {
  ValueNotifier<CampaignParams> params =
      ValueNotifier<CampaignParams>(CampaignParams());
  List<CampaignStatus> statuses = CampaignStatusExtension.allStatuses;
  final scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  static const List<SocialPlatform> _platforms = SocialPlatform.values;

  final ImagePicker _picker = ImagePicker();
  String? _mediaPath;
  List<String> _mediaPaths = [];

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) _mediaPath = pickedFile.path;
    });
  }

  Future<void> _pickVideo() async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) _mediaPath = pickedFile.path;
    });
  }

  Future<void> _pickMultiMedia() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    setState(() {
      _mediaPaths = pickedFiles.map((file) => file.path).toList();
    });
  }

  Future<void> _pickMultiVideo() async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _mediaPaths.add(pickedFile.path);
      }
    });
  }

  Future<void> _share(
    SocialPlatform platform, {
    bool isMultipleShare = false,
    String? description,
    List<String>? mediaPaths,
  }) async {
    final String content = _controller.text;
    isMultipleShare
        ? await SocialSharingPlus.shareToSocialMediaWithMultipleMedia(
            platform,
            media: mediaPaths ?? _mediaPaths,
            content: description,
            isOpenBrowser: true,
            onAppNotInstalled: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content:
                      Text('${platform.name.capitalize} is not installed.'),
                ));
            },
          )
        : await SocialSharingPlus.shareToSocialMedia(
            platform,
            content,
            media: _mediaPath,
            isOpenBrowser: true,
            onAppNotInstalled: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content:
                      Text('${platform.name.capitalize} is not installed.'),
                ));
            },
          );
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<MyCampaignCubit>().getAllMyCamapigns(
              isRefresh: false,
              params: CampaignParams(
                status: params.value.status,
              ));
        }
      }
    });
  }

  int selectedIndex = 0;
  List<Widget> widgets = [
    const FeedContainer(),
    const BlogContainer(),
    const EventContainer(),
  ];

  @override
  void initState() {
    context.read<MyCampaignCubit>().getAllMyCamapigns(
        isRefresh: true,
        params: CampaignParams(status: CampaignStatus.all.name));
    setupScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('social_sharing_plus'),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Padding(
    //             padding: const EdgeInsets.all(24),
    //             child: TextField(
    //               controller: _controller,
    //               decoration: const InputDecoration(
    //                 border: OutlineInputBorder(),
    //                 hintText: 'Enter a text',
    //               ),
    //             ),
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               ElevatedButton(
    //                 onPressed: _pickImage,
    //                 child: const Text('Pick Image'),
    //               ),
    //               const SizedBox(width: 20),
    //               if (Platform.isAndroid)
    //                 ElevatedButton(
    //                   onPressed: _pickVideo,
    //                   child: const Text('Pick Video'),
    //                 ),
    //             ],
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 20),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 ElevatedButton(
    //                   onPressed: _pickMultiMedia,
    //                   child: const Text('Pick Multi Image'),
    //                 ),
    //                 const SizedBox(width: 20),
    //                 if (Platform.isAndroid)
    //                   ElevatedButton(
    //                     onPressed: _pickMultiVideo,
    //                     child: const Text('Pick Multi Video'),
    //                   ),
    //               ],
    //             ),
    //           ),
    //           ..._platforms.map(
    //             (SocialPlatform platform) => ElevatedButton(
    //               onPressed: () => _share(
    //                 platform,
    //                 isMultipleShare: true,
    //               ),
    //               child: Text('Share to ${platform.name.capitalize}'),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Minhas Campanhas'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.toNamed(AppRoutes.createCampaignRoute);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ValueListenableBuilder<CampaignParams>(
        valueListenable: params,
        builder: (context, valueStatus, _) {
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: TextField(
                  onChanged: (value) {
                    params.value.title = value;
                    context.read<MyCampaignCubit>().getAllMyCamapigns(
                        isRefresh: true,
                        params: CampaignParams(
                            status: params.value.status,
                            title: params.value.title));
                  },
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
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppIcons.microphone,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          params.value.status = statuses[index].name;
                          context.read<MyCampaignCubit>().getAllMyCamapigns(
                              isRefresh: true,
                              params:
                                  CampaignParams(status: statuses[index].name));
                        });
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: (index == selectedIndex)
                              ? AppColors.blackColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Text(
                            statuses[index].label,
                            style: TextStyle(
                              color: (index == selectedIndex)
                                  ? AppColors.whiteColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: statuses.length,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: BlocBuilder<MyCampaignCubit, MyCampaignState>(
                  builder: (context, state) {
                    // if (state is MyCampaignLoading) {
                    //   return const Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                    // else if (state is MyCampaignLoaded) {
                    //   return ListView.separated(
                    //     padding: const EdgeInsets.all(16),
                    //     itemBuilder: (context, index) {
                    //       final campaign = state.campaigns[index];
                    //       return MyCampaignWidget(campaign: campaign);
                    //     },
                    //     separatorBuilder: (context, index) {
                    //       return const SizedBox(
                    //         height: 10,
                    //       );
                    //     },
                    //     itemCount: state.campaigns.length,
                    //   );
                    // }
                    if (state is MyCampaignLoading && state.isFirstFetch) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _campaignSkeletonWidget(context);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: 5,
                        ),
                      );
                    }
                    List<CampaignEntity> campaigns = [];
                    bool isLoading = false;
                    if (state is MyCampaignLoading) {
                      campaigns = state.oldCampaigns;
                      isLoading = true;
                    } else if (state is MyCampaignLoaded) {
                      campaigns = state.campaigns;
                    }
                    return ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        if (index < campaigns.length) {
                          final campaign = campaigns[index];
                          return MyCampaignWidget(campaign: campaign);
                        } else {
                          return MyCampaignSkeletonWidget();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: campaigns.length + (isLoading == true ? 1 : 0),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Card _campaignSkeletonWidget(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              titleAlignment: ListTileTitleAlignment.center,
              minVerticalPadding: 0,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 60,
                  height: 70,
                  color: Colors.black12,
                  child: Image.asset(
                    AppImages.coverBackground,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text("Campaign",
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              subtitle: Text("Date"),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
            ),
            const DottedDashedLine(
              height: 0,
              width: double.infinity,
              axis: Axis.horizontal,
              dashColor: Colors.black26,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontSize: 12),
                        children: [
                          // const TextSpan(text: "Objectivo: "),
                          TextSpan(
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            text: "Money /",
                          ),
                          TextSpan(
                            style: const TextStyle(color: Colors.black),
                            text: " Money",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: AppColors.textColor,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Está acontecer",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedContainer extends StatelessWidget {
  const FeedContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.black12,
                  ),
                ),
                title: const Text("Ana Martins"),
                subtitle: Text("20.Janeiro.2025"),
                trailing: Icon(Icons.more_vert),
              ),
              const Text(
                  "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet"),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.asset(AppImages.image1),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 45,
                        color: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Doar para sorrir",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.heartBold,
                            color: Colors.red,
                            width: 16,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "55",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.commentAlt,
                            color: Colors.black,
                            width: 16,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "58",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppIcons.eye,
                            color: Colors.black,
                            width: 16,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "1.2M",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                  SvgPicture.asset(
                    AppIcons.paperPlane,
                    color: Colors.black,
                    width: 16,
                  ),
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 20,
        );
      },
      itemCount: 10,
    );
  }
}

class BlogContainer extends StatelessWidget {
  const BlogContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Destaques",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // TextButton(onPressed: () {}, child: Text("Ver mais"))
              ],
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              enableInfiniteScroll: false,
              padEnds: false,
              viewportFraction: 0.93,
            ),
            carouselController: CarouselSliderController(),
            items: [1, 2, 3].map((index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16, top: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 150,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: Container(
                                  height: 130,
                                  decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                  ),
                                  child: Image.asset(
                                    AppImages.image1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.blue,
                                  child: Image.asset(AppImages.me),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Publicado aos 13, Abril, 2025"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Para ti",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.red,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                                style: Theme.of(context).textTheme.titleSmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              const Text("Publicado aos 13, Abril, 2025"),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.heart,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: 8,
          )
        ],
      ),
    );
  }
}

class EventContainer extends StatelessWidget {
  const EventContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        print(state);
        if (state is EventLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EventLoaded) {
          if (state.events.isEmpty) {
            return const Center(child: Text("Sem eventos registados"));
          } else {
            final events = state.events;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Eventos próximos de si",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton(onPressed: () {}, child: Text("Ver mais"))
                      ],
                    ),
                  ),
                  CarouselSlider(
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
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Para ti",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        // TextButton(onPressed: () {}, child: Text("Ver mais"))
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.all(14),
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return EventWidget(
                          event: event,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: state.events.length)
                ],
              ),
            );
          }
        }
        return Text("data");
      },
    );
  }
}
