import 'package:alquran_indonesia/common/constants.dart';
import 'package:alquran_indonesia/common/utils.dart';
import 'package:alquran_indonesia/presentation/pages/detail_surah_page.dart';
import 'package:alquran_indonesia/presentation/pages/surah_interpretation_page.dart';
import 'package:alquran_indonesia/presentation/provider/surah_detail_notifier.dart';
import 'package:alquran_indonesia/presentation/provider/surah_interpretation_notifier.dart';
import 'package:alquran_indonesia/presentation/provider/surah_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/pages/home_page.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<SurahListNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<SurahDetailNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<SurahInterpretationNotifier>()),
      ],
      child: MaterialApp(
          title: 'Al-quran Indonesia',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case DetailSurahPage.ROUTE_NAME:
              final arguments = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(builder: (_) => DetailSurahPage(
                surahNumber: arguments['surahNumber'],
                surahName: arguments['surahName'],
              ));
            case SurahInterpretationPage.ROUTE_NAME:
              final arguments = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(builder: (_) => SurahInterpretationPage(
                surahNumber: arguments['surahNumber'],
                surahName: arguments['surahName'],
              ));
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      )
    );
  }
}