import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/utils/color.dart';

class RunningText extends StatefulWidget {
  final List<Choice> choices;
  final Choice? result;
  final bool? skipAnimation;
  final Function()? onAnimationEnded;
  const RunningText({
    Key? key,
    required this.choices,
    this.result,
    this.skipAnimation = false,
    this.onAnimationEnded
  }) : super(key: key);

  @override
  State<RunningText> createState() => _RunningTextState();
}

class _RunningTextState extends State<RunningText> {
  late Choice _currentChoice;
  Timer? _timer;
  int _timerDuration = 100;
  Color _bgColor = VotoColors.gray;
  Color _fgColor = VotoColors.black;

  void _changeCurrentChoice() {
    int _random;
    do {
      _random = Random().nextInt(widget.choices.length);
    } while (widget.choices[_random].id == _currentChoice.id);
    setState(() {
      _currentChoice = widget.choices[_random];
    });
  }

  void _stop() {
    if (_timerDuration > 600) {
      widget.onAnimationEnded?.call();
      setState(() {
        if (widget.result == null) return;
        _currentChoice = widget.result!;
        _bgColor = VotoColors.success;
        _timer = Timer(const Duration(milliseconds: 200), () => setState(() {
          _bgColor = VotoColors.gray;
          _timer?.cancel();
        }));
      });
    } else {
      _changeCurrentChoice();
      final int expo = (((_timerDuration - 100)/100) * ((_timerDuration - 100) / 100)).round();
      _timerDuration += 10 + expo;
      _timer = Timer(Duration(milliseconds: _timerDuration), () => _stop());
    }
  }
  void _setTimer() {
    _timerDuration = 100;
    if (widget.result == null) {
      /***
       * Plays animation forever
       */
      _timer = Timer.periodic(Duration(milliseconds: _timerDuration),
          (_) => _changeCurrentChoice());
    } else {
      /***
       * Gradually slow down
       */
      if (widget.skipAnimation ?? false) {
        _timerDuration = 1000;
        _stop();
        return;
      }
      _timer = Timer(Duration(milliseconds: _timerDuration), () => _stop());
    }
  }

  @override
  void initState() {
    super.initState();
    _currentChoice = widget.choices.first;
    _setTimer();
  }

  @override
  void didUpdateWidget(covariant RunningText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.choices != widget.choices) {
      /***
       * Choices have changed
       */
      _timer?.cancel();
      _setTimer();
    } else if (oldWidget.skipAnimation != widget.skipAnimation) {
      /***
       * Update because animation has ended
       */
      _setTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
              height: 84,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _bgColor
              ),
              child: Center(
                child: Text('${_currentChoice.text}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _fgColor
                    )
                  )
              ),
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
            );
  }
}