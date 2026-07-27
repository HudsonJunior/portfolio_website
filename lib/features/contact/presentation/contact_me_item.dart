import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/contact_item.dart';
import 'package:portfolio_website/resources/extensions.dart';

class ContactMeItem extends StatelessWidget {
  const ContactMeItem({
    super.key,
    required this.handleTap,
    required this.title,
    required this.description,
    required this.icon,
  });

  final VoidCallback handleTap;
  final String title;
  final String description;
  final FaIconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleTap,
      child: Row(
        children: [
          ContactItem(
            icon: icon,
            itemName: title,
            handleTap: handleTap,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              description,
              style: context.themeData.displaySmall!.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
