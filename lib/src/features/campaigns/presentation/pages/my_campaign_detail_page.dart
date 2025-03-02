import 'package:flutter/material.dart';

import '../../domain/entities/campaign_entity.dart';

class MyCampaignDetailPage extends StatefulWidget {
  final CampaignEntity camapign;
  const MyCampaignDetailPage({super.key, required this.camapign});

  @override
  State<MyCampaignDetailPage> createState() => _MyCampaignDetailPageState();
}

class _MyCampaignDetailPageState extends State<MyCampaignDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
