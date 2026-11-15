import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

/// Shell dengan BottomNavigationBar: Home, Favorit, Profil.
class MainPage extends StatelessWidget {
  MainPage({super.key});

  final RxInt _index = 0.obs;

  @override
  Widget build(BuildContext context) {
    final pages = [const HomePage(), const FavoritePage(), const ProfilePage()];
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: _index.value, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index.value,
          onTap: (i) => _index.value = i,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Favorit'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
