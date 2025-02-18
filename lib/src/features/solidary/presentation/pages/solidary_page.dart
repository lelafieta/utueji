import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../explore/presentation/pages/explore_page.dart';
import '../../../home/presentation/pages/home_page.dart';

class SolidaryPage extends StatefulWidget {
  const SolidaryPage({super.key});

  @override
  State<SolidaryPage> createState() => _SolidaryPageState();
}

class _SolidaryPageState extends State<SolidaryPage> {
  int _currentIndex = 0;

  final List<String> iconPaths = [
    AppIcons.houseChimney,
    AppIcons.compassAlt,
    AppIcons.handsHeart,
    AppIcons.comments,
  ];

  final List<String> iconPathsBold = [
    AppIcons.houseChimneyBold,
    AppIcons.compassAltBold,
    AppIcons.handsHeartBold,
    AppIcons.commentsBold,
  ];

  final List<MenuItem> menuItems = [
    MenuItem(
        title: "Home",
        iconPath: AppIcons.houseChimney,
        activeIconPath: AppIcons.houseChimneyBold,
        isActive: true),
    MenuItem(
      title: "Explore",
      iconPath: AppIcons.compassAlt,
      activeIconPath: AppIcons.compassAltBold,
    ),
    MenuItem(
      title: "Campanhas",
      iconPath: AppIcons.handsHeart,
      activeIconPath: AppIcons.handsHeartBold,
    ),
    MenuItem(
      title: "Messages",
      iconPath: AppIcons.comments,
      activeIconPath: AppIcons.commentsBold,
    ),
  ];

  final List<Widget> pages = [
    const HomePage(),
    const ExplorePage(),
    const Center(child: Text("Favorites", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Profile", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex], // Alterna entre as páginas
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: menuItems.length,
        tabBuilder: (int index, bool isActive) {
          final menuItem = menuItems[index]; // Obtém o item do menu atual
          final color = isActive ? AppColors.primaryColor : Colors.grey;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                menuItem.currentIconPath,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              const SizedBox(height: 4), // Espaçamento entre ícone e texto
              Text(
                menuItem.title,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        },
        activeIndex: _currentIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() {
          _currentIndex = index;

          for (int i = 0; i < menuItems.length; i++) {
            menuItems[i] = menuItems[i].copyWith(isActive: i == index);
          }
        }),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String iconPath;
  final String activeIconPath;
  final bool isActive;
  final Color color;

  MenuItem({
    required this.title,
    required this.iconPath,
    required this.activeIconPath,
    this.isActive = false,
    this.color = Colors.grey,
  });

  String get currentIconPath => isActive ? activeIconPath : iconPath;

  MenuItem copyWith({bool? isActive, Color? color}) {
    return MenuItem(
      title: title,
      iconPath: iconPath,
      activeIconPath: activeIconPath,
      isActive: isActive ?? this.isActive,
      color: color ?? this.color,
    );
  }
}
