import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/models/app_bar_itens.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/presentation/widgets/app_bar_menu_item.dart';
import 'package:portfolio_website/features/home/home_section.dart';
import 'package:portfolio_website/resources/colors.dart';

class CorePage extends StatefulWidget {
  const CorePage({Key? key}) : super(key: key);

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  late final ControlPageCubit controlPageCubit;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    controlPageCubit = BlocProvider.of<ControlPageCubit>(context);
    _scrollController = ScrollController();
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
                  handleTap: () {
                    controlPageCubit.scrollTo(item);
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
              maxWidth: MediaQuery.of(context).size.width * 0.95,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: ListView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              children: const [
                SizedBox(height: kToolbarHeight * 3),
                Align(
                  alignment: Alignment.center,
                  child: HomeSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
