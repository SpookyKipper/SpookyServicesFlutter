import 'package:go_router/go_router.dart';
import 'package:spookyservices/widgets/widgets.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// DATA MODELS
// ---------------------------------------------------------------------------

class ShellAction {
  final IconData icon;
  final void Function(BuildContext context) onPressed;
  const ShellAction({required this.icon, required this.onPressed});
}

class ShellConfig {
  final String title;
  final IconData icon;
  final bool isLocked;
  final List<ShellAction> actions;

  const ShellConfig({
    required this.title,
    required this.icon,
    this.isLocked = false,
    this.actions = const [],
  });
}

// ---------------------------------------------------------------------------
// INHERITED WIDGET
// ---------------------------------------------------------------------------

class AppShellScope extends InheritedWidget {
  final _AppShellState data;
  const AppShellScope({super.key, required this.data, required super.child});
  @override
  bool updateShouldNotify(AppShellScope oldWidget) => true;
}

// ---------------------------------------------------------------------------
// APP SHELL
// ---------------------------------------------------------------------------

class AppShell extends StatefulWidget {
  final GoRouterState state;
  final Widget child;
  final Map<String, ShellConfig> routeConfig;

  const AppShell({
    super.key,
    required this.state,
    required this.child,
    required this.routeConfig,
  });

  static _AppShellState of(BuildContext context) {
    final AppShellScope? scope = context.dependOnInheritedWidgetOfExactType<AppShellScope>();
    assert(scope != null, "No AppShell found in context");
    return scope!.data;
  }

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late ScrollController _scrollController;
  bool _isFirstLoad = true;
  String? _titleOverride; 
  // removed _lastPath (No longer needed)

  /// Call this to set a temporary title (e.g. "Downloading...")
  void setTitle(String newTitle) {
    if (_titleOverride != newTitle) {
      setState(() { _titleOverride = newTitle; });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // --- FIX: ROBUST RESET LOGIC ---
  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);

    final String oldPath = oldWidget.state.uri.path;
    final String newPath = widget.state.uri.path;
    
    // DIRECT COMPARISON: If the route changed, reset everything.
    if (oldPath != newPath) {
      
      // 1. Reset Title Override
      _titleOverride = null;

      // 2. Handle Scroll/Layout Resets
      final ShellConfig oldConfig = _getConfig(oldPath, oldWidget.routeConfig);
      final ShellConfig newConfig = _getConfig(newPath, widget.routeConfig);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients || !mounted) return;

        // A. Going TO a Locked Page -> Jump to Top
        if (newConfig.isLocked) {
           _scrollController.jumpTo(0.0);
           return;
        }

        // B. Going FROM Locked TO Unlocked -> Force Collapse
        if (oldConfig.isLocked && !newConfig.isLocked) {
           final double expanded = MediaQuery.of(context).size.height * 0.4;
           final double collapsed = kToolbarHeight;
           _scrollController.jumpTo(expanded - collapsed);
           return;
        }
        
        // C. Unlocked -> Unlocked: Keep scroll position (Do nothing)
      });
    }
  }

  // Helper to look up config safely
  ShellConfig _getConfig(String path, Map<String, ShellConfig> configMap) {
    return configMap[path] ??
           configMap['/'] ??
           const ShellConfig(title: "App", icon: Icons.apps);
  }

  double uiLerp(double a, double b, double t) => a + (b - a) * t;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final topPadding = MediaQuery.of(context).padding.top;
    
    final String currentPath = widget.state.uri.path;
    final ShellConfig config = _getConfig(currentPath, widget.routeConfig);

    // Use override if set, otherwise config title
    final String displayTitle = _titleOverride ?? config.title;
    
    final bool isLocked = config.isLocked;
    final IconData icon = config.icon;
    final List<ShellAction> actions = config.actions;

    final double collapsedHeight = kToolbarHeight;
    final double expandedHeight = isLocked
        ? kToolbarHeight
        : MediaQuery.of(context).size.height * 0.4;

    final double scrollOffsetToCollapse = expandedHeight - collapsedHeight;

    if (_isFirstLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients && mounted) {
          if (!isLocked) {
            _scrollController.jumpTo(scrollOffsetToCollapse);
          }
          setState(() => _isFirstLoad = false);
        }
      });
    }

    return Scaffold(
      body: Opacity(
        opacity: _isFirstLoad ? 0 : 1,
        child: AppShellScope(
          data: this,
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              if (_scrollController.hasClients && !isLocked) {
                final currentOffset = _scrollController.offset;
                if (currentOffset > 0 && currentOffset < scrollOffsetToCollapse) {
                  final double midpoint = scrollOffsetToCollapse / 2;
                  final double targetOffset = (currentOffset > midpoint)
                      ? scrollOffsetToCollapse
                      : 0.0;
                  Future.microtask(() {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        targetOffset,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                      );
                    }
                  });
                }
              }
              return false;
            },
            child: NestedScrollView(
              controller: _scrollController,
              physics: isLocked
                  ? const NeverScrollableScrollPhysics()
                  : OneUiScrollPhysics(boundary: scrollOffsetToCollapse),
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    stretch: false,
                    expandedHeight: expandedHeight,
                    collapsedHeight: collapsedHeight,
                    toolbarHeight: kToolbarHeight,
                    backgroundColor: Colors.transparent,
                    leading: null,
                    actions: null,
                    automaticallyImplyLeading: false,

                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final currentHeight = constraints.maxHeight;
                        final double progress = isLocked
                            ? 0.0
                            : ((currentHeight - collapsedHeight) /
                                    (expandedHeight - collapsedHeight))
                                .clamp(0.0, 1.0);

                        final collapsedBg = const Color(0xFF6F65DC);
                        final expandedBg = colorScheme.primaryContainer;
                        final backgroundColor = Color.lerp(collapsedBg, expandedBg, progress)!;

                        final onCollapsedColor = Colors.white;
                        final onExpandedColor = colorScheme.onPrimaryContainer;
                        final contentColor = Color.lerp(onCollapsedColor, onExpandedColor, progress)!;

                        final double collapsedBtnY = 0.0;
                        final double expandedBtnY = expandedHeight - kToolbarHeight - 4.0;
                        final double currentBtnY = uiLerp(collapsedBtnY, expandedBtnY, progress);

                        return Container(
                          color: backgroundColor,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: topPadding + (30.0 * progress),
                                  ),
                                  child: Transform.scale(
                                    scale: 1.0 + (0.5 * progress),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(icon, color: contentColor, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          displayTitle,
                                          style: TextStyle(
                                            color: contentColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: currentBtnY,
                                left: 0,
                                right: 0,
                                height: kToolbarHeight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: topPadding * (1.0 - progress),
                                    left: 4.0,
                                    right: 4.0,
                                  ),
                                  child: Row(
                                    children: [
                                      if (context.canPop())
                                        IconButton(
                                          icon: Icon(Icons.arrow_back, color: contentColor),
                                          onPressed: () => context.pop(),
                                        )
                                      else
                                        const SizedBox(width: 48),
                                      const Spacer(),
                                      ...actions.map((action) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(action.icon, color: contentColor),
                                              onPressed: () => action.onPressed(context),
                                            ),
                                            const SizedBox(width: 4),
                                          ],
                                        );
                                      }),
                                      const SizedBox(width: 4),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ];
              },
              body: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class OneUiScrollPhysics extends ClampingScrollPhysics {
  final double boundary;
  const OneUiScrollPhysics({required this.boundary, super.parent});
  @override
  OneUiScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OneUiScrollPhysics(boundary: boundary, parent: buildParent(ancestor));
  }
  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final isAtCollapsedBoundary = position.pixels >= boundary - 0.5;
    final isTryingToExpand = velocity < 0.0;
    if (isAtCollapsedBoundary && isTryingToExpand) return null;
    return super.createBallisticSimulation(position, velocity);
  }
}

CustomTransitionPage buildPageWithTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required Map<String, ShellConfig> routeConfig, // <--- Inject Config
}) {
  // 1. Dynamic Lookup
  final bool isLocked = routeConfig[state.uri.path]?.isLocked ?? false;

  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    // You can adjust duration separately for Locked vs Unlocked if you want, 
    // but keeping them same is usually fine.
    transitionDuration: const Duration(milliseconds: 600),
    reverseTransitionDuration: const Duration(milliseconds: 600),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      
      // 2. LOCKED: Use Flutter's built-in FadeTransition
      // This is the "Default" way to do a fade in Flutter.
      if (isLocked) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      }

      // 3. UNLOCKED: Use your Custom Slide Transition
      return SlideExitTransition(
        animation: secondaryAnimation,
        child: SlideEnterTransition(
          animation: animation,
          child: child,
        ),
      );
    },
  );
}

/// Handles the New Page arriving
class SlideEnterTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const SlideEnterTransition({super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final bool isReverse = animation.status == AnimationStatus.reverse;
        
        // Use the whole duration (0.0 -> 1.0) for maximum smoothness.
        // EaseOutCubic feels snappy but smooth.
        double t = isReverse 
            ? Curves.easeInCubic.transform(animation.value) // Leave smooth
            : Curves.easeOutCubic.transform(animation.value); // Enter snappy

        if (t == 0.0) return Opacity(opacity: 0, child: child!);

        return Opacity(
          opacity: t,
          child: Transform.translate(
            // Slide UP from bottom (30px -> 0px)
            offset: Offset(0, 30.0 * (1.0 - t)), 
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

/// Handles the Old Page leaving
class SlideExitTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const SlideExitTransition({super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final bool isReverse = animation.status == AnimationStatus.reverse;

        // Use the whole duration.
        double t = isReverse 
            ? Curves.easeInCubic.transform(animation.value)
            : Curves.easeOutCubic.transform(animation.value);

        if (t == 1.0) return Opacity(opacity: 0, child: child!);

        return Opacity(
          opacity: 1.0 - t,
          child: Transform.translate(
            // Slide UP slightly (-30px) as it fades out.
            // This creates the "Go up a little too" effect.
            offset: Offset(0, -30.0 * t),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
