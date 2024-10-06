import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda_xh/constants/colors_constants.dart';
import 'package:lingopanda_xh/firebase_options.dart';
import 'package:lingopanda_xh/modules/home/home_view.dart';
import 'package:lingopanda_xh/modules/login/login_view.dart';
import 'package:lingopanda_xh/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServiceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lingo Panda',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
          appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryBlue),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.bgWhite,
        ),
        home: FirebaseAuth.instance.currentUser != null
            ? const HomeView()
            : LoginView(),
      ),
    );
  }
}
