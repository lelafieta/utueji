import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utueji/src/features/ongs/presentation/widgets/ong_widget.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../events/presentation/cubit/event_cubit.dart';
import '../../../events/presentation/cubit/event_state.dart';
import '../../../events/presentation/widgets/event_widget.dart';
import '../../../ongs/presentation/cubit/ong_cubit.dart';
import '../../../ongs/presentation/cubit/ong_state.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> menus = ["Feeds", "Blogs", "Eventos", "Perfil ONG"];

  int selectedIndex = 0;
  List<Widget> widgets = [
    const FeedContainer(),
    const BlogContainer(),
    const EventContainer(),
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
            return ListView.separated(
                itemBuilder: (context, index) {
                  final event = events[index];
                  return EventWidget(event: event);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: events.length);
          }
        }
        return Text("data");
      },
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
                return SizedBox(
                  height: 190,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    itemBuilder: (context, index) {
                      final ong = state.ongs[index];

                      return OngWidget(
                        ong: ong,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: state.ongs.length,
                  ),
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
