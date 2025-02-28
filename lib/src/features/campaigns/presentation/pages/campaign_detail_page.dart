import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:utueji/src/features/campaigns/presentation/cubit/campaign_store_favorite_cubit/campaign_store_favorite_cubit.dart';
import 'package:utueji/src/features/favorites/domain/entities/favorite_entity.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/app_values.dart';
import '../../../favorites/presentation/cubit/favorite_cubit.dart';
import '../../../favorites/presentation/cubit/favorite_state.dart';
import '../../domain/entities/campaign_entity.dart';
import '../cubit/campaign_detail_cubit/campaign_detail_cubit.dart';
import '../cubit/campaign_detail_cubit/campaign_detail_state.dart';
import '../cubit/campaign_favorite_cubit/campaign_favorite_cubit.dart';
import '../cubit/campaign_favorite_cubit/campaign_favorite_state.dart';

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
  List<String> menuList = ["Sobre", "Documentos", "Actualizações", "Ajuda"];
  int selected = 0;

  @override
  void initState() {
    context.read<CampaignDetailCubit>().getCampaignById(widget.campaign.id!);
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
    return BlocBuilder<CampaignDetailCubit, CampaignDetailState>(
      builder: (context, state) {
        if (state is CampaignDetailLoaded) {
          final campaign = state.campaign;

          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                            imageUrl: campaign.imageCoverUrl!,
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
                                    campaign.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  trailing: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: AppUtils.favoriteWidget(
                                        context: context,
                                        itemId: widget.campaign.id!,
                                        itemType: "campaign"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Icon(Icons.location_on,
                                                size: 20),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                campaign.location!,
                                                style: const TextStyle(
                                                    fontSize: 14),
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
                                                style: TextStyle(fontSize: 14),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 50,
                            height: 50,
                            child: CachedNetworkImage(
                              imageUrl: campaign.ong!.coverImageUrl!,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        title: Text(
                          "Criado por",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          campaign.ong!.name!,
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
                          child: const Icon(Icons.call),
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Text(
                        "Valores a ser arrecadado",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
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
                                        .format(campaign.fundraisingGoal)
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
                                AppUtils.contributores(
                                    campaign.campaignContributors),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppValues.s10,
                                ), // Define o raio da borda aqui
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("Doar"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          // border: Border(
                          //   bottom: BorderSide(
                          //     width: 2,
                          //     color: Colors.black12,
                          //   ),
                          // ),
                          ),
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selected = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: (index == selected)
                                    ? const Border(
                                        bottom: BorderSide(
                                          width: 2,
                                          color: Colors.black,
                                        ),
                                      )
                                    : Border.all(
                                        width: 0, color: Colors.transparent),
                              ),
                              child: Center(
                                child: Text(
                                  menuList[index].toString(),
                                  style: (index != selected)
                                      ? Theme.of(context).textTheme.bodyMedium
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: menuList.length,
                      ),
                    ),
                    _menuWidget()
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _menuWidget() {
    switch (selected) {
      case 0:
        return AboutWidget(campaign: widget.campaign);
      case 1:
        return DocumentWidget();
      case 2:
        return UpdateWidget();
      case 3:
        return Text("data");
        return Text("3");
      default:
        return Text("4");
    }
  }
}

class UpdateWidget extends StatelessWidget {
  const UpdateWidget({
    super.key,
  });

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
                    const Text(
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
