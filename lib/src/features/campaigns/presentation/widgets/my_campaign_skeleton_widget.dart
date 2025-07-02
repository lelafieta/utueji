import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/images/app_images.dart';

class MyCampaignSkeletonWidget extends StatefulWidget {
  const MyCampaignSkeletonWidget({
    super.key,
  });

  @override
  State<MyCampaignSkeletonWidget> createState() =>
      _MyCampaignSkeletonWidgetState();
}

class _MyCampaignSkeletonWidgetState extends State<MyCampaignSkeletonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
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
                    child: Image.asset(
                      AppImages.coverBackground,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text("Campaign",
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                subtitle: Text("Date"),
                trailing: IconButton(
                  onPressed: () {},
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
                              text: "Money /",
                            ),
                            TextSpan(
                              style: const TextStyle(color: Colors.black),
                              text: " Money",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: AppColors.textColor,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Está acontecer",
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
