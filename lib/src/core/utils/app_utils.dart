import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/themes/app_colors.dart';

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
}
