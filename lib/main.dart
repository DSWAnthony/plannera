import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plannera/app.dart';
import 'package:plannera/core/di/setup_locator.dart';
import 'package:plannera/core/security/state/auth_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  final authCubit = GetIt.I<AuthCubit>();
  await authCubit.checkAuthOnStart();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(
          value: authCubit,
        ),
      ],
      child: PlannerApp(authCubit: authCubit),
    ),
  );
}
