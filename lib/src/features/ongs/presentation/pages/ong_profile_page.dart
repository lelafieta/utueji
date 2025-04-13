import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliver_snap/widgets/sliver_snap.dart';
import 'package:utueji/src/features/campaigns/presentation/widgets/campaign_skeleton_widget.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_date_utils_helper.dart';
import '../../../campaigns/presentation/cubit/campaign_cubit.dart';
import '../../../campaigns/presentation/cubit/campaign_state.dart';
import '../../../campaigns/presentation/widgets/campaign_widget.dart';
import '../../../events/presentation/cubit/event_cubit.dart';
import '../../../events/presentation/cubit/event_state.dart';
import '../../../events/presentation/widgets/event_widget.dart';
import '../../../feeds/presentation/cubit/feed_cubit.dart';
import '../../../feeds/presentation/cubit/feed_state.dart';
import '../../domain/entities/ong_entity.dart';
import '../cubit/ong_cubit.dart';
import '../cubit/ong_state.dart';

class OngProfilePage extends StatefulWidget {
  final OngEntity ong;
  const OngProfilePage({super.key, required this.ong});

  @override
  State<OngProfilePage> createState() => _OngProfilePageState();
}

class _OngProfilePageState extends State<OngProfilePage> {
  ValueNotifier<Color> color = ValueNotifier(AppColors.whiteColor);
  List<String> menuList = ["Recentes", "Campanhas", "Eventos", "Blogs"];
  int selected = 0;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _topoKey = GlobalKey();

  ValueNotifier<bool> _showSticky = ValueNotifier(false);
  ValueNotifier<bool> _showStickyTopo = ValueNotifier(false);
  final GlobalKey _stickyKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkItem8Visibility);
  }

  void _checkItem8Visibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_stickyKey.currentContext == null) return;
        if (_topoKey.currentContext == null) return;

        final RenderBox box =
            _stickyKey.currentContext!.findRenderObject() as RenderBox;
        final RenderBox boxTopo =
            _topoKey.currentContext!.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero);
        final offsetTopo = boxTopo.localToGlobal(Offset.zero);

        final isNowSticky = offset.dy <= kToolbarHeight;
        final isNowStickyTopo = offsetTopo.dy <= kToolbarHeight;

        if (_showSticky != isNowSticky) {
          _showSticky.value = isNowSticky;
        }

        if (_showStickyTopo != isNowStickyTopo) {
          _showStickyTopo.value = isNowStickyTopo;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkItem8Visibility);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Container(
    //         width: double.infinity,
    //         height: 200,
    //         color: Colors.red,
    //         child: Stack(),
    //       ),
    //     ],
    //   ),
    // );

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 50,
                          child: Stack(
                            children: [
                              Container(
                                // color: Colors.yellow,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.ong.coverImageUrl!,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Container(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.black26.withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 16,
                          bottom: 0,
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    width: 5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.ong.profileImageUrl!,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: SafeArea(
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          widget.ong.name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset(
                          width: 16,
                          AppIcons.shieldTrust,
                          color: AppColors.blueColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    key: _topoKey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(widget.ong.bio!),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          "1.000",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Suportes",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "|",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "230",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Serviços",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  AppColors.whiteColor),
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.primaryColor),
                              side: const MaterialStatePropertyAll(
                                BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Juntar-se",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  AppColors.blackColor),
                              side: const MaterialStatePropertyAll(
                                BorderSide(
                                  color: Colors.black12,
                                  width: 2,
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Chat",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(AppColors.blackColor),
                            minimumSize: const MaterialStatePropertyAll(
                              Size(50, 50),
                            ),
                            side: const MaterialStatePropertyAll(
                              BorderSide(
                                color: Colors.black12,
                                width: 2,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Icon(Icons.phone),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Sobre",
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(widget.ong.about!),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 16),
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
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Impactos feitos",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton(onPressed: () {}, child: Text("Ver mais"))
                      ],
                    ),
                  ),
                  BlocBuilder<OngCubit, OngState>(
                    builder: (context, state) {
                      if (state is OngLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is OngLoaded) {
                        if (state.ongs.isEmpty) {
                          return Center(child: Text("Sem ongs registadas"));
                        }
                        return SizedBox(
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Image.asset(
                                        AppImages.image1,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        color: Colors.black26,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        height: 55,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black,
                                            ],
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Covid Test",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                "11 Agosto 2025",
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10);
                            },
                            itemCount: 15,
                          ),
                        );
                      }
                      return const Text("data");
                    },
                  ),
                  const SizedBox(height: 10),
                  // Container(
                  //   width: double.infinity,
                  //   height: 45,
                  //   decoration: BoxDecoration(),
                  // ),
                  Container(
                    key: _stickyKey,
                    width: double.infinity,
                    // height: 50,
                    // color: Colors.red,

                    child: TabBar(
                      isScrollable: true,
                      onTap: (value) {
                        setState(() {
                          selected = value;
                        });
                      },
                      indicator: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.primaryColor,
                            width: 3,
                          ),
                        ),
                      ),
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.black45,
                      indicatorColor: AppColors.primaryColor,
                      automaticIndicatorColorAdjustment: true,
                      tabs: [
                        Tab(
                          // icon:
                          //     Icon(Icons.access_time, color: AppColors.blackColor),
                          text: 'Recentes',
                        ),
                        Tab(
                          // icon: Icon(Icons.campaign, color: AppColors.blackColor),
                          text: 'Campanhas',
                        ),
                        Tab(
                          // icon: Icon(Icons.event, color: AppColors.blackColor),
                          text: 'Eventos',
                        ),
                        Tab(
                          // icon: Icon(Icons.article, color: AppColors.blackColor),
                          text: 'Blogs',
                        ),
                      ],
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 40,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text('Item ${index + 1}'),
                        subtitle: Text('Subtitle for item ${index + 1}'),
                      );
                    },
                  )

                  // _menuWidget(),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _showStickyTopo,
              builder: (context, showStickyTopo, child) {
                if (showStickyTopo) {
                  return Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Material(
                      elevation: 4,
                      color: AppColors.primaryColor,
                      child: Container(
                        width: double.infinity,
                        child: SafeArea(
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              widget.ong.name!,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _showSticky,
              builder: (context, showSticky, child) {
                if (showSticky) {
                  return Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Material(
                      elevation: 4,
                      color: AppColors.primaryColor,
                      child: Container(
                        width: double.infinity,
                        child: SafeArea(
                          child: TabBar(
                            isScrollable: true,
                            indicator: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.whiteColor,
                                  width: 3,
                                ),
                              ),
                            ),
                            labelColor: AppColors.whiteColor,
                            unselectedLabelColor: Colors.white60,
                            indicatorColor: AppColors.primaryColor,
                            automaticIndicatorColorAdjustment: true,
                            tabs: [
                              Tab(
                                text: 'Recentes',
                              ),
                              Tab(
                                text: 'Campanhas',
                              ),
                              Tab(
                                text: 'Eventos',
                              ),
                              Tab(
                                text: 'Blogs',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );

    // return Stack(
    //   children: [
    //     ListView.builder(
    //       controller: _scrollController,
    //       itemCount: 100,
    //       itemBuilder: (context, index) {
    //         if (index == 50) {
    //           return Container(
    //             key: _item8Key,
    //             padding: const EdgeInsets.all(16),
    //             color: Colors.orange.shade200,
    //             child: const Text(
    //               '8',
    //               style: TextStyle(fontSize: 22),
    //             ),
    //           );
    //         }
    //         return Container(
    //           padding: const EdgeInsets.all(16),
    //           child: Text('Item $index'),
    //         );
    //       },
    //     ),
    //     if (_showSticky)
    //       Positioned(
    //         top: 0,
    //         left: 0,
    //         right: 0,
    //         child: Container(
    //           color: Colors.orange,
    //           padding: const EdgeInsets.all(16),
    //           child: const Text(
    //             '8',
    //             style: TextStyle(fontSize: 22, color: Colors.white),
    //           ),
    //         ),
    //       ),
    //   ],
    // );

    // return SliverSnap(
    //   onCollapseStateChanged: (isCollapsed, scrollingOffset, maxExtent) {},
    //   collapsedBackgroundColor: Colors.black,
    //   expandedBackgroundColor: Colors.transparent,
    //   backdropWidget: Container(
    //     color: Colors.red,
    //   ),
    //   bottom: const PreferredSize(
    //     preferredSize: Size.fromHeight(50),
    //     child: Icon(
    //       Icons.directions_boat,
    //       color: Colors.blue,
    //       size: 45,
    //     ),
    //   ),
    //   expandedContentHeight: 500,
    //   expandedContent: Column(
    //     children: [
    //       Container(
    //         width: double.infinity,
    //         height: 200,
    //         color: Colors.yellow,
    //         child: Stack(
    //           children: [
    //             SizedBox(
    //               width: double.infinity,
    //               height: double.infinity,
    //               child: CachedNetworkImage(
    //                 imageUrl: widget.ong.coverImageUrl!,
    //                 fit: BoxFit.cover,
    //                 progressIndicatorBuilder:
    //                     (context, url, downloadProgress) =>
    //                         CircularProgressIndicator(
    //                             value: downloadProgress.progress),
    //                 errorWidget: (context, url, error) =>
    //                     const Icon(Icons.error),
    //               ),
    //             ),
    //             Positioned(
    //               left: 0,
    //               right: 0,
    //               bottom: 0,
    //               top: 0,
    //               child: Container(
    //                 color: Colors.black26,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    //   collapsedContent:
    //       const Icon(Icons.car_crash, color: Colors.green, size: 45),
    //   body: const Material(
    //     elevation: 7,
    //     child: Placeholder(),
    //   ),
    // );

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
                expandedHeight: 300.0,
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
                              const Icon(Icons.error),
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
                  preferredSize: const Size.fromHeight(170.0),
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
                                        const Icon(Icons.error),
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
                                    Row(
                                      children: [
                                        Text(
                                          widget.ong.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 5),
                                        SvgPicture.asset(
                                          width: 16,
                                          AppIcons.shieldTrust,
                                          color: AppColors.blueColor,
                                        ),
                                      ],
                                    ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      "1.000",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Suportes",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "|",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "230",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Serviços",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(AppColors.whiteColor),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                          side: const MaterialStatePropertyAll(
                            BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
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
                          side: const MaterialStatePropertyAll(
                            BorderSide(
                              color: Colors.black12,
                              width: 2,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Chat",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(AppColors.blackColor),
                        minimumSize: const MaterialStatePropertyAll(
                          Size(50, 50),
                        ),
                        side: const MaterialStatePropertyAll(
                          BorderSide(
                            color: Colors.black12,
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.phone),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Sobre",
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(widget.ong.about!),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
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
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Impactos feitos",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(onPressed: () {}, child: Text("Ver mais"))
                  ],
                ),
              ),
              BlocBuilder<OngCubit, OngState>(
                builder: (context, state) {
                  if (state is OngLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is OngLoaded) {
                    if (state.ongs.isEmpty) {
                      return Center(child: Text("Sem ongs registadas"));
                    }
                    return SizedBox(
                      height: 150,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Stack(
                              children: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Image.asset(
                                    AppImages.image1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 55,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black,
                                        ],
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Covid Test",
                                            style: TextStyle(
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            "11 Agosto 2025",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 10);
                        },
                        itemCount: 15,
                      ),
                    );
                  }
                  return const Text("data");
                },
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(),
              ),
              // _menuWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuWidget() {
    switch (selected) {
      case 0:
        return BlocBuilder<FeedCubit, FeedState>(
          builder: (context, state) {
            if (state is FeedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FeedLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final feed = state.feeds[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
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
                                child: CachedNetworkImage(
                                  imageUrl: feed.user!.avatarUrl!,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            title: Text(
                                "${feed.user!.firstName} ${feed.user!.lastName}"),
                            subtitle: Text(AppDateUtilsHelper.formatDate(
                                data: feed.createdAt!, showTime: true)),
                            trailing: const Icon(Icons.more_vert),
                          ),
                          Text("${feed.description}"),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: CachedNetworkImage(
                                      imageUrl: feed.image!,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 45,
                                    color: AppColors.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
            return const Text("data");
          },
        );

      case 1:
        return BlocBuilder<CampaignCubit, CampaignState>(
          builder: (context, state) {
            if (state is CampaignLoading) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return const CampaignSkeletonWidget();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: 8,
              );
            } else if (state is CampaignLoaded) {
              if (state.campaigns.isEmpty) {
                return const Center(
                  child: Text("Sem campanhas"),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final campaign = state.campaigns[index];
                  return CampaignWidget(campaign: campaign);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: state.campaigns.length,
              );
            }
            return const Text("ERRRO");
          },
        );

      case 2:
        return BlocBuilder<EventCubit, EventState>(
          builder: (context, state) {
            if (state is CampaignLoading) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return const CampaignSkeletonWidget();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: 8,
              );
            } else if (state is EventLoaded) {
              if (state.events.isEmpty) {
                return const Center(
                  child: Text("Sem campanhas"),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final event = state.events[index];
                  return EventWidget(
                    event: event,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: state.events.length,
              );
            }
            return const Text("ERRRO");
          },
        );
      case 3:
        return Text("3");
      default:
        return Text("4");
    }
  }
}
