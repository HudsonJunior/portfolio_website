import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/pages/core_page.dart';
import 'package:portfolio_website/features/splash/presentation/widgets/spining_circle_painter.dart';
import 'package:portfolio_website/resources/extensions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController textAnimationController;
  late final AnimationController loadingAnimationController;
  double radiusOpenHomeCircle = 0.0;

  @override
  void initState() {
    super.initState();
    textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          loadingAnimationController.forward();
        }
      })
      ..forward();

    loadingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            radiusOpenHomeCircle = MediaQuery.of(context).size.height +
                MediaQuery.of(context).size.width;
          });
        }
      });
  }

  @override
  void dispose() {
    textAnimationController.dispose();
    loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: Tween(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(
                      textAnimationController,
                    ),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: textAnimationController.value,
                        child: child,
                      );
                    },
                    child: Text(
                      "HUDSON JÚNIOR",
                      style: context.themeData.headline1,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 0.6,
                    child: AnimatedBuilder(
                      animation: Tween<double>(
                        begin: 0.0,
                        end: 100,
                      ).animate(
                        loadingAnimationController,
                      ),
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: loadingAnimationController.value,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInCirc,
                tween: Tween(begin: 0.0, end: radiusOpenHomeCircle),
                builder: (context, value, child) => CustomPaint(
                  painter: SpiningCirclerPainter(value),
                  child: Container(),
                ),
                onEnd: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const CorePage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
