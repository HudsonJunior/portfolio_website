class AppConstraints {
  static double get kMobileBreakpoint => 850.0;

  static bool isMobile(double constraints) => constraints <= kMobileBreakpoint;
}
