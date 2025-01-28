import 'package:flutter/material.dart';

AppBar commonAppBar = AppBar(
    leading: const Icon(Icons.menu),
    title: const Text(
      'Ethio-Gpt',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    actions: const [
      Icon(Icons.abc),
      SizedBox(
        width: 10,
      )
    ]);
