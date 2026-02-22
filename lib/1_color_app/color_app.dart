import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Home()),
      ),
    ),
  );
}

enum CardType { red, blue, green, yellow }

class ColorService extends ChangeNotifier {
  int currentIndex = 0;

  final Map<CardType, int> tapCounts = {
    for (var type in CardType.values) type: 0,
  };

  void onTap(CardType type) {
    tapCounts[type] = tapCounts[type]! + 1;
    notifyListeners();
  }

  void onTabChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Color getColorForType(CardType type) {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.blue:
        return Colors.blue;
      case CardType.green:
        return Colors.green;
      case CardType.yellow:
        return Colors.yellow;
    }
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final colorService = Provider.of<ColorService>(context);

    return Scaffold(
      body: colorService.currentIndex == 0
          ? ColorTapsScreen()
          : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: colorService.currentIndex,
        onTap: (index) {
          colorService.onTabChange(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
          children: CardType.values
            .map((type) => ColorTap(type: type))
            .toList(),
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final colorService = context.watch<ColorService>();
    final tapCount = colorService.tapCounts[type] ?? 0;

    return GestureDetector(
      onTap: () => colorService.onTap(type),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorService.getColorForType(type),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorService = context.watch<ColorService>();

    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  CardType.values
              .map(
                (card) => Text(
                  '${card.name} Taps: ${colorService.tapCounts[card] ?? 0}',
                  style: TextStyle(fontSize: 24),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
