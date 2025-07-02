import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';

import '../../../blogs/presentation/pages/blog_page.dart';
import '../../../events/presentation/pages/event_page.dart';
import '../../../feeds/presentation/pages/feed_page.dart';
import '../../../ongs/presentation/cubit/ong_cubit.dart';
import '../../../ongs/presentation/cubit/ong_state.dart';
import '../../../ongs/presentation/widgets/ong_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> menus = ["Feeds", "Blogs", "Eventos", "Perfil ONG"];

  int selectedIndex = 0;
  List<Widget> widgets = [
    const FeedPage(),
    const BlogPage(),
    const EventPage(),
    const OngContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Navegador'),
      ),
      body: Column(
        children: [
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int index = 0; index < menus.length; index++)
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
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
                        menus[index],
                        style: TextStyle(
                          color: (index == selectedIndex)
                              ? AppColors.whiteColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Expanded(
            child: widgets[selectedIndex],
          ),
        ],
      ),
    );
  }
}

class OngContainer extends StatelessWidget {
  const OngContainer({super.key});

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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is OngLoaded) {
                if (state.ongs.isEmpty) {
                  return Center(child: Text("Sem ongs registadas"));
                }
                return CarouselSlider(
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
                final ongs = state.ongs;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final ong = ongs[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CachedNetworkImage(
                                imageUrl: ong.profileImageUrl!,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lorem ipsum dolor sit amet",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 5),
                                  const Text("33 Membros"),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [Icon(Icons.add), Text("Juntar-se")],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: ongs.length,
                );
              }
              return Text("data");
            },
          ),
        ],
      ),
    );
  }
}
