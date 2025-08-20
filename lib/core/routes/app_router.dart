import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:plannera/core/routes/app_router_names.dart';
import 'package:plannera/core/routes/go_router_refresh.dart';
import 'package:plannera/core/security/state/auth_cubit.dart';
import 'package:plannera/modules/auth/presentation/screens/login_screen.dart';
import 'package:plannera/modules/finance/presentation/screens/finance_screen.dart';
import 'package:plannera/modules/home/presentation/screens/home_screen.dart';
import 'package:plannera/modules/routine/presentation/screens/routine_screen.dart';
import 'package:plannera/modules/setting/presentation/screens/setting_screen.dart';
import 'package:plannera/modules/task/presentation/screens/task_screen.dart';
import 'package:plannera/shared/layout/widgets/main_scaffold.dart';

GoRouter createRouter(AuthCubit authCubit) {

  return GoRouter(
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (context, state) {
      // final loggedIn = authCubit.state.isAuthenticated;
      // final loggingIn = state.uri.path == AppRoutes.login.path;

      // if (!loggingIn && !loggedIn) {
      //   final from = state.uri.toString();

      //   return '${AppRoutes.login.path}?from=$from';
      // }

      // if (loggingIn && loggedIn) {
      //   return AppRoutes.home.path;
      // }

      return null;
    },
    initialLocation: AppRoutes.home.path,
    routes: [
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: LoginScreen()),
      ),
      StatefulShellRoute(
        builder:
            (context, state, navigationShell) =>
                MainScaffold(navigationShell: navigationShell),
        navigatorContainerBuilder:
            (context, navigationShell, children) => IndexedStack(
              index: navigationShell.currentIndex,
              children: children,
            ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                name: AppRoutes.home.name,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.finance.path,
                name: AppRoutes.finance.name,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: FinanceScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.tasks.path,
                name: AppRoutes.tasks.name,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: TaskScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.routine.path,
                name: AppRoutes.routine.name,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: RoutineScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings.path,
                name: AppRoutes.settings.name,
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: SettingScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      );
    },
  );
}
