import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'controller/googleAuth.dart';
import 'screens/splash_screen.dart';
import 'services/firebase_options.dart';

//global object for accessing device screen size
late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // for setting orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
          ],
          child: MaterialApp(
            title: 'Gasto Notes',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
              useMaterial3: true,
            ),
            builder: EasyLoading.init(),
            home: const SplashScreen(),
          ));
}

// init firebase function
_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
