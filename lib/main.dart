import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:novalinguo/screens/authenticate/authenticate_screen.dart';
import 'package:novalinguo/screens/splashscreen_wrapper.dart';
import 'package:novalinguo/services/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // if (!kIsWeb) {
  //     await FirebaseCrashlytics.instance
  //         .setCrashlyticsCollectionEnabled(kDebugMode ? false : true);
  //     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenWrapper(),
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
      ),
    );
  }
}
