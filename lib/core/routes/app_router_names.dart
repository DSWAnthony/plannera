enum AppRoutes {
  root('/'),
  home('/home'),
  finance('/finance'),
  calendar('/calendar'),
  tasks('/tasks'),
  routine('/routine'),
  settings('/settings'),
  login('/login'),
  register('/register');

  final String path;

  const AppRoutes(this.path);
}
