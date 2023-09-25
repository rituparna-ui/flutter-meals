import 'package:flutter/material.dart';

class AnimScreen extends StatefulWidget {
  const AnimScreen({super.key});

  @override
  State<AnimScreen> createState() => _AnimScreenState();
}

class _AnimScreenState extends State<AnimScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kek'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          child: const Text('HueHue'),
          builder: (context, child) {
            return Container(
              height: _animationController.value * 50,
              color: Color.fromRGBO(0, 150, 136, _animationController.value),
              width: _animationController.value * 50,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
