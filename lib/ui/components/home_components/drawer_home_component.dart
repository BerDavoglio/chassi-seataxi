import 'package:flutter/material.dart';

import '../../ui.dart';

Drawer homeDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Menu B1K3',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        ListTile(
          title: const Text('Home'),
          leading: const Icon(Icons.home_outlined),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.HOME);
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.exit_to_app),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.LOGIN);
          },
        ),
      ],
    ),
  );
}