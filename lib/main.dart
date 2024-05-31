import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/ibilling/presentation/screens/ibilling_app.dart';
import 'firebase_options.dart';
import 'generated/codegen_loader.g.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale("en"),
        Locale("ru"),
        Locale("uz"),
      ],
      fallbackLocale: const Locale('en'),
      path: 'assets/translation',
      startLocale: const Locale('uz'),
      assetLoader: const CodegenLoader(),
      child: const IBillingApp(title: 'iBilling App')));
}
