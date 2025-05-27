import 'package:coinswitch/screen/home.dart';
import 'package:coinswitch/screen/market.dart';
import 'package:coinswitch/screen/swap.dart';
import 'package:coinswitch/service/mnemonic.dart';
import 'package:coinswitch/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final String mnemonic;
  const NavBar({super.key, required this.mnemonic});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final userMnemonic userAssetMnemonic = userMnemonic();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  int _currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const Home_Screen(),
      const Market(),
      const SwapAsset(),
      // BitcoinTransactionScreen()
    ];
    var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: pages.elementAt(_currentScreen),
      // backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.backgroundColor,
        ),
        child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _currentScreen,
            backgroundColor: AppColors.backgroundColor,
            type: BottomNavigationBarType.fixed,
            onTap: ((value) {
              setState(() {
                _currentScreen = value;
              });
            }),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                  size: height * 0.03,
                  color: AppColors.colorGrey,
                ),
                label: 'Home',
                activeIcon: Icon(
                  Icons.home_rounded,
                  size: height * 0.03,
                  color: AppColors.brandColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bar_chart_rounded,
                  size: height * 0.03,
                  color: AppColors.colorGrey,
                ),
                label: '',
                activeIcon: Icon(
                  Icons.bar_chart_rounded,
                  size: height * 0.03,
                  color: AppColors.brandColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.swap_horiz_rounded,
                  size: height * 0.03,
                  color: AppColors.colorGrey,
                ),
                label: '',
                activeIcon: Icon(
                  Icons.swap_horiz_rounded,
                  size: height * 0.03,
                  color: AppColors.brandColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  size: height * 0.03,
                  color: AppColors.colorGrey,
                ),
                label: '',
                activeIcon: Icon(
                  Icons.history,
                  size: height * 0.03,
                  color: AppColors.brandColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_rounded,
                  size: height * 0.03,
                  color: AppColors.colorGrey,
                ),
                label: '',
                activeIcon: Icon(
                  Icons.settings_rounded,
                  size: height * 0.03,
                  color: AppColors.brandColor,
                ),
              )
            ]),
      ),
    );
  }
}
