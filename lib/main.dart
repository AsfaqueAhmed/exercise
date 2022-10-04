import 'dart:async';
import 'dart:ui';

import 'package:exercise/app.dart';
import 'package:exercise/pages/error_page/error_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const App());
    },
    (error, stack) {
      if (kDebugMode) {
        print("Debug");
        print(error);
        print(stack);
      }
    },
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  ErrorWidget.builder = (errorDetails) {
    return const ErrorPage();
  };
}


