import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_utils.dart';
import '../../domain/entities/ong_entity.dart';

class OngWidget extends StatelessWidget {
  final OngEntity ong;
  const OngWidget({super.key, required this.ong});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(10),
            titleAlignment: ListTileTitleAlignment.center,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: ong.profileImageUrl!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            title: Text(
              "${ong.name}",
            ),
            subtitle: Text("${ong.bio}"),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Divider(color: AppColors.grey),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 16,
                        child: Stack(
                          children: [
                            AppUtils.contributeUserItem(
                                0, 0, 0, AppImages.me, Colors.black),
                            AppUtils.contributeUserItem(
                                8, 0, 0, AppImages.me, Colors.red),
                            AppUtils.contributeUserItem(
                                16, 0, 0, AppImages.me, Colors.green),
                            AppUtils.contributeUserItem(
                                24, 0, 0, AppImages.me, AppColors.primaryColor,
                                text: "+16"),
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                    const Text(
                      "Juntar-se",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
