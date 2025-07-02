import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_date_utils_helper.dart';
import '../../../../core/utils/app_utils.dart';
import '../../domain/entities/event_entity.dart';

class EventWidget extends StatefulWidget {
  final EventEntity event;
  const EventWidget({super.key, required this.event});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.eventDetail, arguments: widget.event);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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
                    Container(
                      width: double.infinity,
                      height: 190,
                      child: CachedNetworkImage(
                        imageUrl: widget.event.backgroundImageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
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
                              AppColors.primaryColor.withOpacity(.4),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.event.title!,
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
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
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          AppDateUtilsHelper.formatDate(
                              data: widget.event.startDate!),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        const Icon(
                          Icons.location_on_rounded,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            "${widget.event.location}",
                            style: const TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
