import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MarkedCardsScreen extends HookConsumerWidget {
  const MarkedCardsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Marked Cards'),
      ),
    );
  }
}
