import 'package:app_ui/app_ui.dart' show AppButton, AppColors, AppSpacing, Assets;
import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';

class MagicLinkPromptView extends StatelessWidget {
  const MagicLinkPromptView({required this.email, super.key});

  final String email;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xlg,
              AppSpacing.xlg,
              AppSpacing.xlg,
              AppSpacing.xxlg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MagicLinkPromptHeader(),
                const SizedBox(height: AppSpacing.xxxlg),
                Assets.icons.envelopeOpen.svg(),
                const SizedBox(height: AppSpacing.xxxlg),
                MagicLinkPromptSubtitle(email: email),
                const Spacer(),
                MagicLinkPromptOpenEmailButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

@visibleForTesting
class MagicLinkPromptHeader extends StatelessWidget {
  const MagicLinkPromptHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Magic link prompt',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

@visibleForTesting
class MagicLinkPromptSubtitle extends StatelessWidget {
  const MagicLinkPromptSubtitle({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          'Magic link prompt subtitle',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge,
        ),
        Text(
          email,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.apply(
            color: AppColors.darkAqua,
          ),
        ),
        const SizedBox(height: AppSpacing.xxlg),
        Text(
          'Magic link prompt subtitle 2',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

@visibleForTesting
class MagicLinkPromptOpenEmailButton extends StatelessWidget {
  MagicLinkPromptOpenEmailButton({
    EmailLauncher? emailLauncher,
    super.key,
  }) : _emailLauncher = emailLauncher ?? EmailLauncher();

  final EmailLauncher _emailLauncher;

  @override
  Widget build(BuildContext context) {
    return AppButton.darkAqua(
      key: const Key('magicLinkPrompt_openMailButton_appButton'),
      onPressed: _emailLauncher.launchEmailApp,
      child: const Text('openMailAppButtonText'),
    );
  }
}
