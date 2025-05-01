import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';

class Button extends StatefulWidget {
  final Function() onTap;
  final String title;
  const Button({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double buttonAnimatePadding = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween<double>(begin: buttonAnimatePadding, end: 0)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        widget.onTap(); // Call onTap after the reverse animation completes
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          left: 0,
          right: buttonAnimatePadding,
          top: buttonAnimatePadding,
          child: Container(
            color: Colors.black,
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Positioned(
              top: 0,
              left: _animation.value,
              right: 0,
              bottom: _animation.value,
              child: GestureDetector(
                onTap: _handleTap,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  color: Colors.white,
                  child: Text(
                    widget.title,
                    style: CustomTextTheme.text12,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
        Visibility(
          visible: false,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: Row(
            children: [
              Column(
                children: [
                  SizedBox(height: buttonAnimatePadding),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 10.h),
                      color: Colors.white,
                      child: Text(
                        widget.title,
                        style: CustomTextTheme.text12,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: buttonAnimatePadding)
            ],
          ),
        ),
      ],
    );
  }
}
