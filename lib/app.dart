import 'package:flutter/material.dart';
import 'package:plannera/core/routes/app_router.dart';
import 'package:plannera/core/security/state/auth_cubit.dart';

class PlannerApp extends StatelessWidget {
  final AuthCubit authCubit;
  const PlannerApp({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: createRouter(authCubit),
      debugShowCheckedModeBanner: false,
    );
  }
}
