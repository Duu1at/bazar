import 'dart:developer';
import 'dart:ui';
import 'package:analytics_repository/analytics_repository.dart';
import 'package:app/app_observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_client/supabase_client.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';
import 'app/view/app_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SupabaseClientProvider.initialize(
    supabaseUrl: 'https://esvpvhyeaziwhskxjcju.supabase.co',
    supabaseAnonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVzdnB2aHllYXppd2hza3hqY2p1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIzOTc4MjMsImV4cCI6MjA1Nzk3MzgyM30.7tosOw0noUFyBZNjIWO-DuSUP03cTTIDCts6xyZtugY',
  );
  Bloc.observer = const AppBlocObserver(onLog: log);
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('‼️ FLUTTER ERROR: ${details.exception}');
    if (details.stack != null) {
      debugPrint('🔄 STACKTRACE: ${details.stack}');
    }
    FlutterError.dumpErrorToConsole(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('‼️ GLOBAL ERROR: $error');

    debugPrint('🔄 STACKTRACE: $stack');

    return true;
  };

  final sharedPreferences = await SharedPreferences.getInstance();
  final persistentStorage = PersistentStorage(sharedPreferences: sharedPreferences);
  final analyticsRepository = AnalyticsRepository(FirebaseAnalytics.instance);
  final tokenStorage = InMemoryTokenStorage();
  final userRepository = UserRepository(
    persistentStorage: persistentStorage,
    client: SupabaseClientProvider.client,
    tokenStorage: tokenStorage,
  );

  runApp(
    App(
      userRepository: userRepository,
      user: await userRepository.user.first,
      analyticsRepository: analyticsRepository,
      persistentStorage: persistentStorage,
    ),
  );
}
