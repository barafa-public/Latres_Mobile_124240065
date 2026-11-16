import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../config.dart';

/// Favorit disimpan di Hive (box 'favorites', key = id show, value = Map ringkas).
class FavoriteController extends GetxController {
  late final Box _box;
  final RxList<Map<String, dynamic>> favorites = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    _box = Hive.box(AppConfig.favoritesBox);
    _load();
    super.onInit();
  }

  void _load() {
    favorites.assignAll(
      _box.values.map((e) => Map<String, dynamic>.from(e as Map)),
    );
  }

  /// Panggil di dalam Obx agar UI ikut reaktif.
  bool isFavorite(int id) => favorites.any((f) => f['id'] == id);

  Future<void> toggle(Map<String, dynamic> show) async {
    final id = show['id'] as int;
    if (_box.containsKey(id)) {
      await _box.delete(id);
    } else {
      await _box.put(id, show);
    }
    _load();
  }

  Future<void> remove(int id) async {
    await _box.delete(id);
    _load();
  }
}
