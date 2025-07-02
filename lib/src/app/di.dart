import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/cache/secure_storage.dart';
import '../core/network/i_network_info.dart';
import '../core/network/network_info.dart';
import '../features/auth/data/datasources/auth_datasource.dart';
import '../features/auth/data/datasources/i_auth_datasource.dart';
import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/domain/repositories/i_auth_repository.dart';
import '../features/auth/domain/usecases/get_auth_user_usecase.dart';
import '../features/auth/domain/usecases/is_sign_in_usecase.dart';
import '../features/auth/domain/usecases/sign_in_usecase.dart';
import '../features/auth/domain/usecases/sign_in_with_otp_usecase.dart';
import '../features/auth/domain/usecases/sign_out_usecase.dart';
import '../features/auth/domain/usecases/sign_up_usecase.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/cubit/auth_data/auth_data_cubit.dart';
import '../features/auth/presentation/cubit/initial_cubit/initial_cubit.dart';
import '../features/blogs/data/datasources/blog_datasource.dart';
import '../features/blogs/data/datasources/i_blog_datasource.dart';
import '../features/blogs/data/repositories/blog_repository.dart';
import '../features/blogs/domain/repositories/i_blog_repository.dart';
import '../features/blogs/domain/usecases/fetch_blogs_usecase.dart';
import '../features/blogs/domain/usecases/fetch_latest_blogs_usecase.dart';
import '../features/blogs/presentation/cubit/blog_cubit.dart';
import '../features/campaigns/data/datasources/donation_datasource.dart';
import '../features/campaigns/data/datasources/i_campaign_datasource.dart';
import '../features/campaigns/data/datasources/campaign_datasource.dart';
import '../features/campaigns/data/datasources/i_donation_datasource.dart';
import '../features/campaigns/data/datasources/i_update_datasource.dart';
import '../features/campaigns/data/datasources/update_datasource.dart';
import '../features/campaigns/data/repositories/campaign_repository.dart';
import '../features/campaigns/data/repositories/donation_repository.dart';
import '../features/campaigns/data/repositories/update_repository.dart';
import '../features/campaigns/domain/repositories/i_campaign_repository.dart';
import '../features/campaigns/domain/repositories/i_donation_respository.dart';
import '../features/campaigns/domain/repositories/i_update_repository.dart';
import '../features/campaigns/domain/usecases/create_campaign_update_usecase.dart';
import '../features/campaigns/domain/usecases/create_campaign_usecase.dart';
import '../features/campaigns/domain/usecases/delete_campaign_update_usecase.dart';
import '../features/campaigns/domain/usecases/delete_campaign_usecase.dart';
import '../features/campaigns/domain/usecases/get_all_campaigns_usecase.dart';
import '../features/campaigns/domain/usecases/get_all_my_campaigns_usecase.dart';
import '../features/campaigns/domain/usecases/get_all_urgent_campaigns_usecase.dart';
import '../features/campaigns/domain/usecases/get_campaign_by_id_usecase.dart';
import '../features/campaigns/domain/usecases/get_count_my_donations_usecase.dart';
import '../features/campaigns/domain/usecases/get_latest_urgent_campaigns_usecase.dart';
import '../features/campaigns/domain/usecases/update_campaign_update_usecase.dart';
import '../features/campaigns/domain/usecases/update_campaign_usecase.dart';
import '../features/campaigns/presentation/cubit/campaign_action_cubit/campaign_action_cubit.dart';
import '../features/campaigns/presentation/cubit/campaign_detail_cubit/campaign_detail_cubit.dart';
import '../features/campaigns/presentation/cubit/campaign_store_favorite_cubit/campaign_store_favorite_cubit.dart';
import '../features/campaigns/presentation/cubit/campaign_urgent_cubit/campaign_urgent_cubit.dart';
import '../features/campaigns/presentation/cubit/category_campaign_cubit/category_campaign_cubit.dart';
import '../features/campaigns/presentation/cubit/my_campaign_cubit/my_campaign_cubit.dart';
import '../features/campaigns/presentation/cubit/my_campaign_detail_cubit/my_campaign_detail_cubit.dart';
import '../features/campaigns/presentation/cubit/update_action_cubit/update_action_cubit.dart';
import '../features/events/data/datasources/event_datasource.dart';
import '../features/events/data/datasources/i_event_datasource.dart';
import '../features/events/data/repositories/event_repository.dart';
import '../features/events/domain/repositories/i_event_repository.dart';
import '../features/events/domain/usecases/fetch_latest_events_usecase.dart';
import '../features/events/presentation/cubit/event_cubit.dart';
import '../features/favorites/data/datasources/favorite_datasource.dart';
import '../features/favorites/data/datasources/i_favorite_datasource.dart';
import '../features/favorites/data/repositories/favorite_repository.dart';
import '../features/favorites/domain/repositories/i_favorite_repository.dart';
import '../features/favorites/domain/usecases/add_favorite_usecase.dart';
import '../features/favorites/domain/usecases/get_all_favorites_usecase.dart';
import '../features/favorites/domain/usecases/is_my_favorite_usecase.dart';
import '../features/favorites/domain/usecases/remove_favorite_usecase.dart';
import '../features/favorites/presentation/cubit/favorite_cubit.dart';
import '../features/feeds/data/datasources/feed_datasource.dart';
import '../features/feeds/data/datasources/i_feed_datasource.dart';
import '../features/feeds/data/repositories/feed_repository.dart';
import '../features/feeds/domain/repositories/i_feed_repository.dart';
import '../features/feeds/domain/usecases/fetch_feeds_usecase.dart';
import '../features/feeds/presentation/cubit/feed_cubit.dart';
import '../features/home/presentation/cubit/home_campaign_cubit/home_campaign_cubit.dart';
import '../features/home/presentation/cubit/home_profile_data_cubit/home_profile_data_cubit.dart';
import '../features/ongs/data/datasources/i_ong_datasource.dart';
import '../features/ongs/data/datasources/ong_datasource.dart';
import '../features/ongs/data/repositories/ong_repository.dart';
import '../features/ongs/domain/respositories/i_ong_repository.dart';
import '../features/ongs/domain/usecases/create_ong_usecase.dart';
import '../features/ongs/domain/usecases/fetch_latest_ongs_usecase.dart';
import '../features/ongs/presentation/cubit/ong_action_cubit/ong_action_cubit.dart';
import '../features/ongs/presentation/cubit/ong_cubit.dart';
import '../features/profile/presentation/cubit/count_donation_cubit/count_donation_cubit.dart';
import '../features/profile/presentation/cubit/profile_cubit.dart';
import '../features/solidary/cubit/solidary_cubit.dart';
import '../features/users/data/repositories/user_repository.dart';
import '../features/users/domain/repositories/i_user_repository.dart';

GetIt instance = GetIt.instance;

Future init() async {
  final supabaseUrl = dotenv.env["SUPABASE_URL"];
  final supabaseKey = dotenv.env["SUPABASE_KEY"];

  await Supabase.initialize(url: supabaseUrl!, anonKey: supabaseKey!);
  _setUpExternal();
  _setUpCubits();
  _setUpUsecases();
  _setUpRepositories();
  _setUpDatasources();

  // Repositories
}

void _setUpExternal() async {
  instance.registerFactory(() => Supabase.instance.client);
  instance.registerFactory(() => FirebaseFirestore.instance);
  instance.registerFactory(() => GoogleSignIn.instance);
  instance.registerFactory(() => FirebaseAuth.instance);
  instance.registerFactory(() => FirebaseStorage.instance);

  instance.registerLazySingleton<SecureCacheHelper>(() => SecureCacheHelper());
  instance.registerLazySingleton<INetWorkInfo>(
    () => NetWorkInfo(netWorkInfo: InternetConnection.createInstance()),
  );
}

void _setUpCubits() {
  instance.registerFactory(
    () => AuthCubit(
      signInUseCase: instance(),
      signUpUseCase: instance(),
      signOutUseCase: instance(),
      signInWithOtpUseCase: instance(),
      secureCacheHelper: instance(),
    ),
  );
  instance.registerFactory(() => InitialCubit(isSignInUseCase: instance()));
  instance.registerFactory(
    () => HomeCampaignCubit(getLatestUrgentCampaignsUseCase: instance()),
  );
  instance.registerFactory(
    () => CampaignUrgentCubit(getUrgentCampaignsUseCase: instance()),
  );

  instance.registerFactory(
    () => EventCubit(fetchLatestEventsUsecase: instance()),
  );
  instance.registerFactory(() => OngCubit(fetchLatestOngsUsecase: instance()));
  instance.registerFactory(() => FeedCubit(fetchFeedsUseCase: instance()));
  instance.registerFactory(
    () => BlogCubit(
      fetchBlogUseCase: instance(),
      fetchLatestBlogUseCase: instance(),
    ),
  );

  instance.registerFactory(
    () => CampaignDetailCubit(getCampaignByIdUseCase: instance()),
  );

  instance.registerFactory(
    () => CampaignStoreFavoriteCubit(
      addFavoriteUseCase: instance(),
      removeFavoriteUseCase: instance(),
    ),
  );

  instance.registerFactory(
    () => FavoriteCubit(getAllFavoritesByUseCase: instance()),
  );
  instance.registerFactory(
    () => MyCampaignCubit(getAllMyCampaignsUseCase: instance()),
  );
  instance.registerFactory(
    () => MyCampaignDetailCubit(getMyCampaignByIdUseCase: instance()),
  );
  instance.registerFactory(
    () => UpdateActionCubit(
      createCampaignUpdateUseCase: instance(),
      updateCampaignUpdateUseCase: instance(),
      deleteCampaignUpdateUseCase: instance(),
    ),
  );
  instance.registerFactory(
    () => CampaignActionCubit(
      createCampaignUseCase: instance(),
      updateCampaignUseCase: instance(),
    ),
  );
  instance.registerFactory(
    () => CategoryCampaignCubit(getAllCampaignsUseCase: instance()),
  );
  instance.registerFactory(
    () => HomeProfileDataCubit(getAuthUserUseCase: instance()),
  );
  instance.registerFactory(() => ProfileCubit(getAuthUserUseCase: instance()));

  instance.registerFactory(
    () => CountDonationCubit(getCountMyDonationsUseCase: instance()),
  );

  instance.registerFactory(() => SolidaryCubit(getAuthUserUseCase: instance()));
  instance.registerFactory(() => AuthDataCubit(getAuthUserUseCase: instance()));
  instance.registerFactory(() => OngActionCubit(createOngUseCase: instance()));
}

void _setUpUsecases() {
  instance.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: instance()),
  );
  instance.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: instance()),
  );
  instance.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(repository: instance()),
  );
  instance.registerLazySingleton<IsSignInUseCase>(
    () => IsSignInUseCase(repository: instance()),
  );
  instance.registerLazySingleton<SignInWithOtpUseCase>(
    () => SignInWithOtpUseCase(repository: instance()),
  );

  instance.registerLazySingleton<CreateCampaignUseCase>(
    () => CreateCampaignUseCase(repository: instance()),
  );

  instance.registerLazySingleton<DeleteCampaignUseCase>(
    () => DeleteCampaignUseCase(repository: instance()),
  );
  instance.registerLazySingleton<GetAllCampaignsUseCase>(
    () => GetAllCampaignsUseCase(repository: instance()),
  );
  instance.registerLazySingleton<GetAllUrgentCampaignsUseCase>(
    () => GetAllUrgentCampaignsUseCase(repository: instance()),
  );

  instance.registerLazySingleton<UpdateCampaignUseCase>(
    () => UpdateCampaignUseCase(repository: instance()),
  );

  instance.registerLazySingleton<GetLatestUrgentCampaignsUseCase>(
    () => GetLatestUrgentCampaignsUseCase(repository: instance()),
  );
  instance.registerLazySingleton<FetchLatestEventsUsecase>(
    () => FetchLatestEventsUsecase(repository: instance()),
  );
  instance.registerLazySingleton<FetchLatestOngsUsecase>(
    () => FetchLatestOngsUsecase(repository: instance()),
  );
  instance.registerLazySingleton<FetchFeedsUseCase>(
    () => FetchFeedsUseCase(repository: instance()),
  );

  instance.registerLazySingleton<FetchBlogUseCase>(
    () => FetchBlogUseCase(repository: instance()),
  );
  instance.registerLazySingleton<FetchLatestBlogUseCase>(
    () => FetchLatestBlogUseCase(repository: instance()),
  );

  instance.registerLazySingleton<IsMyFavoriteUseCase>(
    () => IsMyFavoriteUseCase(repository: instance()),
  );
  instance.registerLazySingleton<GetAllFavoritesByUseCase>(
    () => GetAllFavoritesByUseCase(repository: instance()),
  );

  instance.registerLazySingleton<GetCampaignByIdUseCase>(
    () => GetCampaignByIdUseCase(repository: instance()),
  );
  instance.registerLazySingleton<GetAllMyCampaignsUseCase>(
    () => GetAllMyCampaignsUseCase(repository: instance()),
  );

  instance.registerLazySingleton<AddFavoriteUseCase>(
    () => AddFavoriteUseCase(repository: instance()),
  );
  instance.registerLazySingleton<RemoveFavoriteUseCase>(
    () => RemoveFavoriteUseCase(repository: instance()),
  );

  instance.registerLazySingleton<CreateCampaignUpdateUseCase>(
    () => CreateCampaignUpdateUseCase(repository: instance()),
  );
  instance.registerLazySingleton<UpdateCampaignUpdateUseCase>(
    () => UpdateCampaignUpdateUseCase(repository: instance()),
  );
  instance.registerLazySingleton<DeleteCampaignUpdateUseCase>(
    () => DeleteCampaignUpdateUseCase(repository: instance()),
  );

  instance.registerLazySingleton<GetAuthUserUseCase>(
    () => GetAuthUserUseCase(repository: instance()),
  );

  instance.registerLazySingleton<GetCountMyDonationsUseCase>(
    () => GetCountMyDonationsUseCase(repository: instance()),
  );

  instance.registerLazySingleton<CreateOngUseCase>(
    () => CreateOngUseCase(repository: instance()),
  );
}

void _setUpRepositories() {
  instance.registerLazySingleton<IAuthRepository>(
    () => AuthRespository(datasource: instance()),
  );
  instance.registerLazySingleton<ICampaignRepository>(
    () => CampaignRepository(datasource: instance(), networkInfo: instance()),
  );
  instance.registerLazySingleton<IEventRepository>(
    () => EventRepository(datasource: instance()),
  );
  instance.registerLazySingleton<IOngRepository>(
    () => OngRepository(datasource: instance()),
  );
  instance.registerLazySingleton<IFeedRepository>(
    () => FeedRepository(datasource: instance()),
  );
  instance.registerLazySingleton<IBlogRepository>(
    () => BlogRepository(datasource: instance()),
  );
  instance.registerLazySingleton<IFavoriteRepository>(
    () => FavoriteRepository(datasource: instance()),
  );
  instance.registerLazySingleton<IUpdateRepository>(
    () => UpdateRepository(datasource: instance(), netWorkInfo: instance()),
  );

  instance.registerLazySingleton<IUserRepository>(
    () => UserRespository(datasource: instance()),
  );

  instance.registerLazySingleton<IDonationRepository>(
    () => DonationRepository(datasource: instance()),
  );
}

void _setUpDatasources() {
  instance.registerLazySingleton<IAuthDataSource>(
    () => AuthDataSource(supabase: instance()),
  );
  instance.registerLazySingleton<ICampaignRemoteDataSource>(
    () => CampaignRemoteDataSource(supabase: instance()),
  );
  instance.registerLazySingleton<IEventDataSource>(
    () => EventDataSource(supabase: instance()),
  );
  instance.registerLazySingleton<IOngDataSource>(
    () => OngDataSource(supabase: instance()),
  );
  instance.registerLazySingleton<IFeedDataSource>(
    () => FeedDataSource(supabase: instance()),
  );

  instance.registerLazySingleton<IBlogDataSource>(
    () => BlogDataSource(supabase: instance()),
  );

  instance.registerLazySingleton<IFavoriteDataSource>(
    () => FavoriteDataSource(supabase: instance()),
  );

  instance.registerLazySingleton<IUpdateDataSource>(
    () => UpdateDataSource(supabase: instance()),
  );

  instance.registerLazySingleton<IDonationDataSource>(
    () => DonationDataSource(supabase: instance()),
  );
}
