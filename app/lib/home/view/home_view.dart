import 'package:app/app/cubit/app_cubit.dart';
import 'package:app/login/view/login_modal.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Switch.adaptive(
            value: isDark,
            onChanged: (v) {
              isDark = v;
              context.read<AppThemeCubit>().changeMode(isDark: isDark);
              setState(() {});
            }),
        SizedBox(height: AppSpacing.lg),
        AppButton.blueDress(
          child: const Text('Logim model'),
          onPressed: () {
            showAppModal<void>(
              context: context,
              builder: (context) => const LoginModal(),
              routeSettings: const RouteSettings(name: LoginModal.name),
            );
          },
        ),
      ],
    );
  }
}
