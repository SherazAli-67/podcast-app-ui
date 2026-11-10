import 'package:flutter/material.dart';
import 'package:podcast_app_ui/constants/number_constant.dart';

/// Fades/slides in with a per-index delay, and optionally scales on press.
class StaggeredPressable extends StatefulWidget {
  final int index;
  final Widget child;
  final VoidCallback? onTap;

  const StaggeredPressable({
    super.key,
    required this.index,
    required this.child,
    this.onTap,
  });

  @override
  State<StaggeredPressable> createState() => _StaggeredPressableState();
}

class _StaggeredPressableState extends State<StaggeredPressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final child = disableAnimations
        ? widget.child
        : _buildStaggeredEntrance(widget.child);

    if (widget.onTap == null) return child;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: disableAnimations ? null : (_) => setState(() => _pressed = true),
      onTapUp: disableAnimations ? null : (_) => setState(() => _pressed = false),
      onTapCancel: disableAnimations ? null : () => setState(() => _pressed = false),
      behavior: .opaque,
      child: disableAnimations
          ? child
          : AnimatedScale(
              scale: _pressed ? NumberConstant.homePressScale : 1,
              duration: const Duration(milliseconds: NumberConstant.homePressAnimMs),
              curve: Curves.easeOutCubic,
              child: child,
            ),
    );
  }

  Widget _buildStaggeredEntrance(Widget child) {
    final delayMs = widget.index * NumberConstant.homeStaggerDelayMs;
    final totalMs = NumberConstant.homeItemAnimMs + delayMs;
    final begin = delayMs / totalMs;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: totalMs),
      curve: Interval(begin, 1, curve: Curves.easeOutCubic),
      builder: (context, value, animatedChild) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, NumberConstant.homeItemSlideOffset * (1 - value)),
            child: animatedChild,
          ),
        );
      },
      child: child,
    );
  }
}
