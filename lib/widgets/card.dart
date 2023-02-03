import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: const BorderSide(color: Colors.black, width: 1));

class CardAnimatedWidget extends StatefulWidget {
  final PlayingCard playingCard;
  final bool showBack;
  final double elevation;
  const CardAnimatedWidget(
    this.playingCard,
    this.showBack,
    this.elevation, {
    super.key,
  });

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

    _animation = Tween(begin: .7, end: 0.0).animate(_animationController)
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
    if (widget.showBack == true) {
      return SizedBox(
          height: 180,
          child: PlayingCardView(
            showBack: true,
            card: widget.playingCard,
          ));
    }

    // Animate Card rotation
    _animationController.forward();
    return SizedBox(
      height: 180,
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(pi * _animation.value),
        child: _animation.value > 0.5
            ? PlayingCardView(
                showBack: true,
                card: widget.playingCard,
                elevation: 3.0,
                shape: shape,
              )
            : PlayingCardView(
                showBack: false,
                card: widget.playingCard,
                elevation: 3.0,
                shape: shape,
              ),
      ),
    );
  }
}

// Simple Card
Widget cardWidget(PlayingCard card, bool showBack) {
  return ClipRRect(
      child: SizedBox(
          height: 180,
          child: PlayingCardView(
            card: card,
            showBack: showBack,
            elevation: .75,
            shape: shape,
          )));
}
