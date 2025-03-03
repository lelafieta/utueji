import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:intl/intl.dart';
import 'package:parallax_animation/parallax_animation.dart';
import 'package:utueji/src/core/resources/images/app_images.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/utils/app_date_utils_helper.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/entities/event_entity.dart';

class EventDetailPage extends StatefulWidget {
  final EventEntity event;
  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  double fundraisingGoal = 0.0;
  double fundsRaised = 0.0;
  String raisingGoals = "";
  String raising = "";
  double percentage = 0.0;
  String percentageText = "";
  double progressBarWidth = 0.0;
  DateTime now = DateTime.now();
  DateTime finishDate = DateTime.now();
  int diasRestantes = 0;
  ValueNotifier<Color> color = ValueNotifier(AppColors.whiteColor);
  @override
  Widget build(BuildContext context) {
    Duration diferenca = finishDate.difference(now);
    diasRestantes = diferenca.inDays;

    progressBarWidth = MediaQuery.sizeOf(context).width * percentage;
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
                    background: CachedNetworkImage(
                      imageUrl: widget.event.backgroundImageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(150.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              widget.event.title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            trailing: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: SvgPicture.asset(
                                  AppIcons.heartBold,
                                  color: Colors.red,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          widget.event.ong!.coverImageUrl!,
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
                                title: Text(
                                  widget.event.ong!.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(widget.event.ong!.bio!),
                                trailing: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.black),
                                  child: const Text(
                                    "Visualizar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
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
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_sharp),
                    const SizedBox(width: 10),
                    Text(
                        "${AppDateUtilsHelper.formatDate(data: widget.event.startDate!, showTime: true)}\n${AppDateUtilsHelper.formatDate(data: widget.event.startDate!, showTime: true)}"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 10),
                    Text(widget.event.location!),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  "Detalhes do Evento",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.event.description!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 16,
                          child: Stack(
                            children: [
                              AppUtils.contributeUserItem(
                                  0, 0, 0, null, Colors.black),
                              AppUtils.contributeUserItem(
                                  8, 0, 0, null, Colors.red),
                              AppUtils.contributeUserItem(
                                  16, 0, 0, null, Colors.green),
                              AppUtils.contributeUserItem(
                                  24, 0, 0, null, AppColors.primaryColor,
                                  text: "+16"),
                              AppUtils.contributeUserDescription(
                                  60, 0, 0, null, Colors.transparent,
                                  text: "Contributos"),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {}, child: const Text("Ver mais"))
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppValues.s10,
                          ), // Define o raio da borda aqui
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Participar"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
