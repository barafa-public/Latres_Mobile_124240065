import 'package:get/get.dart';
import '../services/tvmaze_service.dart';

class ShowController extends GetxController {
  final TvMazeService _service = TvMazeService();

  final RxList<Map<String, dynamic>> shows = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    fetchShows();
    super.onInit();
  }

  Future<void> fetchShows() async {
    try {
      isLoading.value = true;
      error.value = '';
      shows.assignAll(await _service.fetchShows());
    } catch (e) {
      error.value = 'Gagal memuat data. Periksa koneksi internet.\n$e';
    } finally {
      isLoading.value = false;
    }
  }
}
