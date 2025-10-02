import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spookyservices/functions/theme.dart';
import '../../spookyservices.dart';


class AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool backButton;

  const AppBar({
    super.key,
    required this.title,
    this.actions,
    this.backButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    

    return CupertinoNavigationBar(
      leading: Row(
        children: [
          ?(backButton)
              ? CupertinoButton(
                  padding: EdgeInsets.only(right: 30),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(
                    CupertinoIcons.back,
                    color: Colors.white.withValues(alpha: 0.9), // set your desired icon color
                  ),
                )
              : null,
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              title,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.onPrimary,
      trailing: (actions != null && actions!.isNotEmpty) ? actions![0] : null,
    );
  }
}


class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: Colors.white.withValues(alpha: 0.9),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}