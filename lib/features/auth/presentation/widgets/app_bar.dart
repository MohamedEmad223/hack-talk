import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String AssetPath;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final Color? backgroundColor;
  final Function()? ontap;

  const CustomAppBar({
    super.key,
    this.AssetPath = 'assets/images/Frame 385.png',
    this.titleWidget,
    this.actions,
    this.bottom,
    this.elevation = 4.0,
    this.backgroundColor, this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: AppBar(
        
        forceMaterialTransparency: true,
        title: titleWidget ?? Image.asset(AssetPath),
        actions: actions,
        bottom: bottom,
        elevation: elevation,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height);
}
