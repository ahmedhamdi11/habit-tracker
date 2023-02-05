import 'package:flutter/material.dart';

class MyFab extends StatelessWidget {
  final Function()? onPressed;
   const MyFab({super.key,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.add),
    );
  }
}
