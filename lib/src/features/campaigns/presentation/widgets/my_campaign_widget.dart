import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:utueji/src/config/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:utueji/src/features/campaigns/domain/enums/campaign_status.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_date_utils_helper.dart';
import '../../../../core/utils/app_utils.dart';
import '../../domain/entities/campaign_entity.dart';

class MyCampaignWidget extends StatefulWidget {
  const MyCampaignWidget({
    super.key,
    required this.campaign,
  });

  final CampaignEntity campaign;

  @override
  State<MyCampaignWidget> createState() => _MyCampaignWidgetState();
}

class _MyCampaignWidgetState extends State<MyCampaignWidget> {
  AppinioSocialShare appinioSocialShare = AppinioSocialShare();
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

  String fixUrl(String url) {
    if (url.startsWith("https:/") && !url.startsWith("https://")) {
      return url.replaceFirst("https:/", "https://");
    }
    return url;
  }

  Future<String?> downloadImage(String imageUrl) async {
    print(imageUrl);
    try {
      String validUrl = fixUrl(imageUrl);
      final response = await http.get(Uri.parse(validUrl));

      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/${validUrl.split('/').last}';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      }
    } catch (e) {
      print("Erro ao baixar a imagem: $e");
    }
    return null;
  }

  Future shareToWhatsApp(String message, String filePath) async {
    await appinioSocialShare.android.shareFilesToSystem(message, [filePath]);
  }

  @override
  Widget build(BuildContext context) {
    finishDate = widget.campaign.endDate!;
    fundraisingGoal = widget.campaign.fundraisingGoal!;
    fundsRaised = widget.campaign.fundsRaised!;

    raising = NumberFormat.currency(locale: 'pt_PT', symbol: 'AOA')
        .format(widget.campaign.fundsRaised);
    if (widget.campaign.fundsRaised != null &&
        widget.campaign.fundraisingGoal != null) {
      percentage = (fundsRaised / fundraisingGoal) * 100;
      percentageText = '${percentage.toStringAsFixed(2)}%';
    }

    Duration diferenca = finishDate.difference(now);
    diasRestantes = diferenca.inDays;
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.myCampaignDetailRoute,
            arguments: widget.campaign);
      },
      child: Card(
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
                    child: (widget.campaign.imageCoverUrl == null)
                        ? Image.asset(
                            AppImages.coverBackground,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.campaign.imageCoverUrl!,
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
                ),
                title: Text(widget.campaign.title!,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                subtitle: Text(
                    "${AppDateUtilsHelper.formatDate(data: widget.campaign.endDate!)}"),
                trailing: IconButton(
                  onPressed: () async {
                    // String? result = (widget.campaign.imageCoverUrl != null)
                    //     ? await downloadImage(widget.campaign.imageCoverUrl!)
                    //     : null;

                    // if (result != null) {
                    //   shareToWhatsApp(
                    //       "${widget.campaign.title}\n${widget.campaign.description}",
                    //       result);
                    // }

                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.image, allowMultiple: false);
                    if (result != null && result.paths.isNotEmpty) {
                      shareToWhatsApp("message", result.paths[0]!);
                    }
                  },
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
                              text:
                                  "${AppUtils.formatCurrency(widget.campaign.fundsRaised!)} /",
                            ),
                            TextSpan(
                              style: const TextStyle(color: Colors.black),
                              text:
                                  " ${AppUtils.formatCurrency(widget.campaign.fundraisingGoal!)}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    (widget.campaign.status == CampaignStatus.pending)
                        ? Row(
                            children: [
                              Icon(
                                Icons.history,
                                color: Colors.orange,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              Text(
                                CampaignStatus.pending.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          )
                        : (widget.campaign.status == CampaignStatus.completed)
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.history,
                                    color: AppColors.success,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    CampaignStatus.completed.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.success,
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.history,
                                    color: AppColors.textColor,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  (diasRestantes == 0)
                                      ? Text(
                                          "Está acontecer",
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      : (diasRestantes < 0)
                                          ? Text(
                                              AppDateUtilsHelper.formatDate(
                                                  data:
                                                      widget.campaign.endDate!),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          : Text(
                                              "Faltando $diasRestantes dias",
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
      ),
    );
  }
}
