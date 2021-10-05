import 'package:flutter/material.dart';
import 'package:racha_app/pages/auth_or_home_page.dart';
import 'package:racha_app/pages/home.page.dart';
import 'package:racha_app/pages/login.page.dart';
import 'package:racha_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'models/auth.dart';

void main() {
  runApp(RachaApp());
}

class RachaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Racha App',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          backgroundColor: Colors.lightGreen,
          accentColor: Colors.green,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.greenAccent,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => AuthOrHomePage(),
          AppRoutes.LOGIN_PAGE: (ctx) => LoginPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
