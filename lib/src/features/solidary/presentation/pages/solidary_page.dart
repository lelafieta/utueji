import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:utueji/src/config/routes/app_routes.dart';
import 'package:utueji/src/features/home/presentation/pages/home_page.dart';
import 'package:utueji/src/features/profile/presentation/cubit/profile_cubit.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../campaigns/presentation/pages/my_campaign_page.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import '../../../explore/presentation/pages/explore_page.dart';
import '../../../home/presentation/cubit/home_profile_data_cubit/home_profile_data_cubit.dart';
import '../../../profile/presentation/cubit/count_donation_cubit/count_donation_cubit.dart';
import '../../cubit/solidary_cubit.dart';

class SolidaryPage extends StatefulWidget {
  final int? currentIndex;
  SolidaryPage({super.key, this.currentIndex});

  @override
  State<SolidaryPage> createState() => _SolidaryPageState();
}

class _SolidaryPageState extends State<SolidaryPage> {
  int _currentIndex = 0;

  final List<String> iconPaths = [
    AppIcons.houseChimney,
    AppIcons.compassAlt,
    AppIcons.heartPartnerHandshake,
    AppIcons.comments,
  ];

  final List<String> iconPathsBold = [
    AppIcons.houseChimneyBold,
    AppIcons.compassAltBold,
    AppIcons.heartPartnerHandshakeBold,
    AppIcons.commentsBold,
  ];

  final List<MenuItem> menuItems = [
    MenuItem(
        title: "Home",
        iconPath: AppIcons.houseChimney,
        activeIconPath: AppIcons.houseChimneyBold,
        isActive: true),
    MenuItem(
      title: "Nvegador",
      iconPath: AppIcons.compassAlt,
      activeIconPath: AppIcons.compassAltBold,
    ),
    MenuItem(
      title: "Campanhas",
      iconPath: AppIcons.heartPartnerHandshake,
      activeIconPath: AppIcons.heartPartnerHandshakeBold,
    ),
    MenuItem(
      title: "Chat",
      iconPath: AppIcons.comments,
      activeIconPath: AppIcons.commentsBold,
    ),
  ];

  final List<Widget> pages = [
    const HomePage(),
    const ExplorePage(),
    const MyCampaignPage(),
    const ChatPage(),
  ];
  Map<String, dynamic>? arguments = Get.arguments;
  @override
  void initState() {
    if (widget.currentIndex != null) {
      _currentIndex = widget.currentIndex!;
    }
    super.initState();
    context.read<CountDonationCubit>()..counter();
    context.read<ProfileCubit>()..getProfile();
    // context.read<SolidaryCubit>()..getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SolidaryCubit, SolidaryState>(
        builder: (context, state) {
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is AuthLoading) {
                EasyLoading.show(status: "Processando...");
              } else if (state is AuthFailure) {
                EasyLoading.show(status: "${state.failure}");
              } else if (state is AuthSignedOut) {
                Get.toNamed(AppRoutes.loginRoute);
              }
            },
            child: pages[_currentIndex],
          );
        },
      ),
      bottomNavigationBar: buttomNavigationBar(),
    );
  }

  AnimatedBottomNavigationBar buttomNavigationBar() {
    return AnimatedBottomNavigationBar.builder(
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
