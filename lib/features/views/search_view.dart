import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const name = 'search_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
    );
  }
}
