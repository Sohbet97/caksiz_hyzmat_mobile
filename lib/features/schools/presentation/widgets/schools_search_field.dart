import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/generated/l10n.dart';

class SchoolsSearchField extends StatefulWidget {
  const SchoolsSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<SchoolsSearchField> createState() => _SchoolsSearchFieldState();
}

class _SchoolsSearchFieldState extends State<SchoolsSearchField> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      widget.onChanged(value.trim());
    });
  }

  void _onClear() {
    _debounce?.cancel();
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          onChanged: _onChanged,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: S.of(context).searchSchoolsHint,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: value.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _onClear,
                  ),
          ),
        );
      },
    );
  }
}
