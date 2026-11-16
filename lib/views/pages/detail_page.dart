import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config.dart';
import '../../controllers/detail_controller.dart';
import '../../controllers/favorite_controller.dart';
import '../../utils/show_utils.dart';
import '../widgets/net_image.dart';
import '../widgets/rating_label.dart';

/// Menerima id show lewat Get.arguments (int).
class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final int _id;
  late final String _tag;
  late final DetailController _controller;
  final FavoriteController _fav = Get.find<FavoriteController>();

  @override
  void initState() {
    super.initState();
    _id = Get.arguments as int;
    // Tag unik supaya detail yang ditumpuk (Home -> Detail, Favorit -> Detail)
    // tidak berbagi controller yang sama.
    _tag = '${_id}_${UniqueKey()}';
    _controller = Get.put(DetailController(_id), tag: _tag);
  }

  @override
  void dispose() {
    Get.delete<DetailController>(tag: _tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.accent));
        }
        final show = _controller.show.value;
        if (_controller.error.value.isNotEmpty || show == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_controller.error.value, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _controller.fetchDetail,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          );
        }
        return _content(show);
      }),
    );
  }

  Widget _content(Map<String, dynamic> show) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: NetImage(
                showImage(show, original: true),
                fit: BoxFit.cover,
                height: 340,
                width: 240,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '${show['name']}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          RatingLabel(showRating(show), size: 15),
          const SizedBox(height: 4),
          Text(
            'Genre: ${showGenres(show)}',
            style: const TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          Obx(() {
            final isFav = _fav.isFavorite(_id);
            return SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFav ? AppColors.surface : AppColors.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AppColors.accent),
                  ),
                ),
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                label: Text(isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit'),
                onPressed: () async {
                  await _fav.toggle(slimShow(show));
                  Get.snackbar(
                    isFav ? 'Dihapus' : 'Ditambahkan',
                    isFav
                        ? '${show['name']} dihapus dari favorit.'
                        : '${show['name']} masuk ke favorit.',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 22),
          const Text('Overview', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
            stripHtml(show['summary'] as String?),
            textAlign: TextAlign.justify,
            style: const TextStyle(height: 1.45),
          ),
        ],
      ),
    );
  }
}
