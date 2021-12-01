import 'package:flutter/material.dart';

import 'Card.dart';

class OverlappedCarousel extends StatefulWidget {
  final List<Widget> widgets;
  final Function onClicked;

  OverlappedCarousel({
    required this.widgets,
    required this.onClicked,
  });

  @override
  _OverlappedCarouselState createState() => _OverlappedCarouselState();
}

class _OverlappedCarouselState extends State<OverlappedCarousel> {
  late PageController _pageController;
  double currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex.toInt());
    _pageController.addListener(
      () {
        setState(() {
          currentIndex = _pageController.page ?? 0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: <Widget>[
              OverlappedCarouselCardItems(
                cards: List.generate(
                  widget.widgets.length,
                  (index) => CardModel(id: index, child: widget.widgets[index]),
                ),
                centerIndex: currentIndex,
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
                onClicked: widget.onClicked,
              ),
              Positioned.fill(
                child: PageView.builder(
                  itemCount: widget.widgets.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OverlappedCarouselCardItems extends StatelessWidget {
  final List<CardModel> cards;
  final Function? onClicked;
  final double centerIndex;
  final double maxHeight;
  final double maxWidth;

  OverlappedCarouselCardItems({
    required this.cards,
    // @required this.titles,
    required this.centerIndex,
    required this.maxHeight,
    required this.maxWidth,
    this.onClicked,
  });

  double getCardPosition(int index) {
    final double center = maxWidth / 2;
    final double centerWidgetWidth = maxWidth / 4;
    final double basePosition = center - centerWidgetWidth / 2;
    final distance = centerIndex - index;

    final double nearWidgetWidth = centerWidgetWidth / 5 * 4;
    final double farWidgetWidth = centerWidgetWidth / 5 * 3;

    if (distance == 0) {
      return basePosition;
    } else if (distance.abs() > 0.0 && distance.abs() <= 1.0) {
      if (distance > 0) {
        return basePosition - nearWidgetWidth * distance.abs();
      } else {
        return basePosition + centerWidgetWidth * distance.abs();
      }
    } else if (distance.abs() >= 1.0 && distance.abs() <= 2.0) {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2) -
            (nearWidgetWidth - farWidgetWidth) *
                ((distance - distance.floor()));
      }
    } else {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2);
      }
    }
  }

  double getCardWidth(int index) {
    final double distance = (centerIndex - index).abs();
    final double centerWidgetWidth = maxWidth / 3.5;
    final double nearWidgetWidth = centerWidgetWidth / 5 * 4.5;
    final double farWidgetWidth = centerWidgetWidth / 5 * 3.5;

    if (distance >= 0.0 && distance < 1.0) {
      return centerWidgetWidth -
          (centerWidgetWidth - nearWidgetWidth) * (distance - distance.floor());
    } else if (distance >= 1.0 && distance < 2.0) {
      return nearWidgetWidth -
          (nearWidgetWidth - farWidgetWidth) * (distance - distance.floor());
    } else {
      return farWidgetWidth;
    }
  }

  Matrix4 getTransform(int index) {
    final distance = centerIndex - index;

    return Matrix4.identity()
      ..setEntry(3, 2, 0.007)
      ..rotateY(-0.2 * distance)
      ..scale(1.1);
  }

  Widget _buildItem(CardModel item) {
    final int index = item.id;
    final width = getCardWidth(index);
    final height = maxHeight - 20 * (centerIndex - index).abs();
    final position = getCardPosition(index);
    final verticalPadding = 10 * (centerIndex - index).abs();

    return Positioned(
      left: position,
      child: Transform(
        transform: getTransform(index),
        alignment: FractionalOffset.center,
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                width: width.toDouble(),
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                height: height > 0 ? height : 0,
                child: item.child,
              ),
              // if (titles != null && !displayOnlyCenterTitle) _buildTitle(index),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _sortedStackWidgets(List<CardModel> widgets) {
    for (int i = 0; i < widgets.length; i++) {
      if (widgets[i].id == centerIndex) {
        widgets[i].zIndex = widgets.length.toDouble();
      } else if (widgets[i].id < centerIndex) {
        widgets[i].zIndex = widgets[i].id.toDouble();
      } else {
        widgets[i].zIndex =
            widgets.length.toDouble() - widgets[i].id.toDouble();
      }
    }
    widgets.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return widgets.map((e) => _buildItem(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: _sortedStackWidgets(cards),
      ),
    );
  }
}
