import 'package:flutter/material.dart';


class CardPageView extends StatefulWidget {
  @override
  _CardPageViewState createState() => _CardPageViewState();
}

class _CardPageViewState extends State<CardPageView> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final List<Color> _cardColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];
  double _startDragX = 0.0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          _startDragX = details.globalPosition.dx;
        },
        onHorizontalDragEnd: (details) {
          double endDragX = details.primaryVelocity ?? 0;
          if (endDragX < -100) {
            // 向左拖动切换下一页
            if (_currentIndex < _cardColors.length - 1) {
              _currentIndex++;
              _pageController.animateToPage(
                _currentIndex,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          } else if (endDragX > 100) {
            // 向右拖动切换上一页
            if (_currentIndex > 0) {
              _currentIndex--;
              _pageController.animateToPage(
                _currentIndex,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        child: SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _cardColors.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }

                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) * 400,
                      width: Curves.easeOut.transform(value) * 250,
                      child: child,
                    ),
                  );
                },
                child: Card(
                  color: _cardColors[index],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      'Card ${index + 1}',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


class CardStackPageView extends StatefulWidget {
  const CardStackPageView({super.key});

  @override
   createState() => _CardStackPageViewState();
}

class _CardStackPageViewState extends State<CardStackPageView> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final List<Color> _cardColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _cardColors.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double value = 1.0;
                if (_pageController.position.haveDimensions) {
                  value = _pageController.page! - index;
                  value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                }

                return Transform.translate(
                  offset: Offset(-20 * value, 0), // 控制水平堆叠偏移量
                  child: Transform.scale(
                    scale: value * 0.9 + 0.1, // 控制缩放比例
                    child: Opacity(
                      opacity: value.clamp(0.5, 1.0),
                      child: Card(
                        color: _cardColors[index],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Center(
                          child: Text(
                            'Card ${index + 1}',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}