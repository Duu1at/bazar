import 'dart:developer';
import 'package:analytics_repository/analytics_repository.dart';
import 'package:app/app_observer.dart';
import 'package:deep_link_client/deep_link_client.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:firebase_deep_link_client/firebase_deep_link_client.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_client/package_info_client.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';
import 'app/view/app_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = const AppBlocObserver(onLog: log);

  // final storage = await MbStorage.getInstance();
  // final firebaseAuth = FirebaseAuth.instance;

  final tokenStorage = InMemoryTokenStorage();

  final packageInfoClient = PackageInfoClient(
    appName: 'Flutter News Example [DEV]',
    packageName: 'com.flutter.news.example.dev',
    packageVersion: '1.0.0',
  );

  // ignore: deprecated_member_use
  final firebaseDynamicLinks = FirebaseDynamicLinks.instance;

  final deepLinkService = DeepLinkService(
    deepLinkClient: FirebaseDeepLinkClient(
      firebaseDynamicLinks: firebaseDynamicLinks,
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  final persistentStorage = PersistentStorage(
    sharedPreferences: sharedPreferences,
  );

  final userStorage = UserStorage(storage: persistentStorage);
  final authenticationClient = FirebaseAuthenticationClient(
    tokenStorage: tokenStorage,
  );

  final userRepository = UserRepository(
    authenticationClient: authenticationClient,
    packageInfoClient: packageInfoClient,
    deepLinkService: deepLinkService,
    storage: userStorage,
  );
  final analyticsRepository = AnalyticsRepository(FirebaseAnalytics.instance);

  runApp(
    App(
      userRepository: userRepository,
      user: await userRepository.user.first,
      analyticsRepository: analyticsRepository,
      persistentStorage: persistentStorage,
    ),
  );
}
