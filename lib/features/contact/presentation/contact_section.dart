import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/contact/presentation/contact_content.dart';
import 'package:portfolio_website/features/contact/presentation/cubit/contact_cubit.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => ContactCubit(),
      child: Builder(
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocListener<ControlPageCubit, AppBarItens>(
              listener: (_, state) {
                if (state == AppBarItens.contact) {
                  context.read<ContactCubit>().changeVisibility();
                }
              },
              key: const Key("contact_section"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: BlocBuilder<ContactCubit, bool>(
                      builder: (context, isVisible) {
                        return SectionHeader(
                          isVisible: isVisible,
                          headerTitle: "contact me",
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  BlocBuilder<ContactCubit, bool>(
                    builder: (context, isVisible) {
                      if (isVisible) {
                        return const Expanded(child: ContactContent());
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
