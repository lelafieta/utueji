import 'dart:io';

import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_sharing_plus/social_sharing_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:utueji/src/config/routes/app_routes.dart';
import 'package:utueji/src/core/utils/app_utils.dart';
import 'package:utueji/src/features/campaigns/domain/entities/campaign_entity.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_date_utils_helper.dart';
import '../../../../core/utils/app_functions_utils_helper.dart';
import '../../../../core/utils/app_values.dart';
import '../cubit/my_campaign_detail_cubit/my_campaign_detail_cubit.dart';
import '../cubit/my_campaign_detail_cubit/my_campaign_detail_state.dart';

class MyCampaignDetailPage extends StatefulWidget {
  final CampaignEntity campaign;
  const MyCampaignDetailPage({super.key, required this.campaign});

  @override
  State<MyCampaignDetailPage> createState() => _MyCampaignDetailPageState();
}

class _MyCampaignDetailPageState extends State<MyCampaignDetailPage> {
  final List<String> filterOptions = [
    "Últimos 7 dias",
    "Últimos 30 dias",
    "Tudo",
  ];
  String selectedFilter = "Tudo";

  ValueNotifier<List<_ChartData>> filteredData =
      ValueNotifier<List<_ChartData>>([]);
  AppinioSocialShare appinioSocialShare = AppinioSocialShare();

  ValueNotifier<List<_ChartData>> allData = ValueNotifier<List<_ChartData>>([
    // _ChartData(DateTime(2024, 3, 1), 5000),
    // _ChartData(DateTime(2024, 3, 5), 7000),
    // _ChartData(DateTime(2024, 3, 10), 3000),
    // _ChartData(DateTime(2025, 3, 20), 8000),
    // _ChartData(DateTime(2025, 2, 15), 4000),
    // _ChartData(DateTime(2025, 1, 10), 9000),
  ]);

  final List<Map<String, dynamic>> donations = List.generate(
    3,
    (index) => {
      'name': 'Jhon',
      'date': '29 Feb 2024 | 8.23 am',
      'amount': '300000',
      'image': 'https://via.placeholder.com/50',
    },
  );

  @override
  void initState() {
    selectedFilter == "Tudo";
    context.read<MyCampaignDetailCubit>().getMyCampaignById(
      widget.campaign.id!,
    );

    // _filterData();
    super.initState();
  }

  void _filterData() {
    DateTime now = DateTime.now();
    if (selectedFilter == "Últimos 7 dias") {
      filteredData.value = allData.value
          .where((data) => data.date.isAfter(now.subtract(Duration(days: 7))))
          .toList();

      print(filteredData.value.length);
    } else if (selectedFilter == "Últimos 30 dias") {
      filteredData.value = allData.value
          .where((data) => data.date.isAfter(now.subtract(Duration(days: 30))))
          .toList();
      print(filteredData.value.length);
    } else {
      filteredData.value = List.from(allData.value);
      print(filteredData.value.length);
    }
  }

  void shareArticle() {
    String textToShare = "title\n\ncontent";
    Share.share(textToShare);
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

  copyClipboard(String message, String filePath) async {
    await appinioSocialShare.android.shareFilesToSystem(message, [filePath]);
  }

  shareToWhatsApp(String message, String filePath) async {
    await appinioSocialShare.android.shareToWhatsapp(message, filePath);
  }

  shareToFacebookApp(String message, String filePath) async {
    await appinioSocialShare.android.shareToFacebook(message, [filePath]);
  }

  shareToInstagramApp(String message, String filePath) async {
    await appinioSocialShare.android.shareToInstagramFeed(message, filePath);
  }

  shareToXApp(String message, String filePath) async {
    await appinioSocialShare.android.shareToTwitter(message, filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Campanha'),
        actions: [
          BlocBuilder<MyCampaignDetailCubit, MyCampaignDetailState>(
            builder: (context, state) {
              if (state is MyCampaignDetailLoaded) {
                final campaign = state.campaign;
                return PopupMenuButton<String>(
                  splashRadius: 10,
                  onSelected: (value) {
                    print("Selecionado: $value");
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: "edit",
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.editMyCampaignRoute,
                          arguments: widget.campaign,
                        );
                      },
                      child: Text("Editar"),
                    ),
                    PopupMenuItem(
                      value: "config",
                      child: Text("Configurações"),
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.myCampaignSettingsRoute,
                          arguments: widget.campaign,
                        );
                      },
                    ),
                  ],
                  icon: Icon(Icons.more_vert), // Ícone do botão
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<MyCampaignDetailCubit, MyCampaignDetailState>(
        builder: (context, state) {
          if (state is MyCampaignDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MyCampaignDetailError) {
            return Center(child: Text(state.message));
          } else if (state is MyCampaignDetailLoaded) {
            final campaign = state.campaign;
            final List<_ChartData> chartData = [];

            for (var i = 0; i < campaign.contributors!.length; i++) {
              final contribution = campaign.contributors![i];
              chartData.add(
                _ChartData(
                  contribution.createdAt!,
                  double.parse(contribution.money!.toString()),
                ),
              );
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              allData.value = chartData;
              _filterData();
            });

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: (widget.campaign.imageCoverUrl == null)
                            ? Image.asset(
                                AppImages.coverBackground,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: campaign.imageCoverUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                      ),
                    ),
                    title: Text(campaign.title!),
                    subtitle: Text(
                      AppDateUtilsHelper.formatDate(data: campaign.createdAt!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Arrecadado"),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(
                                            context,
                                          ).style,
                                          children: [
                                            TextSpan(
                                              text: AppUtils.formatCurrency(
                                                campaign.fundsRaised!,
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const TextSpan(text: " / "),
                                            TextSpan(
                                              text: AppUtils.formatCurrency(
                                                campaign.fundraisingGoal!,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Dias"),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(
                                            context,
                                          ).style,
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${AppDateUtilsHelper.daysElapsedSince(campaign.startDate!)} dias",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const TextSpan(text: " / "),
                                            TextSpan(
                                              text:
                                                  "${AppDateUtilsHelper.daysSinceDate(campaign.startDate!, campaign.endDate!)} dias",
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Doadores"),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(
                                            context,
                                          ).style,
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${campaign.contributors!.length}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: DashedCircularProgressBar.square(
                                    dimensions: 150,
                                    progress:
                                        AppFuncionsUtilsHelper.calculateFundraisingPercentage(
                                          campaign.fundsRaised,
                                          campaign.fundraisingGoal,
                                        ),
                                    maxProgress: 100,
                                    startAngle: 0,
                                    foregroundColor: Colors.green.withOpacity(
                                      .5,
                                    ),
                                    backgroundColor: Colors.green.withOpacity(
                                      .2,
                                    ),
                                    foregroundStrokeWidth: 15,
                                    backgroundStrokeWidth: 15,
                                    foregroundGapSize: 0,
                                    foregroundDashSize: 55,
                                    backgroundGapSize: 0,
                                    backgroundDashSize: 55,
                                    animation: false,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Faltam ${AppDateUtilsHelper.daysRemainingUntil(campaign.endDate!)} dias",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            "${AppFuncionsUtilsHelper.calculateFundraisingPercentage(campaign.fundsRaised, campaign.fundraisingGoal)}% de fundos\narrecadados",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Compartilhe outras pessoas para aumentar o alcance da sua campanha",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          String? result = (campaign.imageCoverUrl != null)
                              ? await downloadImage(campaign.imageCoverUrl!)
                              : null;

                          if (result != null) {
                            copyClipboard(
                              "${campaign.title}\n${campaign.description}",
                              result,
                            );
                          }
                        },
                        icon: SvgPicture.asset(
                          AppIcons.link,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () async {
                          String? result = (campaign.imageCoverUrl != null)
                              ? await downloadImage(campaign.imageCoverUrl!)
                              : null;

                          if (result != null) {
                            shareToWhatsApp(
                              "${campaign.title}\n${campaign.description}",
                              result,
                            );
                          }
                        },
                        icon: SvgPicture.asset(
                          AppIcons.whatsapp,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () async {
                          String? result = (campaign.imageCoverUrl != null)
                              ? await downloadImage(campaign.imageCoverUrl!)
                              : null;

                          if (result != null) {
                            shareToFacebookApp(
                              "${campaign.title}\n${campaign.description}",
                              result,
                            );
                          }
                        },
                        icon: SvgPicture.asset(
                          AppIcons.facebook,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () async {
                          String? result = (campaign.imageCoverUrl != null)
                              ? await downloadImage(campaign.imageCoverUrl!)
                              : null;

                          if (result != null) {
                            shareToInstagramApp(
                              "${campaign.title}\n${campaign.description}",
                              result,
                            );
                          }
                        },
                        icon: SvgPicture.asset(
                          AppIcons.instagram,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () async {
                          String? result = (campaign.imageCoverUrl != null)
                              ? await downloadImage(campaign.imageCoverUrl!)
                              : null;

                          if (result != null) {
                            shareToXApp(
                              "${campaign.title}\n${campaign.description}",
                              result,
                            );
                          }
                        },
                        icon: SvgPicture.asset(
                          AppIcons.x,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
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
                      child: Text(
                        "Retirar ${NumberFormat.currency(locale: 'pt_AO', symbol: 'AOA').format(campaign.fundsRaised!)}",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.campaignCreateUpdateRoute,
                          arguments: widget.campaign,
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Dê uma atualização",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        const SizedBox(width: 5),
                                        Icon(
                                          Icons.info,
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Publique alguma actualização ou agradeça os teus doadores sinta-te conectado pela sua causa",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Visão geral da doação",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                DropdownButton<String>(
                                  value: selectedFilter,
                                  items: filterOptions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedFilter = newValue!;
                                      _filterData();
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ValueListenableBuilder(
                              valueListenable: filteredData,
                              builder: (context, value, _) {
                                return SizedBox(
                                  height: 200,
                                  child: SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    primaryYAxis: NumericAxis(
                                      numberFormat: NumberFormat.compact(
                                        locale: 'pt_PT',
                                      ),
                                    ),
                                    trackballBehavior: TrackballBehavior(
                                      enable: true,
                                      activationMode: ActivationMode.singleTap,
                                      tooltipSettings: InteractiveTooltip(
                                        enable: true,
                                      ),
                                      builder: (context, TrackballDetails details) {
                                        final num value = details.point!.y!;
                                        final String date = details.point!.x
                                            .toString();

                                        final String formattedValue =
                                            NumberFormat.currency(
                                              locale: 'pt_AO',
                                              symbol: 'AOA',
                                            ).format(value);

                                        return Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                date, // Mostra a data correta
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                formattedValue, // Mostra o valor formatado
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    series: [
                                      LineSeries<_ChartData, String>(
                                        dataSource: value
                                            .where(
                                              (data) => data.amount != null,
                                            )
                                            .toList(),
                                        xValueMapper: (_ChartData data, _) =>
                                            "${data.date.day}/${data.date.month}",
                                        yValueMapper: (_ChartData data, _) =>
                                            data.amount,
                                        markerSettings: const MarkerSettings(
                                          isVisible: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Doadores",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: Colors.black45),
                        ),
                        Column(
                          children: [
                            Text("Total"),
                            Text(
                              "${campaign.contributors!.length} doadores",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    itemCount: campaign.contributors!.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final donor = campaign.contributors!.elementAt(index);
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 50,
                            height: 50,
                            child: (donor.isAnonymous == true)
                                ? Image.asset(
                                    AppImages.anonymousMask,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: campaign.user!.avatarUrl!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return const CircularProgressIndicator();
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                          ),
                        ),
                        title: (donor.isAnonymous == true)
                            ? Text("Anónimo")
                            : Text(donor.user!.fullName!),
                        subtitle: Text(
                          AppDateUtilsHelper.formatDate(
                            data: donor.createdAt!,
                            showTime: true,
                          ),
                        ),
                        trailing: Text(
                          AppUtils.formatCurrency(
                            num.parse(donor.money.toString()),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.date, this.amount);
  final DateTime date;
  final double amount;
}
