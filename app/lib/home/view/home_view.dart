import 'package:app/login/view/login_modal.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppButton.blueDress(
        child: const Text('Logim model'),
        onPressed: () {
          showAppModal<void>(
            context: context,
            builder: (context) => const LoginModal(),
            routeSettings: const RouteSettings(name: LoginModal.name),
          );
        },
      ),
    );
  }
}
