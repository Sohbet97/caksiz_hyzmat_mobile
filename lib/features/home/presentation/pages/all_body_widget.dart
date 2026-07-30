import 'package:flutter/material.dart';

class AllBodyWidget extends StatefulWidget {
  const AllBodyWidget({super.key});

  @override
  State<AllBodyWidget> createState() => _AllBodyWidgetState();
}

class _AllBodyWidgetState extends State<AllBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text(index.toString()));
      },
    );
  }
}
