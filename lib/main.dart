import 'package:agent/src/config/styles.dart';
import 'package:agent/src/features/authentication/controller/auth.controller.dart';
import 'package:agent/src/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.colorScheme.surface,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: theme.colorScheme.brightness,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => GlobalLoaderOverlay(
        overlayColor: Colors.white.withOpacity(0.8),
        closeOnBackButton: true,
        useBackButtonInterceptor: true,
        child: MaterialApp.router(
          title: 'App',
          theme: theme,
          debugShowCheckedModeBanner: false,
          routeInformationParser: routes.routeInformationParser,
          routerDelegate: routes.routerDelegate,
          routeInformationProvider: routes.routeInformationProvider,
        ),
      );
}
