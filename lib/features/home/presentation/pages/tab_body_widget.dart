import 'package:flutter/material.dart';
import 'package:mobile/features/category/models/category_model.dart';

class TabBodyWidget extends StatefulWidget {
  const TabBodyWidget({super.key, required this.model});
  final CategoryModel model;
  @override
  State<TabBodyWidget> createState() => _TabBodyWidgetState();
}

class _TabBodyWidgetState extends State<TabBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text(widget.model.nameTm));
      },
    );
  }
}
