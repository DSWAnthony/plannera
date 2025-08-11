import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plannera/core/routes/app_router_names.dart';
import 'package:plannera/modules/finance/presentation/screens/finance_screen.dart';
import 'package:plannera/modules/home/presentation/screens/home_screen.dart';
import 'package:plannera/modules/routine/presentation/screens/routine_screen.dart';
import 'package:plannera/modules/setting/presentation/screens/setting_screen.dart';
import 'package:plannera/modules/task/presentation/screens/task_screen.dart';
import 'package:plannera/shared/layout/widgets/main_scaffold.dart';

final router = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    StatefulShellRoute(
      builder: (context, state, navigationShell) => MainScaffold(navigationShell: navigationShell,),
      navigatorContainerBuilder: (context, navigationShell, children) => IndexedStack(
        index: navigationShell.currentIndex,
        children: children,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home.path,
              name: AppRoutes.home.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen()
              ),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.finance.path,
              name: AppRoutes.finance.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FinanceScreen()
              ),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.tasks.path,
              name: AppRoutes.tasks.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TaskScreen()
              ),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.routine.path,
              name: AppRoutes.routine.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RoutineScreen()
              ),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings.path,
              name: AppRoutes.settings.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingScreen()
              ),
            )
          ]
        )
      ],
    )
  ]
);
