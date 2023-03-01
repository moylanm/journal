import 'package:flutter/material.dart';

Widget journalScaffold({required String title, required Widget body, Widget? floatingActionButton}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      actions: [
        Builder(builder: ((context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.settings)
            );
          })
        )
      ],
    ),
    body: body,
    endDrawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text('Settings')
          ),
          Switch(
            value: false,
            onChanged: (value) async {
              // figure this out
            },
          )
        ],
      ),
    ),
    floatingActionButton: floatingActionButton
  );
}