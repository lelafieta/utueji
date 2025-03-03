import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppDateUtilsHelper {
  static String formatDate({
    required DateTime data,
    bool showWeekday = false,
    bool showDay = true,
    bool showMonth = true,
    bool abbreviatedMonth = true, // Novo parâmetro para abreviar o mês
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
      String monthFormat = abbreviatedMonth ? 'MMM' : 'MMMM';
      parts.add(DateFormat(monthFormat, 'pt_BR')
          .format(data)); // Exemplo: Abr ou Abril
    }
    if (showYear) {
      parts.add(DateFormat('yyyy').format(data)); // Exemplo: 2025
    }

    String dateString = parts.join(' de '); // Monta a data

    if (showTime) {
      String timeString = DateFormat('HH:mm').format(data); // Exemplo: 10:35
      return '$dateString | $timeString';
    }

    return dateString;
  }

  /// Retorna a diferença em dias entre hoje e a data fornecida (pode ser negativo se a data for no passado)
  static int daysRemainingUntil(DateTime targetDate) {
    DateTime today = DateTime.now();

    // Normaliza as datas para garantir a contagem exata de dias
    DateTime normalizedTarget =
        DateTime(targetDate.year, targetDate.month, targetDate.day);
    DateTime normalizedToday = DateTime(today.year, today.month, today.day);

    return normalizedTarget.difference(normalizedToday).inDays;
  }

  /// Retorna quantos dias já se passaram desde a data até hoje (sempre positivo)
  static String daysSinceDate(DateTime dateSince, DateTime dateUntil) {
    // Normaliza as datas para meia-noite para garantir que os dias sejam contados corretamente
    DateTime normalizedSince =
        DateTime(dateSince.year, dateSince.month, dateSince.day);
    DateTime normalizedUntil =
        DateTime(dateUntil.year, dateUntil.month, dateUntil.day);

    return normalizedUntil.difference(normalizedSince).inDays.toString();
  }

  /// Retorna quantos dias faltam para a data (zero ou positivo, sem valores negativos)
  static int daysElapsedSince(DateTime startDate) {
    DateTime today = DateTime.now();

    // Normaliza as datas para meia-noite (00:00:00)
    DateTime normalizedStart =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime normalizedToday = DateTime(today.year, today.month, today.day);

    return normalizedToday.difference(normalizedStart).inDays;
  }
}
