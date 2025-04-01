import 'package:agent/src/common/extensions/context.dart';
import 'package:agent/src/common/widgets/text.dart';
import 'package:agent/src/config/styles.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:icons_plus/icons_plus.dart';

class Dropdown extends StatelessWidget {
  final List<String> items;
  final String selectedItem;
  final void Function(String? value) itemChange;
  final double? height;
  final BorderSide? border;
  const Dropdown({
    required this.items,
    required this.selectedItem,
    required this.itemChange,
    super.key,
    this.height,
    this.border,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height ?? 50,
        width: double.infinity,
        // margin: const EdgeInsets.all(20),
        child: DropdownButtonHideUnderline(
          child: GFDropdown(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemHeight: height ?? 50,
            isExpanded: true,
            borderRadius: BorderRadius.circular(5),
            border: border ??
                const BorderSide(
                  color: lightTextColor,
                  width: 0.5,
                ),
            dropdownButtonColor: Colors.transparent,
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Iconsax.arrow_down_1_outline,
                color: context.color.tertiary,
                size: 18,
              ),
            ),
            value: selectedItem,
            elevation: 0,
            focusColor: Colors.transparent,
            onChanged: (value) => itemChange(value),
            items: items
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: AppText(
                        value,
                        color: context.color.tertiary,
                      ),
                    ))
                .toList(),
          ),
        ),
      );
}

class CustomDropdownMenu extends StatelessWidget {
  final List<MenuItem> items;
  final IconData? icon;
  final Widget? child;
  final Color? backgroundColor;

  const CustomDropdownMenu({
    required this.items,
    super.key,
    this.icon,
    this.child,
    this.backgroundColor,
    // this.onSelected,
  });

  @override
  Widget build(BuildContext context) => PopupMenuButton<MenuItem>(
        icon: child ?? Icon(icon ?? Icons.more_horiz), // Three-dot menu icon
        onSelected: (item) => item.onTap?.call(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        position: PopupMenuPosition.under,
        color: backgroundColor,
        popUpAnimationStyle: AnimationStyle(curve: Curves.easeInOut),
        itemBuilder: (context) => items
            .map((item) => PopupMenuItem<MenuItem>(
                  value: item,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 110),
                    child: Row(
                      children: [
                        Icon(item.icon,
                            size: 20, color: item.color ?? Colors.black54),
                        const SizedBox(width: 8),
                        AppText(
                          item.text,
                          color: item.color,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      );
}

class MenuItem {
  final String text;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;

  MenuItem({required this.text, required this.icon, this.color, this.onTap});
}
