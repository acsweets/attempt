
import 'package:flutter/material.dart';

class CardStack extends StatefulWidget {
  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  int _currentIndex = 0;
  final List<Color> _cardColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  void _showNextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _cardColors.length;
    });
  }

  void _showPreviousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _cardColors.length) % _cardColors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            // 右滑切换下一张
            _showNextCard();
          } else if (details.primaryVelocity! > 0) {
            // 左滑切换上一张
            _showPreviousCard();
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(_cardColors.length, (index) {
            return AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: index == _currentIndex ? 0 : 50,
              right: index == _currentIndex ? 0 : 50,
              top: index == _currentIndex ? 0 : 20,
              bottom: index == _currentIndex ? 0 : 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: index == _currentIndex ? 1.0 : 0.5,
                child: Card(
                  color: _cardColors[index],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: SizedBox(
                    width: 250,
                    height: 400,
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
          }),
        ),
      ),
    );
  }
}
