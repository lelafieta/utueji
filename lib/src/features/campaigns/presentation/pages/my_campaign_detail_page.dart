import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:utueji/src/core/utils/app_utils.dart';
import 'package:utueji/src/features/campaigns/domain/entities/campaign_entity.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/utils/app_values.dart';

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

  final List<Map<String, dynamic>> donations = List.generate(
    3,
    (index) => {
      'name': 'Jhon',
      'date': '29 Feb 2024 | 8.23 am',
      'amount': '300000',
      'image': 'https://via.placeholder.com/50',
    },
  );

  final List<_ChartData> chartData = [
    _ChartData("7/12", 1000),
    _ChartData("8/12", 2500),
    _ChartData("10/12", 4000),
    _ChartData("11/12", 6000),
    _ChartData("12/12", 3000),
  ];

  @override
  void initState() {
    // context.read<MyCampaignCubit>().getAllMyCamapigns();
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
      body: SingleChildScrollView(
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
                    imageUrl: widget.campaign.imageCoverUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ),
              title: Text(widget.campaign.title!),
              subtitle:
                  Text(AppUtils.formatDate(data: widget.campaign.createdAt!)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Arrecadado"),
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
                                                fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: AppUtils.formatCurrency(
                                            widget.campaign.fundsRaised!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const TextSpan(text: " / "),
                                      TextSpan(
                                          text: AppUtils.formatCurrency(
                                              widget.campaign.fundraisingGoal!))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Dias"),
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: "28 Dias",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const TextSpan(text: " / "),
                                      TextSpan(text: "30 dias")
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Doadores"),
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: "2",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
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
                              progress: 75,
                              maxProgress: 100,
                              startAngle: 0,
                              foregroundColor: Colors.green.withOpacity(.5),
                              backgroundColor: Colors.green.withOpacity(.2),
                              foregroundStrokeWidth: 15,
                              backgroundStrokeWidth: 15,
                              foregroundGapSize: 0,
                              foregroundDashSize: 55,
                              backgroundGapSize: 0,
                              backgroundDashSize: 55,
                              animation: false,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Faltam 2 dias",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Text(
                                      "75% de fundos\narrecadados",
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
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
                              style: Theme.of(context).textTheme.titleMedium),
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
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: [
                            LineSeries<_ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (_ChartData data, _) => data.date,
                              yValueMapper: (_ChartData data, _) => data.amount,
                              markerSettings:
                                  const MarkerSettings(isVisible: true),
                            ),
                          ],
                        ),
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
                  Text("Doadores",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black45)),
                  Column(
                    children: [
                      Text("Total"),
                      Text("2 doadores",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              itemCount: donations.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final donor = donations[index];
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(donor['image'])),
                  title: Text(donor['name']),
                  subtitle: Text(donor['date']),
                  trailing: Text(
                    AppUtils.formatCurrency(num.parse(donor['amount'])),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.date, this.amount);
  final String date;
  final double amount;
}
