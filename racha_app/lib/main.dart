import 'package:flutter/material.dart';
import 'package:racha_app/models/event_list.dart';
import 'package:racha_app/pages/auth_or_home_page.dart';
import 'package:racha_app/pages/event_form_page.dart';
import 'package:racha_app/pages/events_page.dart';
import 'package:racha_app/pages/home_page.dart';
import 'package:racha_app/pages/login_page.dart';
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
        ChangeNotifierProvider(
          create: (_) => LoginPage(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePage(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventList(),
        ),
      ],
      child: MaterialApp(
        title: 'Racha App',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          backgroundColor: Colors.lightGreen,
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
          AppRoutes.HOME: (ctx) => HomePage(),
          AppRoutes.EVENTS: (ctx) => EventsPage(),
          AppRoutes.EVENT_FORM: (ctx) => EventFormPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
