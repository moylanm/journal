import 'package:flutter/material.dart';
import 'package:journal/widgets/end_drawer.dart';

class JournalScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  const JournalScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton
  });

  @override
  Widget build(BuildContext context) {
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
    endDrawer: const EndDrawer(),
    floatingActionButton: floatingActionButton
  );
  }
}