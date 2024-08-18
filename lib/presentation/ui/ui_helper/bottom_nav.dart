import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNav extends StatelessWidget {
  PageController pageController;
  BottomNav({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => {
                      pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                    },
                    icon: const Icon(Icons.home),
                  ),
                  IconButton(
                    onPressed: () => {
                      pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                    },
                    icon: const Icon(Icons.bar_chart),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => {
                      pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                    },
                    icon: const Icon(Icons.person),
                  ),
                  IconButton(
                    onPressed: () => {
                      pageController.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                    },
                    icon: const Icon(Icons.bookmark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
