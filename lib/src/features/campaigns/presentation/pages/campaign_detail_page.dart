import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
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
                                AppUtils.contributores(campaign.contributors),
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
                    _menuWidget(state.campaign)
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

  Widget _menuWidget(CampaignEntity campaign) {
    switch (selected) {
      case 0:
        return AboutWidget(campaign: campaign);
      case 1:
        return DocumentWidget(campaign: campaign);
      case 2:
        return UpdateWidget(campaign: campaign);
      case 3:
        return HelpWidget(campaign: campaign);
      default:
        return Text("4");
    }
  }
}

class UpdateWidget extends StatelessWidget {
  const UpdateWidget({super.key, required this.campaign});

  final CampaignEntity campaign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: (campaign.updates!.length == 0)
          ? Center(
              child: Text("Sem actualizações"),
            )
          : ListView.separated(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final update = campaign.updates![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Update #${index + 1}"),
                            Text(
                                "${AppUtils.formatDate(data: update.createdAt!)}"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          update.title!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(update.description!)
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: campaign.updates!.length,
            ),
    );
  }
}

class DocumentWidget extends StatelessWidget {
  final CampaignEntity campaign;
  const DocumentWidget({super.key, required this.campaign});

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
                child: (campaign.documents!.length < 1)
                    ? Center(child: Text("Vazio"))
                    : PDF(
                        enableSwipe: false,
                        swipeHorizontal: true,
                        autoSpacing: false,
                        pageFling: false,
                        fitEachPage: false,
                        fitPolicy: FitPolicy.HEIGHT,
                        pageSnap: false,
                        backgroundColor: Colors.grey,
                        preventLinkNavigation: true,
                        onError: (error) {
                          print(error.toString());
                        },
                        onPageError: (page, error) {
                          print('$page: ${error.toString()}');
                        },
                        onPageChanged: ((int? page, int? total) {
                          print('page change: $page/$total');
                        }),
                      ).fromUrl(campaign.documents![0].documentPath!),
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
                        child: (campaign.documents!.length <= 1)
                            ? Center(child: Text("Vazio"))
                            : PDF(
                                enableSwipe: false,
                                swipeHorizontal: true,
                                autoSpacing: false,
                                pageFling: false,
                                fitEachPage: false,
                                fitPolicy: FitPolicy.HEIGHT,
                                pageSnap: false,
                                backgroundColor: Colors.grey,
                                preventLinkNavigation: true,
                                onError: (error) {
                                  print(error.toString());
                                },
                                onPageError: (page, error) {
                                  print('$page: ${error.toString()}');
                                },
                                onPageChanged: ((int? page, int? total) {
                                  print('page change: $page/$total');
                                }),
                              ).fromUrl(campaign.documents![0].documentPath!),
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
                        child: (campaign.documents!.length <= 2)
                            ? Center(child: Text("Vazio"))
                            : PDF(
                                enableSwipe: false,
                                swipeHorizontal: true,
                                autoSpacing: false,
                                pageFling: false,
                                fitEachPage: false,
                                fitPolicy: FitPolicy.HEIGHT,
                                pageSnap: false,
                                backgroundColor: Colors.grey,
                                preventLinkNavigation: true,
                                onError: (error) {
                                  print(error.toString());
                                },
                                onPageError: (page, error) {
                                  print('$page: ${error.toString()}');
                                },
                                onPageChanged: ((int? page, int? total) {
                                  print('page change: $page/$total');
                                }),
                              ).fromUrl(campaign.documents![0].documentPath!),
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
                        child: (campaign.documents!.length < 4)
                            ? Center(child: Text("Vazio"))
                            : PDF(
                                enableSwipe: false,
                                swipeHorizontal: true,
                                autoSpacing: false,
                                pageFling: false,
                                fitEachPage: false,
                                fitPolicy: FitPolicy.HEIGHT,
                                pageSnap: false,
                                backgroundColor: Colors.grey,
                                preventLinkNavigation: true,
                                onError: (error) {
                                  print(error.toString());
                                },
                                onPageError: (page, error) {
                                  print('$page: ${error.toString()}');
                                },
                                onPageChanged: ((int? page, int? total) {
                                  print('page change: $page/$total');
                                }),
                              ).fromUrl(campaign.documents![0].documentPath!),
                      ),
                    ),
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
                    child: Text(
                      campaign.description!,
                      style: TextStyle(color: Colors.black87),
                    ),
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

class HelpWidget extends StatelessWidget {
  const HelpWidget({super.key, required this.campaign});
  final CampaignEntity campaign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          title: Text('Comments [${campaign.comments!.length}]'),
          children: [
            Container(
              height: 200, // Define a altura da lista de comentários
              child: ListView.builder(
                itemCount: campaign.comments!.length,
                itemBuilder: (context, index) {
                  final comment = campaign.comments![index];
                  return ListTile(
                    title: Text(comment.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comment.user!.fullName!,
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text(comment.description!),
                      ],
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            )
          ],
        ),
        ExpansionTile(
          title: Text('Frequently asked questions'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1. Qual é o objetivo desta campanha?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text(
                        '- Nosso objetivo é arrecadar fundos e itens para ajudar pessoas em situação de vulnerabilidade.'),
                    SizedBox(height: 8),
                    Text('2. Quem está organizando esta campanha?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text(
                        '- A campanha é organizada por um grupo de voluntários e apoiadores.'),
                    SizedBox(height: 8),
                    Text('3. Para onde vai o dinheiro ou os itens arrecadados?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text(
                        '- Todas as doações serão direcionadas para comunidades carentes e instituições beneficentes.'),
                    SizedBox(height: 8),
                    Text('4. Como posso contribuir?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text(
                        '- Você pode doar dinheiro, alimentos, roupas ou se voluntariar para ajudar na distribuição.'),
                    SizedBox(height: 8),
                    Text('5. Há um valor mínimo para doação?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text(
                        '- Não, qualquer contribuição é bem-vinda e fará a diferença!'),
                  ],
                ),
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Report this campaign'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selecione um motivo:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    items: [
                      DropdownMenuItem(value: 'Fraude', child: Text('Fraude')),
                      DropdownMenuItem(
                          value: 'Informações falsas',
                          child: Text('Informações falsas')),
                      DropdownMenuItem(
                          value: 'Uso indevido',
                          child: Text('Uso indevido dos fundos')),
                      DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                    ],
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Escolha um motivo'),
                  ),
                  SizedBox(height: 12),
                  Text('Descreva o problema:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Descreva o motivo do seu relatório...',
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Aqui adicionamos a lógica para enviar o relatório
                    },
                    child: Text('Enviar denúncia'),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Para qualquer dúvida contacte o respetivo ativista',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: [
                TextSpan(
                  text: 'Call: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: campaign.phoneNumber,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
