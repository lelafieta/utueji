import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'i_network_info.dart';

class NetWorkInfo extends INetWorkInfo {
  final InternetConnection netWorkInfo;

  NetWorkInfo({required this.netWorkInfo});

  @override
  Future<bool> get isConnected async => await netWorkInfo.hasInternetAccess;
}
