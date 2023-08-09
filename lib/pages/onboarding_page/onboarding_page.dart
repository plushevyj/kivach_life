import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HelloOnboardingPage extends StatelessWidget {
  HelloOnboardingPage({super.key});

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageController,
          children: [
            Container(
              color: Colors.red,
              child: const Center(child: Text('Page 1')),
            ),
            Container(
              color: Colors.indigo,
              child: const Center(child: Text('Page 2')),
            ),
            Container(
              color: Colors.green,
              child: const Center(child: Text('Page 3')),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {}, child: Text('Далее')),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
              ),
            ),
            TextButton(onPressed: () {}, child: Text('Пропустить')),
          ],
        ),
      ),
    );
  }
}
