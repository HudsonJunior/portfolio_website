class AppConstraints {
  static double get kMobileBreakpoint => 700.0;

  static bool isMobile(double constraints) => constraints <= kMobileBreakpoint;
}
