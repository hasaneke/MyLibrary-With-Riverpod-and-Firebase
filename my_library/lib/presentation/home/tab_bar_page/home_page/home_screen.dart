import 'package:data_service/exceptions/data_exception.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/data/models/my_card.dart';
import 'package:my_library/data/models/my_category.dart';
import 'package:my_library/logic/providers/notifiers/cards_notifier.dart';
import 'package:my_library/logic/providers/notifiers/categories_notifier.dart';
import 'package:my_library/logic/providers/state_providers/expection_providers.dart';
import 'package:my_library/presentation/home/tab_bar_page/home_page/widgets/drawer/my_drawer.dart';
import 'package:my_library/presentation/widgets/my_category_gridview.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<DataException?>(dataExceptionProvider, (previous, exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exception!.toString()),
          duration: const Duration(seconds: 1),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.lime[50],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_to_photos_outlined,
              //color: context.theme.iconTheme.color,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: MyCategoryGridView(),
      drawer: const MyDrawer(),
    );
  }
}
