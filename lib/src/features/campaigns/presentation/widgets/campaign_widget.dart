import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/entities/campaign_entity.dart';

class CampaignWidget extends StatefulWidget {
  final CampaignEntity campaign;
  const CampaignWidget({super.key, required this.campaign});

  @override
  State<CampaignWidget> createState() => _CampaignWidgetState();
}

class _CampaignWidgetState extends State<CampaignWidget> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    finishDate = widget.campaign.endDate!;
    fundraisingGoal = widget.campaign.fundraisingGoal!;
    fundsRaised = widget.campaign.fundsRaised!;
    raisingGoals = NumberFormat.currency(locale: 'pt_PT', symbol: 'AOA')
        .format(widget.campaign.fundraisingGoal);
    raising = NumberFormat.currency(locale: 'pt_PT', symbol: 'AOA')
        .format(widget.campaign.fundsRaised);
    if (widget.campaign.fundsRaised != null &&
        widget.campaign.fundraisingGoal != null) {
      percentage = (fundsRaised / fundraisingGoal) * 100;
      percentageText = '${percentage.toStringAsFixed(2)}%';
    }

    Duration diferenca = finishDate.difference(now);
    diasRestantes = diferenca.inDays;

    progressBarWidth = MediaQuery.sizeOf(context).width * percentage;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
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
                      Container(
                        width: double.infinity,
                        height: 190,
                        child: CachedNetworkImage(
                          imageUrl: widget.campaign.imageCoverUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(),
                            ),
                          ),
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
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.blue.withOpacity(.4),
                                AppColors.primaryColor.withOpacity(.4),
                              ],
                            ),
                          ),
                        ),
                      ),
                      (widget.campaign.priority != 0)
                          ? const SizedBox.shrink()
                          : Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 120,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 110, 32, 27),
                                      Color.fromARGB(255, 248, 101, 99),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "EMERGÊNCIA",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
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
                        children: [
                          Expanded(
                            child: Text(
                              widget.campaign.description!,
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(AppIcons.heart)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: "\$ ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                            ),
                            TextSpan(
                              text: NumberFormat.currency(
                                      locale: 'pt_PT', symbol: 'AOA')
                                  .format(widget.campaign.fundsRaised)
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                            ),
                            const TextSpan(text: " / "),
                            TextSpan(
                                text: NumberFormat.currency(
                                        locale: 'pt_PT', symbol: 'AOA')
                                    .format(widget.campaign.fundraisingGoal)
                                    .toString())
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
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          Positioned(
                            // child: Container(
                            //   width: progressBarWidth,
                            //   height: 15,
                            //   decoration: BoxDecoration(
                            //     color: Colors.black87,
                            //     borderRadius: BorderRadius.circular(100),
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       percentageText,
                            //       style: const TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 10,
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //   ),
                            // ),
                            child: FAProgressBar(
                                currentValue: percentage,
                                backgroundColor: AppColors.strokeColor,
                                progressColor: Colors.black,
                                changeProgressColor: Colors.red,
                                size: 15,
                                displayTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                                displayText: '%'),
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
                              child: SizedBox(
                                height: 16,
                                child: Stack(
                                  children: [
                                    AppUtils.contributeUserItem(
                                        0, 0, 0, AppImages.me, Colors.black),
                                    AppUtils.contributeUserItem(
                                        8, 0, 0, AppImages.me, Colors.red),
                                    AppUtils.contributeUserItem(
                                        16, 0, 0, AppImages.me, Colors.green),
                                    AppUtils.contributeUserItem(24, 0, 0,
                                        AppImages.me, AppColors.primaryColor,
                                        text: "+16"),
                                    AppUtils.contributeUserDescription(60, 0, 0,
                                        AppImages.me, Colors.transparent,
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
                              "Faltando $diasRestantes dias",
                              style: const TextStyle(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
    );
  }
}
