class AppDateUtilsHelper {
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
