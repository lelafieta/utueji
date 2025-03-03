import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:utueji/src/core/utils/app_utils.dart';
import 'package:utueji/src/features/campaigns/domain/entities/campaign_entity.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
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
    "Hoje",
    "Esta Semana",
    "Este Mês",
    "Todos"
  ];
  String selectedFilter = "Hoje";
  List<_ChartData> filteredData = [];

  ValueNotifier<List<_ChartData>> allData = ValueNotifier<List<_ChartData>>([]);

  final List<Map<String, dynamic>> donations = List.generate(
    3,
    (index) => {
      'name': 'Jhon',
      'date': '29 Feb 2024 | 8.23 am',
      'amount': '300000',
      'image': 'https://via.placeholder.com/50',
    },
  );

  void _filterChartData() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    setState(() {
      if (selectedFilter == "Hoje") {
        filteredData = allData.value
            .where((data) => _isSameDay(data.date, today))
            .toList();
      } else if (selectedFilter == "Esta Semana") {
        filteredData = allData.value
            .where((data) => _isSameWeek(data.date, today))
            .toList();
      } else if (selectedFilter == "Este Mês") {
        filteredData = allData.value
            .where((data) => _isSameMonth(data.date, today))
            .toList();
      } else {
        filteredData = List.from(allData.value);
      }
    });
  }

  bool _isSameDay(String dateStr, DateTime referenceDate) {
    DateTime date = DateFormat("dd/MM").parse(dateStr);
    return date.day == referenceDate.day && date.month == referenceDate.month;
  }

  bool _isSameWeek(String dateStr, DateTime referenceDate) {
    DateTime date = DateFormat("dd/MM").parse(dateStr);
    int currentWeek = _getWeekOfYear(referenceDate);
    int dateWeek = _getWeekOfYear(date);
    return currentWeek == dateWeek && date.year == referenceDate.year;
  }

  bool _isSameMonth(String dateStr, DateTime referenceDate) {
    DateTime date = DateFormat("dd/MM").parse(dateStr);
    return date.month == referenceDate.month && date.year == referenceDate.year;
  }

  int _getWeekOfYear(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  @override
  void initState() {
    _filterChartData();
    context
        .read<MyCampaignDetailCubit>()
        .getMyCampaignById(widget.campaign.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Campanha'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: BlocBuilder<MyCampaignDetailCubit, MyCampaignDetailState>(
        builder: (context, state) {
          if (state is MyCampaignDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MyCampaignDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is MyCampaignDetailLoaded) {
            final campaign = state.campaign;
            final List<_ChartData> chartData = [];

            for (var i = 0; i < campaign.contributors!.length; i++) {
              final contribution = campaign.contributors![i];
              chartData.add(_ChartData(
                  "${contribution.createdAt!.day}/${contribution.createdAt!.month}",
                  double.parse(contribution.money!.toString())));
            }

            allData.value = chartData;

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
                        child: CachedNetworkImage(
                          imageUrl: campaign.imageCoverUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                          ),
                        ),
                      ),
                    ),
                    title: Text(campaign.title!),
                    subtitle: Text(AppDateUtilsHelper.formatDate(
                        data: campaign.createdAt!)),
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
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                              text: AppUtils.formatCurrency(
                                                  campaign.fundsRaised!),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const TextSpan(text: " / "),
                                            TextSpan(
                                                text: AppUtils.formatCurrency(
                                                    campaign.fundraisingGoal!))
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Dias"),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${AppDateUtilsHelper.daysElapsedSince(campaign.startDate!)} dias",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const TextSpan(text: " / "),
                                            TextSpan(
                                                text:
                                                    "${AppDateUtilsHelper.daysSinceDate(campaign.startDate!, campaign.endDate!)} dias")
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Doadores"),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${campaign.contributors!.length}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                    progress: AppFuncionsUtilsHelper
                                        .calculateFundraisingPercentage(
                                            campaign.fundsRaised,
                                            campaign.fundraisingGoal),
                                    maxProgress: 100,
                                    startAngle: 0,
                                    foregroundColor:
                                        Colors.green.withOpacity(.5),
                                    backgroundColor:
                                        Colors.green.withOpacity(.2),
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
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
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
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.link,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.whatsapp,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.facebook,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppIcons.instagram,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {},
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
                      child: Text("Retirar AOA 300,00"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        Icons.info,
                                        color: AppColors.primaryColor,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                      "Publique alguma actualização ou agradeça os teus doadores sinta-te conectado pela sua causa")
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
                                Text("Visão geral da doação",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                DropdownButton<String>(
                                  value: selectedFilter,
                                  items: filterOptions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    print(newValue);
                                    setState(() {
                                      selectedFilter = newValue!;
                                      _filterChartData();
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ValueListenableBuilder(
                                valueListenable: allData,
                                builder: (context, value, _) {
                                  return SizedBox(
                                    height: 200,
                                    child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      primaryYAxis: NumericAxis(
                                        numberFormat: NumberFormat.compact(
                                            locale:
                                                'pt_PT'), // Formata 1000 → 1K, 1M, etc.
                                      ),
                                      trackballBehavior: TrackballBehavior(
                                        enable: true,
                                        activationMode:
                                            ActivationMode.singleTap,
                                        tooltipSettings:
                                            InteractiveTooltip(enable: true),
                                        builder: (context,
                                            TrackballDetails details) {
                                          final value = details.point!.y as num;
                                          final formattedValue =
                                              NumberFormat.currency(
                                                      locale: 'pt_AO',
                                                      symbol: 'AOA')
                                                  .format(value);

                                          return Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              formattedValue, // Mostra o valor correto formatado
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        },
                                      ),
                                      series: [
                                        LineSeries<_ChartData, String>(
                                          dataSource: value
                                              .where(
                                                  (data) => data.amount != null)
                                              .toList(),
                                          xValueMapper: (_ChartData data, _) =>
                                              data.date,
                                          yValueMapper: (_ChartData data, _) =>
                                              data.amount,
                                          markerSettings: const MarkerSettings(
                                              isVisible:
                                                  true), // Mostra pontos nos valores reais
                                        ),
                                      ],
                                    ),
                                  );
                                }),
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
                        Text("Doadores",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black45)),
                        Column(
                          children: [
                            Text("Total"),
                            Text("${campaign.contributors!.length} doadores",
                                style: Theme.of(context).textTheme.titleMedium),
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
                            child: CachedNetworkImage(
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
                        title: Text(donor.user!.fullName!),
                        subtitle: Text(AppDateUtilsHelper.formatDate(
                            data: donor.createdAt!, showTime: true)),
                        trailing: Text(
                          AppUtils.formatCurrency(
                              num.parse(donor.money.toString())),
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
  final String date;
  final double amount;
}
