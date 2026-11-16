import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config.dart';
import '../../controllers/favorite_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/net_image.dart';
import '../widgets/rating_label.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fav = Get.find<FavoriteController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Favorit', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        if (fav.favorites.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada show favorit.',
              style: TextStyle(color: AppColors.textMuted),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: fav.favorites.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = fav.favorites[index];
            final id = item['id'] as int;
            return Material(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Get.toNamed(AppRoutes.detail, arguments: id),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: NetImage(item['image'] as String?, width: 50, height: 70),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item['name']}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            RatingLabel('${item['rating']}'),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.accent),
                        tooltip: 'Hapus',
                        onPressed: () => fav.remove(id),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
