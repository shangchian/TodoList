import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todolist/routes/app_router.dart';
import 'package:todolist/services/notification_service.dart';

import 'flutter_intl/generated/l10n.dart';
import 'locator.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<AppRouter>(AppRouter());
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = GetIt.instance<AppRouter>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // 多國語言支援
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,

      // 防止字體大小受系統影響
      builder: (context, child) {
        return MediaQuery.withNoTextScaling(child: child!);
      },

      routerConfig: _appRouter.config(),
    );
  }
}
