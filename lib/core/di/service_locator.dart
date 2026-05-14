import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../core/networking/dio_client.dart';
import '../../core/networking/dio_consumer.dart';
import '../../core/utils/token_storage.dart';
import '../../features/auth/data/repo/auth_remote_data_source.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/home/data/repo/category_repo.dart';
import '../../features/home/data/repo/category_repo_impl.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/presentation/cubit/home/home_cubit.dart';
import '../../features/map/presentation/cubit/map_cubit.dart';

// Profile
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_user_profile_usecase.dart';
import '../../features/profile/domain/usecases/get_user_reports_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

// Chat
import '../../features/chat/data/datasources/chat_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/get_chat_sessions_usecase.dart';
import '../../features/chat/domain/usecases/get_chat_messages_usecase.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/domain/usecases/mark_message_as_read_usecase.dart';
import '../../features/chat/presentation/bloc/chat_bloc.dart';

// Notification
import '../../features/notification/data/datasources/notification_remote_data_source.dart';
import '../../features/notification/data/repositories/notification_repository_impl.dart';
import '../../features/notification/domain/repositories/notification_repository.dart';
import '../../features/notification/domain/usecases/get_notifications_usecase.dart';
import '../../features/notification/domain/usecases/get_unread_count_usecase.dart';
import '../../features/notification/domain/usecases/mark_all_as_read_usecase.dart';
import '../../features/notification/domain/usecases/mark_as_read_usecase.dart';
import '../../features/notification/presentation/bloc/notification_bloc.dart';

// Settings
import '../../features/settings/data/datasources/settings_remote_data_source.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/update_profile_usecase.dart';
import '../../features/settings/domain/usecases/change_password_usecase.dart';
import '../../features/settings/domain/usecases/delete_account_usecase.dart';
import '../../features/settings/domain/usecases/logout_usecase.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../features/settings/presentation/view/edit_profile/bloc/edit_profile_bloc.dart';
import '../../features/settings/presentation/view/change_password/bloc/change_password_bloc.dart';

// Report
import '../../features/report/data/datasources/report_remote_data_source.dart';
import '../../features/report/data/repositories/report_repository_impl.dart';
import '../../features/report/domain/repositories/report_repository.dart';
import '../../features/report/domain/usecases/get_categories_usecase.dart';
import '../../features/report/domain/usecases/create_report_usecase.dart';
import '../../features/report/presentation/bloc/report_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  //  Core 
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());
  sl.registerLazySingleton<Dio>(() => DioClient.create(sl<TokenStorage>()));
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer(sl<Dio>()));

  //  Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<DioConsumer>()),
  );
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepo(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      tokenStorage: sl<TokenStorage>(),
    ),
  );

  //  Categories 
  sl.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImpl(sl<DioConsumer>()),
  );

  // Home  
  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(sl<DioConsumer>()),
  );
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(homeRepo: sl<HomeRepo>(), categoryRepo: sl<CategoryRepo>()),
  );

  // Map
  sl.registerFactory<MapCubit>(
    () => MapCubit(homeRepo: sl<HomeRepo>()),
  );

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiConsumer: sl<DioConsumer>()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl<ProfileRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(sl<ProfileRepository>()),
  );
  sl.registerLazySingleton<GetUserReportsUseCase>(
    () => GetUserReportsUseCase(sl<ProfileRepository>()),
  );
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getUserProfileUseCase: sl<GetUserProfileUseCase>(),
      getUserReportsUseCase: sl<GetUserReportsUseCase>(),
    ),
  );

  // Chat
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(apiConsumer: sl<DioConsumer>()),
  );
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(sl<ChatRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetChatSessionsUseCase>(
    () => GetChatSessionsUseCase(sl<ChatRepository>()),
  );
  sl.registerLazySingleton<GetChatMessagesUseCase>(
    () => GetChatMessagesUseCase(sl<ChatRepository>()),
  );
  sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(sl<ChatRepository>()),
  );
  sl.registerLazySingleton<MarkMessageAsReadUseCase>(
    () => MarkMessageAsReadUseCase(sl<ChatRepository>()),
  );
  sl.registerFactory<ChatBloc>(
    () => ChatBloc(
      getChatSessionsUseCase: sl<GetChatSessionsUseCase>(),
      getChatMessagesUseCase: sl<GetChatMessagesUseCase>(),
      sendMessageUseCase: sl<SendMessageUseCase>(),
      markMessageAsReadUseCase: sl<MarkMessageAsReadUseCase>(),
      getUserProfileUseCase: sl<GetUserProfileUseCase>(),
    ),
  );

  // Notification
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(apiConsumer: sl<DioConsumer>()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(sl<NotificationRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<GetUnreadCountUseCase>(
    () => GetUnreadCountUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<MarkAllAsReadUseCase>(
    () => MarkAllAsReadUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<MarkAsReadUseCase>(
    () => MarkAsReadUseCase(sl<NotificationRepository>()),
  );
  sl.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      getNotificationsUseCase: sl<GetNotificationsUseCase>(),
      getUnreadCountUseCase: sl<GetUnreadCountUseCase>(),
      markAllAsReadUseCase: sl<MarkAllAsReadUseCase>(),
      markAsReadUseCase: sl<MarkAsReadUseCase>(),
    ),
  );

  // Settings
  sl.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSourceImpl(
      apiConsumer: sl<DioConsumer>(),
      tokenStorage: sl<TokenStorage>(),
    ),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl<SettingsRemoteDataSource>()),
  );
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl<SettingsRepository>()),
  );
  sl.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(sl<SettingsRepository>()),
  );
  sl.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(sl<SettingsRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<SettingsRepository>()),
  );
  sl.registerFactory<SettingsBloc>(
    () => SettingsBloc(
      updateProfileUseCase: sl<UpdateProfileUseCase>(),
      changePasswordUseCase: sl<ChangePasswordUseCase>(),
      deleteAccountUseCase: sl<DeleteAccountUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
    ),
  );

  sl.registerFactory<EditProfileBloc>(
    () => EditProfileBloc(
      getUserProfileUseCase: sl<GetUserProfileUseCase>(),
      updateProfileUseCase: sl<UpdateProfileUseCase>(),
    ),
  );

  sl.registerFactory<ChangePasswordBloc>(
    () => ChangePasswordBloc(
      changePasswordUseCase: sl<ChangePasswordUseCase>(),
    ),
  );

  // Report
  sl.registerLazySingleton<ReportRemoteDataSource>(
    () => ReportRemoteDataSourceImpl(apiConsumer: sl<DioConsumer>()),
  );
  sl.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(sl<ReportRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl<ReportRepository>()),
  );
  sl.registerLazySingleton<CreateReportUseCase>(
    () => CreateReportUseCase(sl<ReportRepository>()),
  );
  sl.registerFactory<ReportBloc>(
    () => ReportBloc(
      getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      createReportUseCase: sl<CreateReportUseCase>(),
    ),
  );
}
