import 'package:get/get.dart';
import '../services/tvmaze_service.dart';

class DetailController extends GetxController {
  DetailController(this.id);
  final int id;
  final TvMazeService _service = TvMazeService();

  final Rxn<Map<String, dynamic>> show = Rxn<Map<String, dynamic>>();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    fetchDetail();
    super.onInit();
  }

  Future<void> fetchDetail() async {
    try {
      isLoading.value = true;
      error.value = '';
      show.value = await _service.fetchShowDetail(id);
    } catch (e) {
      error.value = 'Gagal memuat detail. Periksa koneksi internet.\n$e';
    } finally {
      isLoading.value = false;
    }
  }
}
