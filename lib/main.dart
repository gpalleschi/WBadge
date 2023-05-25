import 'package:badge/l10n/l10n.dart';
import 'package:badge/pages/pages.dart';
import 'package:badge/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  // // Ci assicuriamo che sia inizializzato con il contesto
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => DayProvider() ),
        ChangeNotifierProvider(create: ( _ ) => ParamProvider() ),
      ],
      child: const _BodyApp(),
    );
  }
}

class _BodyApp extends StatelessWidget {
  const _BodyApp();


  @override
  Widget build(BuildContext context) {

    final paramProvider = Provider.of<ParamProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'W-BADGE',
      initialRoute: 'home',
      routes: {
        'home'     : ( _ ) => const HomePage(),
        'resume'   : ( _ ) => const ResumePage(),
        'settings' : ( _ ) => const SettingsPage(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo,
          scrolledUnderElevation: 2
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 2 
        ),
      ),
      supportedLocales: L10n.all,
      locale: Locale(paramProvider.language),
      //locale: Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
    );
  }
}