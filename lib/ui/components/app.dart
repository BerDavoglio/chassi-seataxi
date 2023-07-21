import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../infra/infra.dart';
import '../ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OperationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DamageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(217, 217, 217, 1),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(22, 58, 89, 1),
          ),
        ),
        routes: {
          AppRoutes.HOME: (_) => const HomePage(),
          AppRoutes.LOGIN: (_) => const LoginPage(),
          AppRoutes.FORMCARLIST: (_) => const CarListPage(),
          AppRoutes.FORMCAR: (_) => const CarFormPage(),
          AppRoutes.FORMDAMAGE: (_) => const BreakDownFormPage(),
        },
      ),
    );
  }
}
