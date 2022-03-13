import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/presentation/home/tab_bar_page/home_page/widgets/drawer/my_drawer.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.lime[50],
        elevation: 0,
      ),
      body: const Center(
        child: Text('Home'),
      ),
      drawer: const MyDrawer(),
    );
  }
}
