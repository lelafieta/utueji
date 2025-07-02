import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:utueji/src/config/routes/app_routes.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../../core/utils/app_utils.dart';
import '../../domain/entities/ong_entity.dart';

class OngWidget extends StatelessWidget {
  final OngEntity ong;
  const OngWidget({super.key, required this.ong});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.ongProfileRoute, arguments: ong);
      },
      child: Card(
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
                child: (ong.profileImageUrl == null)
                    ? Image.asset(AppImages.coverBackground)
                    : CachedNetworkImage(
                        imageUrl: ong.profileImageUrl!,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
              title: Row(
                children: [
                  Flexible(
                    child: Text(
                      "${ong.name}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset(
                    width: 16,
                    AppIcons.shieldTrust,
                    color: AppColors.blueColor,
                  ),
                ],
              ),
              subtitle: Text(
                "${ong.bio}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
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
                                  0, 0, 0, null, Colors.black),
                              AppUtils.contributeUserItem(
                                  8, 0, 0, null, Colors.red),
                              AppUtils.contributeUserItem(
                                  16, 0, 0, null, Colors.green),
                              AppUtils.contributeUserItem(
                                  24, 0, 0, null, AppColors.primaryColor,
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
      ),
    );
  }
}
