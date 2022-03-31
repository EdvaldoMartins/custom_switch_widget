import 'package:flutter/material.dart';

class CustomSwitchController extends ValueNotifier<bool> {
  final bool initialValue;

  CustomSwitchController({this.initialValue = true}) : super(initialValue);

  /// enable
  void enable() => value = true;

  /// disable
  void disable() => value = false;
}

class CustomSwitchWidget extends StatefulWidget {
  /// [controller] controller
  final CustomSwitchController controller;

  final Function(bool) onChange;

  /// [activeColor] color the widget when enable
  final Color activeColor;

  /// [inactiveColor] color the widget when disable
  final Color inactiveColor;

  /// [pointColor] color the point widget
  final Color pointColor;

  /// [width] width the widget
  final double width;

  /// [height] height the widget
  final double height;

  /// [sizePoint] size the circle to point
  final double sizePoint;

  /// [borderRadius] type border of widget
  final BorderRadiusGeometry? borderRadius;

  CustomSwitchWidget(
      {Key? key,
      required this.controller,
      required this.onChange,
      this.activeColor = Colors.black,
      this.width = 50,
      this.height = 30,
      this.sizePoint = 20,
      this.pointColor = Colors.white,
      this.inactiveColor = Colors.grey,
      this.borderRadius})
      : super(key: key) {
    assert(height >= 20 && height <= 50);
    assert(width >= 30 && width <= 50);
    assert(sizePoint >= 10 && sizePoint <= 30);
  }

  @override
  _CustomSwitchWidgetState createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget>
    with TickerProviderStateMixin {
  late Animation _circle;

  late AnimationController _controller;

  double get _space => (widget.height < 30) ? 2.0 : 4.0;

  /// initialize animation to widget
  void _initializeAnimation() {
    var dur = Duration(milliseconds: 100);
    _controller = AnimationController(vsync: this, duration: dur);

    _circle = AlignmentTween(
            begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  /// run animation
  void _enableOrDisable(bool value) {
    if (value)
      _controller.forward();
    else
      _controller.reverse();
  }

  /// when state changed and update state the widget
  void _changeListener() {
    widget.controller
        .addListener(() => _enableOrDisable(widget.controller.value));
  }

  ///when a user run action manually
  void _onGesture() {
    var value = widget.controller.value;
    widget.onChange(value);
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _enableOrDisable(widget.controller.value);
    _changeListener();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        var color = _circle.value == Alignment.centerLeft
            ? widget.inactiveColor
            : widget.activeColor;
        return GestureDetector(
          onTap: _onGesture,
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.only(left: _space, right: _space),
            decoration: BoxDecoration(
                borderRadius:
                    widget.borderRadius ?? BorderRadius.circular(16.0),
                color: color),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 4.0, right: 0.0, bottom: 4.0),
              child: Align(
                alignment: _circle.value,
                child: Container(
                  width: widget.sizePoint,
                  height: widget.sizePoint,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: widget.pointColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
