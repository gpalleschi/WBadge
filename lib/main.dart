import 'package:badge/l10n/l10n.dart';
import 'package:badge/pages/pages.dart';
import 'package:badge/providers/providers.dart';
import 'package:badge/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  // // Ci assicuriamo che sia inizializzato con il contesto
  //WidgetsFlutterBinding.ensureInitialized();

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
      },
      theme: paramProvider.currentThemeData,
      supportedLocales: L10n.all,
      locale: Locale(paramProvider.language),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
    );
  }
}