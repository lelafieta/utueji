import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_date_utils_helper.dart';
import '../../../../core/utils/app_functions_utils_helper.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.campaignDetail, arguments: widget.campaign);
      },
      child: Card(
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
                                widget.campaign.title!,
                                style: Theme.of(context).textTheme.titleSmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: AppUtils.favoriteWidget(
                                  context: context,
                                  itemId: widget.campaign.id!,
                                  itemType: "campaign"),
                            ),
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
                                text: AppUtils.formatCurrency(
                                    widget.campaign.fundsRaised!),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                              ),
                              const TextSpan(text: " / "),
                              TextSpan(
                                  text: AppUtils.formatCurrency(
                                      widget.campaign.fundraisingGoal!))
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
                              child: FAProgressBar(
                                  currentValue: AppFuncionsUtilsHelper
                                      .calculateFundraisingPercentage(
                                          widget.campaign.fundsRaised,
                                          widget.campaign.fundraisingGoal),
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
                                child: InkWell(
                                  onTap: () {
                                    AppUtils.contributorUsers(
                                        context, widget.campaign.contributors!);
                                  },
                                  child: Row(
                                    children: [
                                      AppUtils.contributores(
                                        widget.campaign.contributors!,
                                      ),
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
                              (AppDateUtilsHelper.daysRemainingUntil(
                                          widget.campaign.endDate!) ==
                                      0)
                                  ? Text(
                                      "Está acontecer",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  : (AppDateUtilsHelper.daysRemainingUntil(
                                              widget.campaign.endDate!) <
                                          0)
                                      ? Text(
                                          AppUtils.formatDate(
                                              data: widget.campaign.endDate!),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      : Text(
                                          "Faltando ${AppDateUtilsHelper.daysRemainingUntil(widget.campaign.endDate!)} dias",
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
                  SizedBox(height: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorByIndex(int index) {
    switch (index) {
      case 0:
        return Colors.black;
      case 1:
        return Colors.red;
      case 2:
        return Colors.green;
      default:
        return AppColors.primaryColor;
    }
  }
}
