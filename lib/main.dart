import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:novalinguo/screens/chat/chat_screen.dart';
import 'package:novalinguo/screens/splashscreen_wrapper.dart';
import 'package:novalinguo/services/authentication.dart';
import 'package:provider/provider.dart';
import 'models/chat_params.dart';
import 'models/user.dart';
//import 'package:novalinguo/screens/authenticate/authenticate_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        initialRoute: '/',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        theme: ThemeData(
          //primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromRGBO(41, 42, 75, 1),
          backgroundColor: Color.fromRGBO(41, 42, 75, 1),
          bottomAppBarColor: Color.fromRGBO(25, 26, 46, 1),
          primaryColor: Color.fromRGBO(41, 42, 75, 1),
          accentColor: Color.fromRGBO(254, 209, 72, 1),
        ),
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreenWrapper());
      case '/chat':
        var arguments = settings.arguments;
        if (arguments != null) {
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ChatScreen(chatParams: arguments as ChatParams),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                animation =
                    CurvedAnimation(curve: Curves.ease, parent: animation);
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              });
        } else {
          return pageNotFound();
        }
      default:
        return pageNotFound();
    }
  }

  static MaterialPageRoute pageNotFound() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(title: Text("Error"), centerTitle: true),
            body: Center(
              child: Text("Page not found"),
            )));
  }
}
