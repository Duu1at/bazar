import 'package:app/app/bloc/app_bloc.dart';
import 'package:app/login/bloc/login_bloc.dart';
import 'package:app/login/view/login_modal.dart';
import 'package:app/login/view/login_with_email_page.dart';
import 'package:app_ui/app_ui.dart' show AppButton, AppSpacing, Assets;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.status.isLoggedIn) {
          // Pop all routes on top of [LoginModal], then pop the modal itself.
          Navigator.of(context).popUntil((route) => route.settings.name == LoginModal.name);
          Navigator.of(context).pop();
        }
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Autentication failed')),
              );
          }
        },
        child: const _LoginContent(),
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight * .75),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.xxlg,
            ),
            children: [
              const _LoginTitleAndCloseButton(),
              const SizedBox(height: AppSpacing.sm),
              const _LoginSubtitle(),
              const SizedBox(height: AppSpacing.lg),
              _GoogleLoginButton(),
              if (theme.platform == TargetPlatform.iOS) ...[
                const SizedBox(height: AppSpacing.lg),
                _AppleLoginButton(),
              ],
              const SizedBox(height: AppSpacing.lg),
              _ContinueWithEmailLoginButton(),
            ],
          ),
        );
      },
    );
  }
}

class _LoginTitleAndCloseButton extends StatelessWidget {
  const _LoginTitleAndCloseButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.sm),
          child: Text(
            'Login',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        IconButton(
          key: const Key('loginForm_closeModal_iconButton'),
          constraints: const BoxConstraints.tightFor(width: 24, height: 36),
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          icon:  Icon(Icons.close,color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      ],
    );
  }
}

class _LoginSubtitle extends StatelessWidget {
  const _LoginSubtitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Login to your account',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class _AppleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.black(
      key: const Key('loginForm_appleLogin_appButton'),
      onPressed: () => context.read<LoginBloc>().add(LoginAppleSubmitted()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.apple.svg(),
          const SizedBox(width: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Assets.images.continueWithApple.svg(),
          ),
        ],
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.outlinedWhite(
      key: const Key('loginForm_googleLogin_appButton'),
      onPressed: () => context.read<LoginBloc>().add(LoginGoogleSubmitted()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.google.svg(),
          const SizedBox(width: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxs),
            child: Assets.images.continueWithGoogle.svg(),
          ),
        ],
      ),
    );
  }
}

class _ContinueWithEmailLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppButton.outlinedTransparentDarkAqua(
      key: const Key('loginForm_emailLogin_appButton'),
      onPressed: () => Navigator.of(context).push<void>(
        LoginWithEmailPage.route(),
      ),
      textStyle: Theme.of(context).textTheme.titleMedium,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.emailOutline.svg(),
          const SizedBox(width: AppSpacing.lg),
          const Text('Continue with email'),
        ],
      ),
    );
  }
}
