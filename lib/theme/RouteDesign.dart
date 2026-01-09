// ---------------------------------------------------------------------------
// 1. THE UPDATED SHELL (NestedScrollView + SliverAppBar)
// ---------------------------------------------------------------------------
import 'package:go_router/go_router.dart';
import 'package:spookyservices/widgets/widgets.dart';

class AppShell extends StatelessWidget {
  final GoRouterState state;
  final Widget child;

  const AppShell({super.key, required this.state, required this.child});

  @override
  Widget build(BuildContext context) {
    final isHome = state.uri.path == '/';
    final title = isHome ? "Home" : "Settings";
    final icon = isHome ? Icons.home : Icons.settings;
    
    // Calculate 40% of screen height for the OneUI stretch area
    final double expandedHeight = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      body: NestedScrollView(
        // This allows the header to bounce/stretch when we pull down
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // 1. KEEPS BAR VISIBLE
              pinned: true, 
              
              // 2. THE ONE UI "STRETCH" MAGIC
              stretch: true, 
              
              // 3. HEIGHT SETTINGS
              expandedHeight: expandedHeight,
              toolbarHeight: kToolbarHeight, // Normal height when collapsed
              backgroundColor: Colors.blueGrey,
              
              // 4. THE FLEXIBLE TITLE (Moves from bottom-left to center)
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: true, // Centers title in the expanded 40% area
                titlePadding: const EdgeInsets.only(bottom: 16), // Adjust position
                title: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    key: ValueKey<String>(title),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                background: Container(color: Colors.blueGrey),
              ),
            ),
          ];
        },
        // The Page Content
        body: child,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. THE TRANSITION LOGIC (Same as before)
// ---------------------------------------------------------------------------
CustomTransitionPage buildPageWithTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 600),
    reverseTransitionDuration: const Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return Stack(
        children: [
          SlideUpFadeTransition(
            animation: secondaryAnimation,
            isExit: true,
            child: child,
          ),
          SlideUpFadeTransition(
            animation: animation,
            isExit: false,
            child: child,
          ),
        ],
      );
    },
  );
}

class SlideUpFadeTransition extends StatelessWidget {
  final Animation<double> animation;
  final bool isExit;
  final Widget child;

  const SlideUpFadeTransition({
    super.key,
    required this.animation,
    required this.isExit,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final curve = isExit
        ? const Interval(0.0, 0.4, curve: Curves.easeIn)
        : const Interval(0.5, 1.0, curve: Curves.easeOut);

    final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (context, child) {
        if (curvedAnimation.value == 0.0 && !isExit) {
           return const SizedBox.shrink(); 
        }

        double opacity = 1.0;
        double yOffset = 0.0;

        if (isExit) {
          opacity = 1.0 - curvedAnimation.value;
          yOffset = 0.0 - (5.0 * curvedAnimation.value);
        } else {
          opacity = curvedAnimation.value;
          yOffset = 5.0 - (5.0 * curvedAnimation.value);
        }

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, yOffset),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}