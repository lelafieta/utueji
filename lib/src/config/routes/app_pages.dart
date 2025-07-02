import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utueji/src/features/campaigns/presentation/pages/category_campaigns_page.dart';
import 'package:utueji/src/features/campaigns/presentation/pages/my_campaign_settings_page.dart';
import 'package:utueji/src/features/ongs/presentation/pages/create_ong_page.dart';
import 'package:utueji/src/features/payment/presentation/pages/payment_page.dart';
import '../../features/auth/presentation/cubit/initial_cubit/initial_cubit.dart';
import '../../features/auth/presentation/cubit/initial_cubit/initial_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/blogs/presentation/pages/blog_page.dart';
import '../../features/campaigns/domain/entities/campaign_entity.dart';
import '../../features/campaigns/presentation/pages/campaign_create_update_page.dart';
import '../../features/campaigns/presentation/pages/campaign_created_success_page.dart';
import '../../features/campaigns/presentation/pages/campaign_detail_page.dart';
import '../../features/campaigns/presentation/pages/create_campaign_page.dart';
import '../../features/campaigns/presentation/pages/edit_my_campaign_page.dart';
import '../../features/campaigns/presentation/pages/my_campaign_detail_page.dart';
import '../../features/campaigns/presentation/pages/my_campaign_page.dart';
import '../../features/campaigns/presentation/pages/campaign_urgent_page.dart';
import '../../features/categories/domain/entities/category_entity.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/events/domain/entities/event_entity.dart';
import '../../features/events/presentation/pages/event_detail_page.dart';
import '../../features/events/presentation/pages/event_page.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/favorites/presentation/pages/favorite_page.dart';
import '../../features/feeds/presentation/pages/feed_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/ongs/domain/entities/ong_entity.dart';
import '../../features/ongs/presentation/pages/ong_profile_page.dart';
import '../../features/ongs/presentation/pages/success_register_ong_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/solidary/presentation/pages/solidary_page.dart';
import '../../features/splash&onboarding/presentation/pages/on_boarding_page.dart';
import 'app_routes.dart';

class RouteManager {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.loginRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const LoginPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.rootRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocBuilder<InitialCubit, InitialState>(
              builder: (context, authState) {
                final map = routeSettings.arguments == null
                    ? null
                    : routeSettings.arguments as Map<String, dynamic>;

                int? currentIndex = map?['currentIndex'];

                if (authState is Initialized) {
                  return SolidaryPage(
                    currentIndex: currentIndex,
                  );
                } else {
                  return const OnBoardingPage();
                }
              },
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.solidaryRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SolidaryPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.homeRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return HomePage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.exploreRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ExplorePage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.myCampaignRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return MyCampaignPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.myCampaignDetailRoute:
        final campaign = routeSettings.arguments as CampaignEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return MyCampaignDetailPage(campaign: campaign);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.chatRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ChatPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.campaignDetail:
        final campaign = routeSettings.arguments as CampaignEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CampaignDetailPage(campaign: campaign);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.blogRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlogPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.feedRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FeedPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.eventRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return EventPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.eventDetail:
        final event = routeSettings.arguments as EventEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return EventDetailPage(event: event);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.ongProfileRoute:
        final ong = routeSettings.arguments as OngEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return OngProfilePage(ong: ong);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.favoriteRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const FavoritePage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.campaignUrgentsRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const CampaignUrgentPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.campaignCreateUpdateRoute:
        final campaign = routeSettings.arguments as CampaignEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CampaignCreateUpdatePage(campaign: campaign);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.createCampaignRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CreateCampaignPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.createCampaignSuccessRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CampaignCreatedSuccessPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.editMyCampaignRoute:
        final campaign = routeSettings.arguments as CampaignEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return EditMyCampaignPage(campaign: campaign);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.myCampaignSettingsRoute:
        final campaign = routeSettings.arguments as CampaignEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return MyCampaignSettingsPage(campaign: campaign);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.categoryCampaignsRoute:
        final category = routeSettings.arguments as CategoryEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CategoryCampaignPage(category: category);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.paymentRoute:
        final campaign = routeSettings.arguments as CampaignEntity;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return PaymentPage(campaign: campaign);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.profileRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ProfilePage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );

      case AppRoutes.createOngRoute:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CreateOngPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case AppRoutes.successRegisterOng:
        final message = routeSettings.arguments as String;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SuccessRegisterOngPage(successMessage: message);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Text("Rota não existente"),
        );
    }
  }
}
