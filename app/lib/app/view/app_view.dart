import 'package:app/chat/view/chat_view.dart';
import 'package:app/home/view/home_view.dart';
import 'package:app/submit/view/submit_view.dart';
import 'package:flutter/material.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
