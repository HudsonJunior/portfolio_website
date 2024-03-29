import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/hover_scale_effect.dart';
import 'package:portfolio_website/resources/colors.dart';
import 'package:portfolio_website/resources/extensions.dart';

class SeeMyWorksWidget extends StatelessWidget {
  const SeeMyWorksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverScaleEffect(
      child: InkWell(
        onTap: () {
          BlocProvider.of<ControlPageCubit>(context).scrollTo(
            AppBarItens.works,
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                "see my works",
                style: context.themeData.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Center(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
