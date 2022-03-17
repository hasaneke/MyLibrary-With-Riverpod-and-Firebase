import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/providers/categories_notifier.dart';
import 'package:my_library/presentation/home/tab_bar_page/home_page/widgets/drawer/my_drawer.dart';
import 'package:my_library/presentation/widgets/my_category_gridview.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.lime[50],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ref.read(categoriesNotifier.notifier).addCategory(
                      myCategory: MyCategory(
                    uniqueId: const Uuid().v1(),
                    colorCode: Colors.yellow.value,
                    title: 'titleXX',
                  ));
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final mainCategories = ref.watch(mainCategoriesProvider);
          return mainCategories.isEmpty
              ? const Center(
                  child: Text('Empty'),
                )
              : MyCategoryGridView(mainCategories);
        },
      ),
      drawer: const MyDrawer(),
    );
  }
}
