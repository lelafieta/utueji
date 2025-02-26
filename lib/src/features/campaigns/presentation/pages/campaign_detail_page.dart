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
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/entities/campaign_entity.dart';

class CampaignDetailPage extends StatefulWidget {
  final CampaignEntity campaign;
  const CampaignDetailPage({super.key, required this.campaign});

  @override
  State<CampaignDetailPage> createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
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
                      imageUrl: widget.campaign.imageCoverUrl!,
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
                              widget.campaign.title!,
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 20),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          widget.campaign.location!,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.category, size: 20),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "Causa médica",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CachedNetworkImage(
                      imageUrl: widget.campaign.ong!.coverImageUrl!,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                title: Text(
                  "Criado por",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  widget.campaign.ong!.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: AppColors.grey,
                    ),
                  ),
                  child: Icon(Icons.call),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                "Valores a ser arrecadado",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    AppImages.healthcare,
                    width: 10,
                  ),
                ),
              ),
              title: Text(
                "Proxmo de 70% do fundo já foram colectados. A sua modesta doação pode impactar a urgência do necessitado.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
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
                                  fontWeight: FontWeight.bold, fontSize: 18),
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
                                  fontWeight: FontWeight.bold, fontSize: 18),
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
                                AppUtils.contributeUserDescription(
                                    60, 0, 0, AppImages.me, Colors.transparent,
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            const SizedBox(height: 15),
            const Divider(),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: AppColors.textColor,
                      unselectedLabelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      tabs: const [
                        Tab(
                          text: "Sobre",
                        ),
                        Tab(
                          text: "Documentos",
                        ),
                        Tab(
                          text: "Actualizações",
                        ),
                        Tab(
                          text: "Ajuda",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          AboutWidget(
                            campaign: widget.campaign,
                          ),
                          DocumentWidget(),
                          UpdateWidget(),
                          Center(child: Text('Página Perfil')),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateWidget extends StatelessWidget {
  const UpdateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Update #1"),
                        Text("26 Março 2024"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Algum titulo do update",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea com")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DocumentWidget extends StatelessWidget {
  const DocumentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12.withOpacity(.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.shieldTrust,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Documentos aprovados e verificados",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 280,
                height: 180,
                color: Colors.black12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                  width: 280,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 100,
                          color: Colors.black12,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 100,
                          color: Colors.black12,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 100,
                          color: Colors.black12,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class AboutWidget extends StatelessWidget {
  final CampaignEntity campaign;
  const AboutWidget({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: campaign.imageCoverUrl!,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(campaign.description!),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
