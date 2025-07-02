import '../../features/campaigns/domain/enums/campaign_status.dart';

extension CampaignStatusExtension on CampaignStatus {
  /// Retorna o nome do status em inglês (para salvar no banco)
  String get value {
    return toString().split('.').last;
  }

  /// Retorna o nome do status em português (para exibição na UI)
  String get label {
    switch (this) {
      case CampaignStatus.all:
        return 'Todos';
      case CampaignStatus.active:
        return 'Ativa';
      case CampaignStatus.completed:
        return 'Concluída';
      case CampaignStatus.pending:
        return 'Pendente';
      case CampaignStatus.canceled:
        return 'Cancelada';
      case CampaignStatus.draft:
        return 'Rascunho';
      case CampaignStatus.scheduled:
        return 'Agendada';

      case CampaignStatus.paused:
        return 'Pausada';

      case CampaignStatus.expired:
        return 'Expirada';
    }
  }

  /// Converte uma string para o enum `CampaignStatus`
  static CampaignStatus fromString(String status) {
    return CampaignStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => CampaignStatus.draft, // Valor padrão
    );
  }

  /// Retorna uma lista com todos os status disponíveis
  static List<CampaignStatus> get allStatuses => CampaignStatus.values;
}
