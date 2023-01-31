import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class CardAnimatedWidget extends StatefulWidget {
  final PlayingCard playingCard;
  const CardAnimatedWidget(this.playingCard, {super.key});

  @override
  State<CardAnimatedWidget> createState() => _CardAnimatedWidgetState();
}

class _CardAnimatedWidgetState extends State<CardAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(pi * _animation.value),
        child: GestureDetector(
          onTap: () {
            if (_animationStatus == AnimationStatus.dismissed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
          child: _animation.value > 0.5
              ? PlayingCardView(
                  showBack: true,
                  card: widget.playingCard,
                )
              : PlayingCardView(
                  showBack: false,
                  card: widget.playingCard,
                ),
        ),
      ),
    );
  }
}
