import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1200),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: ClipOval(
          child: Image.asset(
            "assets/profile.jpeg",
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.height * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ),
      ),
    );
  }
}
