import 'package:app/app/cubit/app_cubit.dart';
import 'package:app/chat/view/chat_view.dart';
import 'package:app/home/view/home_view.dart';
import 'package:app/submit/view/submit_view.dart';
import 'package:auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mb_storage/mb_storage.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.storage,
    required this.firebaseAuth,
  });

  final MbStorage storage;
  final FirebaseAuth firebaseAuth;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      RepositoryProvider<MbStorage>(create: (context) => storage),
      RepositoryProvider<AuthService>(
        create: (context) => AuthService(
          storage,
          firebaseAuth,
        ),
      ),
      BlocProvider(
        create: (context) => AppThemeCubit(
          context.read<MbStorage>(),
        ),
      ),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.read<AppThemeCubit>().state.themeData,
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
        title: const Text('Flutter Auth App'),
      ),
      body: _screens[_selectedIndex],
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
