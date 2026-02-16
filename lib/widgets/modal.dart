import 'package:spookyservices/functions/theme.dart';
import 'package:spookyservices/widgets/widgets.dart';

void showModal(BuildContext context, String title, String content, {List<Widget>? actions}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    barrierDismissible: true,
    barrierLabel: title,
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, anim1, anim2, widget) {
      final curvedAnimation = CurvedAnimation(
        parent: anim1,
        curve: Curves.easeOut, // ease-out
      );

      return FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: Tween(
            begin: Offset(0, -0.05),
            end: Offset(0, 0),
            // curve
          ).animate(curvedAnimation),
          child: LithiumModal(
            title: "Copyright Information",
            content:
                '''App originally created by Spooky Kipper (Spooky Services)
Copyright © 2026
Licensed under GNU GPLv3.
https://github.com/SpookyKipper/CellularViewer/
                                                      
This app uses open source libraries.
Click "View licenses" for more information.
This app uses a modified version of flutter_cell_info. Source: https://github.com/SpookyKipper/flutter_cell_info
''',
          ),
        ),
      );
    },
  );
}


class LithiumModal extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget>? actions;

  const LithiumModal({
    required this.title,
    required this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: cLD(
              Colors.white,
              Theme.of(context).colorScheme.primaryContainer,
            ),
            borderRadius: BorderRadius.circular(
              10.0,
            ), // Apply 20px radius to all corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cLD(
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ), // Apply 20px radius to all corners
                    ),
                    child: Center(
                      child: Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      text: "Close",
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    actions != null ? SizedBox(width: 10) : SizedBox.shrink(),
                    ...?actions,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
