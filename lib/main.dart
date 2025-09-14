import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sinn_tech_assessment/data/datasources/remote/user_remote_data_source.dart';
import 'package:sinn_tech_assessment/data/repositories/user_repository_impl.dart';
import 'package:sinn_tech_assessment/domain/repositories/user_repository.dart';
import 'package:sinn_tech_assessment/domain/usecases/get_users_usecase.dart';
import 'package:sinn_tech_assessment/presentation/bloc/user_bloc.dart';
import 'package:sinn_tech_assessment/presentation/pages/user_list_page.dart';
import 'package:sinn_tech_assessment/core/theme/app_theme.dart';
import 'package:sinn_tech_assessment/core/api/api_client.dart';
import 'package:sinn_tech_assessment/core/constants/app_strings.dart';
import 'package:sinn_tech_assessment/domain/usecases/search_users_usecase.dart';
import 'package:sinn_tech_assessment/presentation/bloc/theme_bloc.dart';
// import 'package:sinn_tech_assessment/presentation/bloc/theme_event.dart';
import 'package:sinn_tech_assessment/presentation/bloc/theme_state.dart';

// Service locator instance
final getIt = GetIt.instance;

void main() {
  // dependency injection
  setupLocator();
  runApp(const MyApp());
}

// Function to register all dependencies
void setupLocator() {
  // Core Layer
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Data Layer
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(getIt<ApiClient>()),
  );

  // Domain Layer
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<SearchUsersUseCase>(
    () => SearchUsersUseCase(getIt<UserRepository>()),
  );

  // Presentation Layer
  getIt.registerFactory<UserBloc>(
    () => UserBloc(
      getUsersUseCase: getIt<GetUsersUseCase>(),
      searchUsersUseCase: getIt<SearchUsersUseCase>(),
    ),
  );
  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The ThemeBloc manages the theme state for the entire app
      create: (context) => getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: AppStrings.appName,
            // Apply the light and dark themes
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            // Setting the theme mode based on the BLoC state dynamically
            themeMode: themeState.themeMode,
            home: BlocProvider(
              create: (context) => getIt<UserBloc>(),
              child: const UserListPage(),
            ),
          );
        },
      ),
    );
  }
}
