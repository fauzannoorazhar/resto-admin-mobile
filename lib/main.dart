import 'package:flutter/material.dart';
import 'package:resto_admin/ui/views/home_page.dart';
import 'package:resto_admin/ui/views/splashscreen_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences sp = await SharedPreferences.getInstance();
    String login = sp.getString('login');

    return runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Resto Admin',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.indigo,
                fontFamily: 'PTSans'
            ),
            home: (login == 'true') ? HomePage() : SplashscreenPage(),
            localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
                const Locale('en', 'US'),
                const Locale('id', 'ID'),
            ],
    ));
}