import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheHelper {
  static late FlutterSecureStorage secureStorage;

  //! Inicializa o armazenamento seguro
  static void init() {
    secureStorage = const FlutterSecureStorage();
  }

  //! Obtém um dado armazenado como String
  Future<String?> getDataString({
    required String key,
  }) async {
    return await secureStorage.read(key: key);
  }

  //! Salva um dado no armazenamento seguro
  Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await secureStorage.write(key: key, value: value);
  }

  //! Obtém um dado armazenado
  Future<String?> getData({required String key}) async {
    return await secureStorage.read(key: key);
  }

  //! Remove um dado específico
  Future<void> removeData({required String key}) async {
    await secureStorage.delete(key: key);
  }

  //! Verifica se uma chave existe
  Future<bool> containsKey({required String key}) async {
    return (await secureStorage.containsKey(key: key));
  }

  //! Limpa todos os dados armazenados
  Future<void> clearData() async {
    await secureStorage.deleteAll();
  }
}
