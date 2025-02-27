import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _keyFavorites = 'favorites';

  Future<void> toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];

    if (favorites.contains(id)) {
      favorites.remove(id); // Remove se já estiver salvo
    } else {
      favorites.add(id); // Adiciona se não estiver salvo
    }

    await prefs.setStringList(_keyFavorites, favorites);
  }

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyFavorites) ?? [];
  }

  Future<bool> isFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_keyFavorites) ?? [];
    return favorites.contains(id);
  }
}
