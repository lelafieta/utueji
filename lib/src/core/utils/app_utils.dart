import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:utueji/src/app/app_entity.dart';

import '../../config/themes/app_colors.dart';
import '../../features/campaigns/domain/entities/campaign_contributor_entity.dart';
import '../../features/campaigns/presentation/cubit/campaign_store_favorite_cubit/campaign_store_favorite_cubit.dart';
import '../../features/favorites/domain/entities/favorite_entity.dart';
import '../../features/favorites/presentation/cubit/favorite_cubit.dart';
import '../../features/favorites/presentation/cubit/favorite_state.dart';
import '../resources/icons/app_icons.dart';
import '../resources/images/app_images.dart';

class AppUtils {
  AppUtils._();

  static void errorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.error,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void successToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Positioned contributeUserItem(
      double left, double top, double bottom, String imagePath, Color color,
      {String? text}) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: (text != null) ? 30 : 16,
          height: 16,
          color: color,
          child: (text == null)
              ? CachedNetworkImage(
                  imageUrl: imagePath,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  static Positioned contributeUserDescription(
      double left, double top, double bottom, String imagePath, Color color,
      {String? text}) {
    return Positioned(
      left: left,
      top: top,
      bottom: bottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 16,
          color: color,
          child: (text == null)
              ? CachedNetworkImage(
                  imageUrl: imagePath,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  // static String formatDateWithWeekend(DateTime data) {
  //   // Formatar o dia da semana, dia, mês e hora
  //   String diaSemana = DateFormat.EEEE('pt_BR').format(data); // Sábado
  //   String dia = DateFormat.d().format(data); // 11
  //   String mes = DateFormat.MMMM('pt_BR').format(data); // Abril
  //   String horaMinuto = DateFormat('HH:mm').format(data); // 10:35

  //   // Concatenar tudo no formato desejado
  //   return '$diaSemana, $dia $mes $horaMinuto';
  // }

  // static String formatDateWithoutWeekend(DateTime data) {
  //   // Formatar o dia da semana, dia, mês e hora
  //   // String diaSemana = DateFormat.EEEE('pt_BR').format(data); // Sábado
  //   String dia = DateFormat.d().format(data); // 11
  //   String mes = DateFormat.MMMM('pt_BR').format(data); // Abril
  //   String horaMinuto = DateFormat('HH:mm').format(data); // 10:35

  //   // Concatenar tudo no formato desejado
  //   return '$dia $mes $horaMinuto';
  // }

  // static String formatDateWithYear(DateTime data) {
  //   // Formatar o dia da semana, dia, mês e hora
  //   // String diaSemana = DateFormat.EEEE('pt_BR').format(data); // Sábado
  //   String dia = DateFormat.d().format(data); // 11
  //   String mes = DateFormat.MMMM('pt_BR').format(data); // Abril
  //   String horaMinuto = DateFormat('HH:mm').format(data); // 10:35
  //   String ano = DateFormat('yyyy').format(data);

  //   // Concatenar tudo no formato desejado
  //   return '$dia $mes $ano';
  // }

  static String formatDate({
    required DateTime data,
    bool showWeekday = false,
    bool showDay = true,
    bool showMonth = true,
    bool showYear = true,
    bool showTime = false,
  }) {
    List<String> parts = [];

    if (showWeekday) {
      parts.add(
          DateFormat.EEEE('pt_BR').format(data).capitalize!); // Exemplo: Sábado
    }
    if (showDay) {
      parts.add(DateFormat.d().format(data)); // Exemplo: 11
    }
    if (showMonth) {
      parts.add(DateFormat.MMMM('pt_BR').format(data)); // Exemplo: Abril
    }
    if (showYear) {
      parts.add(DateFormat('yyyy').format(data)); // Exemplo: 2025
    }

    String dateString = parts.join(' de '); // Monta a data

    if (showTime) {
      String timeString = DateFormat('HH:mm').format(data); // Exemplo: 10:35
      return '$dateString às $timeString';
    }

    return dateString;
  }

  static String formatMoney(double money) {
    return NumberFormat.currency(locale: 'pt_PT', symbol: 'AOA').format(money);
  }

  static Widget contributores(
      List<CampaignContributorEntity>? campaignContributors) {
    if (campaignContributors == null || campaignContributors.isEmpty) {
      return Expanded(
        child: SizedBox(
          height: 16,
          child: Stack(
            children: [
              AppUtils.contributeUserItem(
                  0, 0, 0, AppImages.me, AppColors.primaryColor,
                  text: "0"),
              AppUtils.contributeUserDescription(
                  40, 0, 0, AppImages.me, Colors.transparent,
                  text: "Nenhuma Pessoa"),
            ],
          ),
        ),
      );
    } else if (campaignContributors.length == 1) {
      return Expanded(
        child: SizedBox(
          height: 16,
          child: Stack(
            children: [
              AppUtils.contributeUserItem(0, 0, 0,
                  campaignContributors[0].user!.avatarUrl!, Colors.black),
              AppUtils.contributeUserItem(
                  8,
                  0,
                  0,
                  campaignContributors[0].user!.avatarUrl!,
                  AppColors.primaryColor,
                  text: "1"),
              AppUtils.contributeUserDescription(45, 0, 0,
                  campaignContributors[0].user!.avatarUrl!, Colors.transparent,
                  text: "Contributo"),
            ],
          ),
        ),
      );
    } else if (campaignContributors.length == 2) {
      return Expanded(
        child: SizedBox(
          height: 16,
          child: Stack(
            children: [
              AppUtils.contributeUserItem(0, 0, 0,
                  campaignContributors[0].user!.avatarUrl!, Colors.transparent),
              AppUtils.contributeUserItem(8, 0, 0,
                  campaignContributors[1].user!.avatarUrl!, Colors.transparent),
              AppUtils.contributeUserItem(
                  16,
                  0,
                  0,
                  campaignContributors[0].user!.avatarUrl!,
                  AppColors.primaryColor,
                  text: "2"),
              AppUtils.contributeUserDescription(50, 0, 0,
                  campaignContributors[0].user!.avatarUrl!, Colors.transparent,
                  text: "Contributos"),
            ],
          ),
        ),
      );
    } else if (campaignContributors.length == 3) {
      return Expanded(
        child: SizedBox(
          height: 16,
          child: Stack(
            children: [
              AppUtils.contributeUserItem(0, 0, 0,
                  campaignContributors[0].user!.avatarUrl!, Colors.black),
              AppUtils.contributeUserItem(8, 0, 0,
                  campaignContributors[1].user!.avatarUrl!, Colors.red),
              AppUtils.contributeUserItem(16, 0, 0,
                  campaignContributors[2].user!.avatarUrl!, Colors.green),
              AppUtils.contributeUserItem(
                  24,
                  0,
                  0,
                  campaignContributors[0].user!.avatarUrl!,
                  AppColors.primaryColor,
                  text: "3"),
              AppUtils.contributeUserDescription(55, 0, 0,
                  campaignContributors[0].user!.avatarUrl!, Colors.transparent,
                  text: "Contributos"),
            ],
          ),
        ),
      );
    }
    return Expanded(
      child: SizedBox(
        height: 16,
        child: Stack(
          children: [
            AppUtils.contributeUserItem(0, 0, 0,
                campaignContributors[0].user!.avatarUrl!, Colors.black),
            AppUtils.contributeUserItem(
                8, 0, 0, campaignContributors[0].user!.avatarUrl!, Colors.red),
            AppUtils.contributeUserItem(16, 0, 0,
                campaignContributors[0].user!.avatarUrl!, Colors.green),
            AppUtils.contributeUserItem(
                24,
                0,
                0,
                campaignContributors[0].user!.avatarUrl!,
                AppColors.primaryColor,
                text: "+${campaignContributors.length - 3}"),
            AppUtils.contributeUserDescription(60, 0, 0,
                campaignContributors[0].user!.avatarUrl!, Colors.transparent,
                text: "Contributos"),
          ],
        ),
      ),
    );
  }

  static Widget favoriteWidget(
      {required BuildContext context,
      required String itemId,
      required String itemType}) {
    ValueNotifier<bool> isMyFavorite = ValueNotifier<bool>(false);
    return Container(
      color: Colors.white,
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons.heartBold,
                color: Colors.grey,
              ),
            );
          } else if (state is FavoriteLoaded) {
            bool isFavorite =
                state.favorites.any((element) => element.itemId == itemId);
            isMyFavorite.value = isFavorite;

            print(state.favorites.length);
            print(itemId);
            print(isFavorite);

            return ValueListenableBuilder(
                valueListenable: isMyFavorite,
                builder: (context, value, _) {
                  return RoundCheckBox(
                    uncheckedColor: Colors.transparent,
                    checkedColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    isChecked: value,
                    checkedWidget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AppIcons.heartBold,
                          color: Colors.red,
                        )),
                    uncheckedWidget: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        AppIcons.heartBold,
                      ),
                    ),
                    onTap: (selected) {
                      isMyFavorite.value = selected!;
                      // setState(() {
                      //   isMyFavorite = isMyFavorite;

                      if (selected) {
                        context.read<CampaignStoreFavoriteCubit>().addFavorite(
                              FavoriteEntity(
                                itemId: itemId,
                                userId: AppEntity.uid,
                                itemType: itemType,
                              ),
                            );
                      } else {
                        context
                            .read<CampaignStoreFavoriteCubit>()
                            .removeFavorite(
                              FavoriteEntity(
                                itemId: itemId,
                                userId: AppEntity.uid,
                                itemType: itemType,
                              ),
                            );
                      }
                    },
                  );
                });
          }
          return Text("DATA");
        },
      ),
    );
  }
}
