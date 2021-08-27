import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';

enum ButtonType { RaisedButton, FlatButton, OutlineButton }

const int aSec = 1;

const String secPostFix = 's';
const String labelSplitter = "  |  ";

class TimerButtonCustom extends StatefulWidget {
  /// Create a TimerButton button.
  ///
  /// The [label], [onPressed], and [timeOutInSeconds]
  /// arguments must not be null.

  ///label
  final String? label;

  ///[timeOutInSeconds] after which the button is enabled
  final int?timeOutInSeconds;

  ///[onPressed] Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// Defines the button's base colors
  final Color? color;

  /// The color to use for this button's text when the button is disabled.
  final Color? disabledColor;

  /// activeTextStyle
  final TextStyle? activeTextStyle;

  ///disabledTextStyle
  final TextStyle? disabledTextStyle;

  ///buttonType
  final ButtonType? buttonType;

  ///If resetTimerOnPressed is true reset the timer when the button is pressed : default to true
  final bool resetTimerOnPressed;

  const TimerButtonCustom({
    Key? key,
    @required this.label,
    @required this.onPressed,
    @required this.timeOutInSeconds,
    this.color = Colors.blue,
    this.resetTimerOnPressed = true,
    this.disabledColor,
    this.buttonType = ButtonType.RaisedButton,
    this.activeTextStyle = const TextStyle(color: Colors.white),
    this.disabledTextStyle = const TextStyle(color: Colors.black45),
  })  : assert(label != null),
        assert(activeTextStyle != null),
        assert(disabledTextStyle != null),
        super(key: key);

  @override
  _TimerButtonCustom createState() => _TimerButtonCustom();
}

class _TimerButtonCustom extends State<TimerButtonCustom> {
  bool timeUpFlag = false;
  int timeCounter = 0;

  String get _timerText => '$timeCounter$secPostFix';

  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds!;
    _timerUpdate();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: aSec), () async {
      setState(() {
        timeCounter--;
      });
      if (timeCounter != 0)
        _timerUpdate();
      else
        timeUpFlag = true;
    });
  }

  // Widget _buildChild() {
  //   return Container(
  //     child: timeUpFlag
  //         ? Text(
  //       widget.label,
  //       style: (widget.buttonType == ButtonType.OutlineButton)
  //           ? widget.activeTextStyle.copyWith(color: widget.color)
  //           : widget.activeTextStyle,
  //     )
  //         : Text(
  //       widget.label + labelSplitter + _timerText,
  //       style: widget.disabledTextStyle,
  //     ),
  //   );
  // }

  _onPressed() {
    if (timeUpFlag) {
      setState(() {
        timeUpFlag = false;
      });
      timeCounter = widget.timeOutInSeconds!;

      if (widget.onPressed != null) {
        widget.onPressed!();
      }
      // reset the timer when the button is pressed
      if (widget.resetTimerOnPressed) {
        _timerUpdate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: timeUpFlag ? Colors.white : Pigment.fromString(BG_SELECT_PHOTO),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: (){
            if(timeUpFlag){
              _onPressed();
            }
          },
          child: Container(
              width: autoSizedWidth(context, 1),
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Pigment.fromString(PRIMARY_COLOR))
              ),
              child: timeUpFlag
                  ? Text(
                widget.label!,
                style: (widget.buttonType == ButtonType.OutlineButton)
                    ? widget.activeTextStyle!.copyWith(color: widget.color)
                    : widget.activeTextStyle,
              )
                  : Text(
                widget.label! + labelSplitter + _timerText,
                style: widget.disabledTextStyle,
                textAlign: TextAlign.center,
              )
          ),
        ),
      ),
    );
  }
}
