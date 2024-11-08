import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    Color color;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second Screen Lukman'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            child: const Text('Pink'),
            onPressed: () {
              color = const Color.fromARGB(255, 255, 0, 191);
              Navigator.pop(context, color);
            },
          ),
          ElevatedButton(
            child: const Text('Cyan'),
            onPressed: () {
              color = const Color.fromARGB(255, 0, 225, 255);
              Navigator.pop(context, color);
            },
          ),
          ElevatedButton(
            child: const Text('Purple'),
            onPressed: () {
              color = const Color.fromARGB(255, 255, 0, 255);
              Navigator.pop(context, color);
            },
          ),
        ],
      )),
    );
  }
}
