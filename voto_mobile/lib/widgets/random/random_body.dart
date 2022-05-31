import 'package:flutter/material.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/random/random_item.dart';
import 'package:voto_mobile/widgets/rich_button.dart';

class RandomBody extends StatefulWidget {
  final String type;
  final List<Choice> choices;
  final bool isClosed;
  final bool renderAsResult;
  final BuildContext? context;
  const RandomBody({
    Key? key,
    required this.type,
    required this.choices,
    this.isClosed = false,
    this.renderAsResult = false,
    this.context
  }) : super(key: key);

  @override
  State<RandomBody> createState() => _RandomBodyState();
}

class _RandomBodyState extends State<RandomBody> {
  bool _skipAnimation = false;
  bool _animationEnded = false;

  @override
  Widget build(BuildContext context) {
    final bool showButton = widget.isClosed && !widget.renderAsResult && !_skipAnimation && !_animationEnded;
    if (widget.type == 'lucky') {
      return Column(
        children: [
          RandomItem(
            choices: widget.choices,
            skipAnimation: _skipAnimation,
            onAnimationEnded: () {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                 setState(() => _animationEnded = true);
              });
            },
            renderAsResult: widget.renderAsResult,
            context: widget.context
          ),
          const SizedBox(height: 15),
          if (showButton)
              RichButton(
                  text: 'Skip animation',
                  icon: Icons.skip_next,
                  accentColor: VotoColors.indigo,
                  onPressed: () {
                    setState(() => _skipAnimation = true);
                  },
                  width: 200)
        ]
      );
    } else {
      return Expanded(
        child: ListView.separated(
          itemBuilder: (context, index) => index == 0
              ? showButton
                ? RichButton(
                    text: 'Skip animation',
                    icon: Icons.skip_next,
                    accentColor: VotoColors.indigo,
                    onPressed: () {
                      setState(() => _skipAnimation = true);
                    },
                    width: 200)
                : Container()
              : RandomItem(
                  singleChoice: widget.choices[index - 1],
                  choices: widget.choices,
                  skipAnimation: _skipAnimation,
                  onAnimationEnded: () {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      setState(() => _animationEnded = true);
                    });
                  },
                  renderAsResult: widget.renderAsResult,
                  context: widget.context),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: widget.choices.length + 1,
        )
      );
    }
  }
}