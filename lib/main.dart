import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plannera/app.dart';
import 'package:plannera/core/di/setup_locator.dart';
import 'package:plannera/core/security/state/auth_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => GetIt.I<AuthCubit>()),
      ],
      child: PlannerApp(),
    ),
  );
}
