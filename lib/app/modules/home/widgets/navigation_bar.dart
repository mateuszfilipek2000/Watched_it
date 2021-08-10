import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watched_it_getx/app/modules/home/controllers/nav_bar_controller.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return GetX<NavBarController>(
      init: NavBarController(amountOfNavBarTabs: 4),
      builder: (_) {
        return Container(
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF151515),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < _.amountOfNavBarTabs; i++)
                Expanded(
                  child: NavigationBarTile(
                    icon: _.icons[i],
                    size: 30.0,
                    id: i,
                    onTap: _.changeActivePage,
                    color: _.activePageIndex == i ? Colors.blue : Colors.grey,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class NavigationBarTile extends StatelessWidget {
  const NavigationBarTile({
    Key? key,
    required this.icon,
    required this.size,
    required this.id,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final int id;
  final Function(int) onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => this.onTap(id),
      child: Icon(
        this.icon,
        size: this.size,
        color: this.color,
      ),
    );
  }
}
