import 'package:crypto_flutter/presentation/ui/profile_page.dart';
import 'package:crypto_flutter/presentation/ui/ui_helper/bottom_nav.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'market_view_page.dart';


class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => {},
        child: const Icon(Icons.compare_arrows_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(pageController: _myPage,),
      body: PageView(
        controller: _myPage,
        children: const [HomePage(), MarketViewPage(), ProfilePage()],
      ),
    );
  }
}
