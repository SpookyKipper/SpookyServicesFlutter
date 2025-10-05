import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spookyservices/spookyservices.dart';

class AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool backButton;
  final bool automaticallyImplyLeading;

  const AppBar({
    super.key,
    required this.title,
    this.actions,
    this.backButton = false,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: (backButton)
          ? CupertinoButton(
              padding: const EdgeInsets.only(right: 30),
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(
                CupertinoIcons.back,
                color: Colors.white.withValues(
                  alpha: 0.9,
                ), // set your desired icon color
              ),
            )
          : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: colorScheme.onPrimary,
      middle: Text(
        title,
        style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
      ),
      trailing: (actions != null && actions!.isNotEmpty) ? actions![0] : null,
    );
  }
}

class Button extends StatelessWidget {
  final String? text;
  final Widget? widget;
  final VoidCallback onPressed;
  const Button({super.key, this.text, required this.onPressed, this.widget});

  @override
  Widget build(BuildContext context) {

    Text getText(String text) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      );
    }

    late final Widget child;
    if (widget != null && text != null) {
      child = Row(children: [widget!, getText(text!)],);
    } else if (text != null) {
      child = getText(text!);
    } else if (widget != null) {
      child = widget!;
    } else {
      throw Exception("Button must have either text and/or widget");
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: Colors.white.withValues(alpha: 0.9),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
