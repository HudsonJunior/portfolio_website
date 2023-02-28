import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/about/presentation/about_section.dart';
import 'package:portfolio_website/features/contact/presentation/contact_section.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/app_bar_menu_item.dart';
import 'package:portfolio_website/features/home/presentation/home_section.dart';
import 'package:portfolio_website/features/works/works_section.dart';
import 'package:portfolio_website/resources/colors.dart';

class CorePage extends StatefulWidget {
  const CorePage({Key? key}) : super(key: key);

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  late final ControlPageCubit controlPageCubit;
  late final ScrollController _scrollController;

  final sectionItens = [
    const HomeSection(),
    const WorksSection(),
    const AboutSection(),
    const ContactSection(),
  ];

  @override
  void initState() {
    super.initState();
    controlPageCubit = BlocProvider.of<ControlPageCubit>(context);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.hasClients) {
          controlPageCubit.updateBasedOnScrollPosition(
            _scrollController.position.pixels,
            MediaQuery.of(context).size.height * .95,
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.backgroundColor,
        actions: [
          ...AppBarItens.values.map(
            (item) => BlocBuilder<ControlPageCubit, AppBarItens>(
              bloc: controlPageCubit,
              builder: (context, selected) {
                return AppBarMenuItem(
                  title: item.name,
                  handleTap: () async {
                    await _scrollController.animateTo(
                      item.index * MediaQuery.of(context).size.height * .95,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    );
                  },
                  isSelected: item == selected,
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 1000,
                            ),
                            child: sectionItens[index],
                          ),
                        ),
                      );
                    },
                    childCount: sectionItens.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
