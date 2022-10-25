import 'package:flutter/material.dart';
import 'package:portfolio_website/features/home/presentation/widgets/common/contact_item.dart';
import 'package:portfolio_website/resources/extensions.dart';

class ContactMeItem extends StatelessWidget {
  const ContactMeItem({
    Key? key,
    required this.handleTap,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  final VoidCallback handleTap;
  final String title;
  final String description;
  final IconData icon;

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
          Text(
            description,
            style: context.themeData.headline3!.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
