import 'package:analytics_repository/analytics_repository.dart';
import 'package:app/app/bloc/app_bloc.dart';
import 'package:app/app/cubit/app_cubit.dart';
import 'package:app/chat/view/chat_view.dart';
import 'package:app/home/view/home_view.dart';
import 'package:app/l10n/l10.dart';
import 'package:app/login/bloc/login_with_email_link_bloc.dart';
import 'package:app/submit/view/submit_view.dart';
import 'package:app/theme/themes/app_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mb_storage/mb_storage.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    required AnalyticsRepository analyticsRepository,
    required User user,
    required MbStorage mbStorage,
    super.key,
  })  : _userRepository = userRepository,
        _analyticsRepository = analyticsRepository,
        _user = user,
        _mbStorage = mbStorage;

  final UserRepository _userRepository;
  final AnalyticsRepository _analyticsRepository;
  final User _user;
  final MbStorage _mbStorage;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _analyticsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              userRepository: _userRepository,
              user: _user,
            )..add(const AppOpened()),
          ),
          BlocProvider(
            create: (_) => LoginWithEmailLinkBloc(
              userRepository: _userRepository,
            ),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => AppThemeCubit(
              _mbStorage,
            ),
          )
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
      themeMode: ThemeMode.light,
      theme: context.read<AppThemeCubit>().state.themeData,
      darkTheme: const AppDarkTheme().themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AppViewBody(),
    );
  }
}

class AppViewBody extends StatefulWidget {
  const AppViewBody({super.key});

  @override
  State<AppViewBody> createState() => _AppViewBodyState();
}

class _AppViewBodyState extends State<AppViewBody> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const SubmitView(),
    const ChatView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter  App'),
      ),
      body: _screens[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Подать',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Чат',
          ),
        ],
      ),
    );
  }
}
