import 'package:flex_drive/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.currentRoute,
  });

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'FlexDrive',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            _DrawerItem(
              title: 'Cars',
              icon: Icons.directions_car_rounded,
              routeName: AppRoutes.home,
              currentRoute: currentRoute,
            ),
            _DrawerItem(
              title: 'Details',
              icon: Icons.info_outline_rounded,
              routeName: AppRoutes.details,
              currentRoute: currentRoute,
            ),
            _DrawerItem(
              title: 'Settings',
              icon: Icons.tune_rounded,
              routeName: AppRoutes.settings,
              currentRoute: currentRoute,
            ),
            _DrawerItem(
              title: 'About',
              icon: Icons.person_outline_rounded,
              routeName: AppRoutes.about,
              currentRoute: currentRoute,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.routeName,
    required this.currentRoute,
  });

  final String title;
  final IconData icon;
  final String routeName;
  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    final selected = currentRoute == routeName;

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      onTap: () {
        Navigator.pop(context);
        if (!selected) {
          Navigator.pushReplacementNamed(context, routeName);
        }
      },
    );
  }
}
