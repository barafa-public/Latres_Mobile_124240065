import 'package:get/get.dart';
import '../controllers/show_controller.dart';
import '../views/pages/detail_page.dart';
import '../views/pages/login_page.dart';
import '../views/pages/main_page.dart';
import 'app_routes.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowController>(() => ShowController());
  }
}

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(
      name: AppRoutes.main,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(name: AppRoutes.detail, page: () => const DetailPage()),
  ];
}
