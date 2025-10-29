import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spookyservices/functions/theme.dart';
import 'package:spookyservices/spookyservices.dart';
export 'package:flutter/material.dart' hide Card, AppBar;

class Card1 extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final List<Widget>? misc;
  final bool contrast;

  Card1({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.misc,
    this.contrast = false,
  });

  @override
  Widget build(BuildContext context) {

    Color getBackgroundColor() {
      if (contrast) {
        return cLD(colorScheme.onPrimaryContainer, colorScheme.onPrimary);
      } else {
        return colorScheme.primaryContainer;
      }
    }


    return Card(
      color: getBackgroundColor(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...<Widget>[
            ListTile(
              leading: (icon != null) ? Icon(icon) : null,
              title: title != null
                  ? Text(
                      title!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    )
                  : null,
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    )
                  : null,
            ),
          ],
          ...?misc,
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget implements ObstructingPreferredSizeWidget {
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
      backgroundColor: cLD(colorScheme.primaryContainer, colorScheme.onPrimary),
      middle: Text(
        title,
        style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
      ),
      trailing: (actions != null && actions!.isNotEmpty) ? actions![0] : null,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class Button extends StatelessWidget {
  final String? text;
  final Widget? widget;
  final VoidCallback onPressed;
  final bool center;
  final bool contrast;

  const Button({
    super.key,
    this.text,
    required this.onPressed,
    this.widget,
    this.center = false,
    this.contrast = false,
  });

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
    Widget getChild() {
      if (widget != null && text != null) {
        child = Row(children: [widget!, getText(text!)]);
      } else if (text != null) {
        child = getText(text!);
      } else if (widget != null) {
        child = widget!;
      } else {
        throw Exception("Button must have either text and/or widget");
      }
      if (center) {
        return Center(child: child);
      } else {
        return child;
      }
    }

    Color getBackgroundColor() {
      if (contrast) {
        return cLD(colorScheme.onPrimaryContainer, colorScheme.onPrimary);
      } else {
        return colorScheme.primaryContainer;
      }
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: getBackgroundColor(),
        foregroundColor: Colors.white.withValues(alpha: 0.9),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      onPressed: onPressed,
      child: getChild(),
    );
  }
}
