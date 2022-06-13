class AppConstraints {
  static double get kMobileBreakpoint => 650.0;

  static bool isMobile(double constraints) => constraints <= kMobileBreakpoint;
}
