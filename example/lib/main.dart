import 'package:flutter/material.dart';
import 'package:widget_scroll/widget_scroll.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<String> images = [
    'https://picsum.photos/id/1/200/300',
    'https://picsum.photos/id/2/300/200',
    'https://picsum.photos/id/10/500/300',
    'https://picsum.photos/id/15/200/500',
    'https://picsum.photos/id/20/500/200',
    'https://picsum.photos/id/90/200',
    'https://picsum.photos/id/100/700/300',
    'https://picsum.photos/id/101/300',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Scroll',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget Scroll'),
        ),
        body: Column(
          children: [
            Expanded(
                child: WidgetScroll(
              child: Row(
                children:
                    images.map((imageUrl) => Image.network(imageUrl)).toList(),
              ),
            )),
            Expanded(
                child: WidgetScroll(
              scrollDirection: Axis.vertical,
              speedFactor: 40,
              child: Column(
                  children: images
                      .map((imageUrl) => Image.network(imageUrl))
                      .toList()),
            )),
          ],
        ),
      ),
    );
  }
}
