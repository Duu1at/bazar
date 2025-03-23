import 'package:analytics_repository/analytics_repository.dart';
import 'package:app/app/bloc/app_bloc.dart';
import 'package:app/app/cubit/app_cubit.dart';
import 'package:app/auth/bloc/auth_bloc.dart';
import 'package:app/l10n/l10.dart';
import 'package:app/main/view/main.dart';
import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    required AnalyticsRepository analyticsRepository,
    required UserModel user,
    required PersistentStorage persistentStorage,
    super.key,
  }) : _userRepository = userRepository,
       _analyticsRepository = analyticsRepository,
       _user = user,
       _persistentStorage = persistentStorage;

  final UserRepository _userRepository;
  final AnalyticsRepository _analyticsRepository;
  final UserModel _user;
  final PersistentStorage _persistentStorage;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _analyticsRepository),
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepositoryImpl(AppLocalDataSourceImpl(storage: _persistentStorage)),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppThemeCubit(context.read<AppRepository>())),
          BlocProvider(create: (_) => AppBloc(userRepository: _userRepository, user: _user)..add(const AppOpened())),
          BlocProvider(create: (_) => AuthBloc(authRepository: _userRepository)),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bazar',
      themeMode: ThemeMode.light,
      theme: context.watch<AppThemeCubit>().state.themeData,
      darkTheme: const AppDarkTheme().themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainView(),
    );
  }
}
