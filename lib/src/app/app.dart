import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:utueji/src/features/ongs/presentation/cubit/ong_action_cubit/ong_action_cubit.dart';
import '../config/routes/app_pages.dart';
import '../config/themes/app_theme.dart';
import '../app/di.dart' as di;
import '../features/auth/presentation/cubit/auth_data/auth_data_cubit.dart';
import '../features/blogs/presentation/cubit/blog_cubit.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/cubit/initial_cubit/initial_cubit.dart';
import '../features/campaigns/presentation/cubit/campaign_action_cubit/campaign_action_cubit.dart';
import '../features/campaigns/presentation/cubit/campaign_detail_cubit/campaign_detail_cubit.dart';
import '../features/campaigns/presentation/cubit/campaign_store_favorite_cubit/campaign_store_favorite_cubit.dart';
import '../features/campaigns/presentation/cubit/campaign_urgent_cubit/campaign_urgent_cubit.dart';
import '../features/campaigns/presentation/cubit/category_campaign_cubit/category_campaign_cubit.dart';
import '../features/campaigns/presentation/cubit/my_campaign_cubit/my_campaign_cubit.dart';
import '../features/campaigns/presentation/cubit/my_campaign_detail_cubit/my_campaign_detail_cubit.dart';
import '../features/campaigns/presentation/cubit/update_action_cubit/update_action_cubit.dart';
import '../features/events/presentation/cubit/event_cubit.dart';
import '../features/favorites/presentation/cubit/favorite_cubit.dart';
import '../features/feeds/presentation/cubit/feed_cubit.dart';
import '../features/home/presentation/cubit/home_campaign_cubit/home_campaign_cubit.dart';
import '../features/home/presentation/cubit/home_profile_data_cubit/home_profile_data_cubit.dart';
import '../features/ongs/presentation/cubit/ong_cubit.dart';
import '../features/profile/presentation/cubit/count_donation_cubit/count_donation_cubit.dart';
import '../features/profile/presentation/cubit/profile_cubit.dart';
import '../features/solidary/cubit/solidary_cubit.dart';

class UtuejiApp extends StatelessWidget {
  const UtuejiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.instance<InitialCubit>()..appStarted()),
        BlocProvider(create: (_) => di.instance<AuthCubit>()),
        BlocProvider(create: (_) => di.instance<EventCubit>()),
        BlocProvider(create: (_) => di.instance<OngCubit>()),
        BlocProvider(create: (_) => di.instance<FeedCubit>()),
        BlocProvider(create: (_) => di.instance<BlogCubit>()),
        BlocProvider(create: (_) => di.instance<MyCampaignCubit>()),
        BlocProvider(create: (_) => di.instance<CampaignDetailCubit>()),
        BlocProvider(create: (_) => di.instance<HomeCampaignCubit>()),
        BlocProvider(create: (_) => di.instance<CampaignUrgentCubit>()),
        BlocProvider(create: (_) => di.instance<MyCampaignDetailCubit>()),
        BlocProvider(create: (_) => di.instance<CampaignStoreFavoriteCubit>()),
        BlocProvider(create: (_) => di.instance<FavoriteCubit>()),
        BlocProvider(create: (_) => di.instance<UpdateActionCubit>()),
        BlocProvider(create: (_) => di.instance<CampaignActionCubit>()),
        BlocProvider(create: (_) => di.instance<CategoryCampaignCubit>()),
        BlocProvider(
            create: (_) =>
                di.instance<HomeProfileDataCubit>()..getUserProfile()),
        BlocProvider(create: (_) => di.instance<ProfileCubit>()..getProfile()),
        BlocProvider(create: (_) => di.instance<CountDonationCubit>()),
        BlocProvider(
            create: (_) => di.instance<SolidaryCubit>()..getUserData()),
        BlocProvider(
            create: (_) => di.instance<AuthDataCubit>()..getUserData()),
        BlocProvider(create: (_) => di.instance<OngActionCubit>())
      ],
      child: GetMaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteManager.onGenerateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
