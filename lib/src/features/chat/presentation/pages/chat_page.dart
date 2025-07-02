import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
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

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> menus = ["Todas", "Pendentes", "Passado", "Pendentes"];

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
        title: const Text('Caixa de Entrada'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppIcons.squarePlus),
          )
        ],
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
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Comunidades",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                          ),
                        )
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
                        return Container(
                          height: 80,
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
                                      width: 80,
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
                                                "Global",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                "33 Serviços",
                                                style: TextStyle(
                                                  color: Colors.white,
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
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mensagens",
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
                          return const Center(
                            child: Text("Sem ongs registadas"),
                          );
                        }
                        final ongs = state.ongs;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  width: 55,
                                  height: 55,
                                  color: Colors.black12,
                                  child: Image.asset(AppImages.me),
                                ),
                              ),
                              title: const Text("Ana Martins"),
                              subtitle: const Text("Olá, Tudo bem Fieta?"),
                              trailing: SizedBox(
                                width: 80,
                                child: Column(
                                  children: [
                                    const Text("12:06m"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "9",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
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
                          itemCount: ongs.length,
                        );
                      }
                      return Text("data");
                    },
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
