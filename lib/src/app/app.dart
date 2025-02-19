import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../config/routes/app_pages.dart';
import '../config/themes/app_theme.dart';
import '../app/di.dart' as di;
import '../features/campaigns/presentation/cubit/campaign_cubit.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/cubit/initial_cubit/initial_cubit.dart';
import '../features/events/presentation/cubit/event_cubit.dart';
import '../features/feeds/presentation/cubit/feed_cubit.dart';
import '../features/ongs/presentation/cubit/ong_cubit.dart';

class UtuejiApp extends StatelessWidget {
  const UtuejiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.instance<AuthCubit>()),
        BlocProvider(create: (_) => di.instance<CampaignCubit>()),
        BlocProvider(create: (_) => di.instance<EventCubit>()),
        BlocProvider(create: (_) => di.instance<OngCubit>()),
        BlocProvider(create: (_) => di.instance<FeedCubit>()),
        BlocProvider(create: (_) => di.instance<InitialCubit>()..appStarted()),
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
