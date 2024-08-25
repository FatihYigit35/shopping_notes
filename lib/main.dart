import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_notes/l10n/i18n.dart';
import 'package:shopping_notes/widget/shopping_notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final seedColor = const Color.fromARGB(255, 139, 195, 74);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppTranslations.init(context);

    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
          surface: Colors.lightBlueAccent[100],
        ),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.dark,
            surface: Colors.blueGrey[850]),
        scaffoldBackgroundColor: Colors.grey[850],
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ShoppingNotes(),
    );
  }
}
