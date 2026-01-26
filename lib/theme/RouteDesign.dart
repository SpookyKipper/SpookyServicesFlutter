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
  String _lastPath = "";

  void setTitle(String newTitle) {
    if (_titleOverride != newTitle) {
      setState(() { _titleOverride = newTitle; });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _lastPath = widget.state.uri.path;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    final String newPath = widget.state.uri.path;
    
    if (newPath != _lastPath) {
      final ShellConfig oldConfig = _getConfig(_lastPath);
      final ShellConfig newConfig = _getConfig(newPath);
      
      _titleOverride = null;
      _lastPath = newPath;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients || !mounted) return;

        // 1. Going TO Locked Page -> Jump Top
        if (newConfig.isLocked) {
           _scrollController.jumpTo(0.0);
           return;
        }

        // 2. Locked -> Unlocked -> Force Collapse
        if (oldConfig.isLocked && !newConfig.isLocked) {
           final double expanded = MediaQuery.of(context).size.height * 0.4;
           // Jump to the offset that leaves only the collapsed header visible
           _scrollController.jumpTo(expanded - kToolbarHeight); 
           return;
        }
      });
    }
  }

  ShellConfig _getConfig(String path) {
    return widget.routeConfig[path] ??
           widget.routeConfig['/'] ??
           const ShellConfig(title: "App", icon: Icons.apps);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    final String currentPath = widget.state.uri.path;
    final ShellConfig config = _getConfig(currentPath);

    final String displayTitle = _titleOverride ?? config.title;
    final bool isLocked = config.isLocked;
    final IconData icon = config.icon;
    final List<ShellAction> actions = config.actions;

    // --- HEIGHT CALCULATIONS ---
    // User Requirement: "final double collapsedHeight = kToolbarHeight; no topPadding"
    final double collapsedHeight = kToolbarHeight ; // ~92.0
    
    final double expandedHeight = isLocked
        ? collapsedHeight
        : MediaQuery.of(context).size.height * 0.3; // 30% of screen height;

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
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
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
                        
                        // Progress
                        final double progress = isLocked
                            ? 0.0
                            : ((currentHeight - collapsedHeight * 1.638736229) /
                                    (expandedHeight * 1.098290598 - collapsedHeight * 1.638736229))
                                .clamp(0.0, 1.0);

                       

                        // Colors
                        final collapsedBg = const Color(0xfa6f65dc);
                        final expandedBg = const Color(0x100f10);
                        print("Prrgress: $progress, $currentHeight, $collapsedHeight, $expandedHeight");
                        final backgroundColor = Color.lerp(collapsedBg, expandedBg, progress)!;

                        final onCollapsedColor = Colors.white;
                        final onExpandedColor = colorScheme.onPrimaryContainer;
                        final contentColor = Color.lerp(onCollapsedColor, onExpandedColor, progress)!;

                       

                        // --- POSITIONS ---
                        
                        // 1. BUTTONS (Pin to Bottom)
                        // By positioning at (Height - ToolbarHeight), we ensure:
                        // Collapsed (H=56): Pos = 0 (Top/Fit)
                        // Expanded (H=300): Pos = 244 (Bottom)
                        final double buttonsY = currentHeight - kToolbarHeight;

                         final titlePaddingTop = buttonsY * (1- progress);

                        return Container(
                          color: backgroundColor,
                          child: Stack(
                            children: [
                              // --- TITLE (Vertically Centered) ---
                              // Using Center() widget ensures it's always in the middle
                              // of whatever the current height is.
                              Center(
                                child: Transform.scale(
                                  scale: 1.0 + (0.5 * progress),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: titlePaddingTop),
                                    child: AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 300),
                                      child: Row(
                                        key: ValueKey(displayTitle),
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
                              ),

                              // --- BUTTONS ---
                              Positioned(
                                top: buttonsY,
                                left: 0,
                                right: 0,
                                height: kToolbarHeight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if (context.canPop())
                                        IconButton(
                                          icon: Icon(Icons.arrow_back, color: contentColor),
                                          onPressed: () => context.pop(),
                                        )
                                      else
                                        const SizedBox(width: 48),
                                      const Spacer(),
                                      AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 300),
                                        child: Row(
                                          key: ValueKey(currentPath),
                                          mainAxisSize: MainAxisSize.min,
                                          children: actions.map((action) {
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
                                          }).toList(),
                                        ),
                                      ),
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
              body: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: widget.child,
              ),
              ),
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

  // Clamp the outer scroll position between 0 and boundary so body overscroll
  // can't drag the header into a floating/zero-height state.
  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < 0.0) {
      // Trying to scroll past the top.
      return value - 0.0;
    }
    if (value > boundary) {
      // Trying to scroll past the collapsed boundary.
      return value - boundary;
    }
    return 0.0;
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
    child: isLocked ? child : Padding(
      padding: const EdgeInsets.only(top: 6.5),
      child: child,
    ),
    // You can adjust duration separately for Locked vs Unlocked if you want, 
    // but keeping them same is usually fine.
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 400),
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
        animation: secondaryAnimation.drive(
          CurveTween(curve: const Interval(0.0, 0.5, curve: Curves.linear)),
        ),
        child: SlideEnterTransition(
          animation: animation.drive(
            CurveTween(curve: const Interval(0.55, 1.0, curve: Curves.linear)),
          ),
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
            offset: Offset(0, 15.0 * (1.0 - t)), 
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
            offset: Offset(0, -5.0 * t),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
