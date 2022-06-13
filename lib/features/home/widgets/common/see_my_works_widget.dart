import 'package:flutter/material.dart';
import 'package:portfolio_website/features/core/presentation/widgets/hover_rotation_effect.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class SeeMyWorksWidget extends StatelessWidget {
  const SeeMyWorksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverRotationEffect(
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                "See my works",
                style: context.themeData.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Center(
              child: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
