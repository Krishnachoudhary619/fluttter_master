import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';

import 'app.dart';
import 'core/constants/flavor.dart';
import 'data/source/local/shar_pref.dart';
import 'firebase/firebase_options_dev.dart' as firebase_dev;
import 'firebase/firebase_options_prod.dart' as firebase_prod;
import 'firebase/firebase_options_stag.dart' as firebase_stag;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: platform);

  final pref = await SecureSharedPref.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        secureSharedPrefProvider.overrideWithValue(pref),
      ],
      child: const App(),
    ),
  );
}

FirebaseOptions get platform {
  final flavor = Flavor.values.firstWhere(
    (element) => element.name == const String.fromEnvironment('FLAVOR'),
  );
  return switch (flavor) {
    Flavor.development => firebase_dev.DefaultFirebaseOptions.currentPlatform,
    Flavor.staging => firebase_stag.DefaultFirebaseOptions.currentPlatform,
    Flavor.production => firebase_prod.DefaultFirebaseOptions.currentPlatform,
  };
}
