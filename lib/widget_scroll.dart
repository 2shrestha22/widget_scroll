library widget_scroll;

import 'dart:async';

import 'package:flutter/material.dart';

class WidgetScroll extends StatefulWidget {
  ///Use Column or Row
  ///
  ///Example.
  ///   ```dart
  ///   Column(
  ///   children: noticeList
  ///        .map((notice) => CachedNetworkImage(
  ///              imageUrl: notice.noticePhoto,
  ///              fit: BoxFit.fitWidth,
  ///              width: double.infinity,
  ///            ))
  ///        .toList(),
  ///   )
  /// ```
  final Widget child;
  final Duration pauseDuration;
  final int speedFactor;
  final Axis scrollDirection;

  // final Axis direction;
  // final Duration animationDuration, backDuration, pauseDuration;

  WidgetScroll({
    Key key,

    ///Use Column or Row
    /// eg.Column(
    ///    children: noticeList
    ///        .map((notice) => CachedNetworkImage(
    ///              imageUrl: notice.noticePhoto,
    ///              fit: BoxFit.fitWidth,
    ///              width: double.infinity,
    ///            ))
    ///        .toList(),
    ///  )
    @required this.child,
    this.pauseDuration = const Duration(seconds: 4),
    this.speedFactor = 20,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  @override
  _WidgetScrollState createState() => _WidgetScrollState();
}

class _WidgetScrollState extends State<WidgetScroll> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scroll(context));
  }

  final ScrollController _scrollController = ScrollController();

  final bool scroll = true;

  _scroll(BuildContext context) async {
    await Future.delayed(widget.pauseDuration);
    // print('scroll called');
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / widget.speedFactor;

    if (_scrollController.offset >= maxExtent) {
      // print('bottom reached');
      _scrollController.jumpTo(
        0.0,
      );
      await Future.delayed(widget.pauseDuration);
    } else {
      // print('keep scrolling');
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(seconds: durationDouble.toInt()),
          curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notif) {
        if (notif is ScrollEndNotification && scroll) {
          Timer(widget.pauseDuration, () {
            _scroll(context);
          });
        }
        return true;
      },
      child: SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        controller: _scrollController,
        child: widget.child,
      ),
    );
  }
}
