import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_app/app_localization.dart';
import 'package:local_app/language.dart';
import 'package:local_app/locale_notifier.dart';
import 'package:local_app/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleNotifier(),
      builder: (context, child) {
        final appLocaleProvider = Provider.of<LocaleNotifier>(context);
        return MaterialApp(
          locale: appLocaleProvider.locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalization.delegate
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('es', 'AR'),
            Locale('hi', 'IN'),
            Locale('zh', 'CN'),
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _changeLanguage(Language language, context) async {
    Locale _selectedLocale =
        await AppSharedPreferences().setLocale(language.languageCode);
    final appLocaleProvider =
        Provider.of<LocaleNotifier>(context, listen: false);

    appLocaleProvider.setLocale(_selectedLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalization.of(context)
            .getTranslatedValue("home_appBar_title")!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            Text(
              AppLocalization.of(context).getTranslatedValue("simple_text")!,
            ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            Wrap(
                children: Language.languageList()
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            // change app locale
                            print(AppLocalization.of(context)
                                .getTranslatedValue("simple_text")!);
                            _changeLanguage(e, context);
                          },
                          child: Text("${e.name} ${e.flag}"),
                        ),
                      ),
                    )
                    .toList())
          ],
        ),
      ),
    );
  }
}
