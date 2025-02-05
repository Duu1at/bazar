import 'dart:developer';
import 'package:app/app_observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mb_storage/mb_storage.dart';
import 'app/view/app_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = const AppBlocObserver(onLog: log);

  final storage = await MbStorage.getInstance();
  final firebaseAuth = FirebaseAuth.instance;

  runApp(
    MyApp(
      firebaseAuth: firebaseAuth,
      storage: storage,
    ),
  );
}
