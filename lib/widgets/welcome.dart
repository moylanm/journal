import 'package:flutter/material.dart';

Widget welcome() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.collections_bookmark, size: 125.0),
        SizedBox(),
        Text('Journal', style: TextStyle(fontSize: 20))
      ],
    ),
  );
}