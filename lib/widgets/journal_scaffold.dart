import 'package:flutter/material.dart';

Widget journalScaffold({required GlobalKey<ScaffoldState> key, required String title, required Widget body, Widget? floatingActionButton}) {
  return Scaffold(
    key: key,
    appBar: AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () => key.currentState!.openEndDrawer(),
          icon: const Icon(Icons.settings)
        )
      ],
    ),
    body: body,
    floatingActionButton: floatingActionButton,
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
    )
  );
}