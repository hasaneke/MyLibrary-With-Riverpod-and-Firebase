// ignore_for_file: unused_import

import 'package:data_service/exceptions/data_exception.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/state_providers/expection_providers.dart';
import 'package:my_library/presentation/widgets/add_category_dialog.dart';
import 'package:my_library/presentation/widgets/my_app_bar/my_app_bar.dart';
import 'package:my_library/presentation/widgets/my_category_gridview.dart';
import 'package:my_library/product/widgets/drawer/my_drawer.dart';

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
      appBar: MyAppBar(
        title: Center(
          child: SizedBox(
              height: 45,
              width: 45,
              child: Image.asset('assets/icon_white.png')),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_to_photos_outlined,
              size: 30,
            ),
            onPressed: () {
              showDialog(context: context, builder: (_) => AddCategoryDialog());
            },
          ),
        ],
      ),
      body: MyCategoryGridView(),
      drawer: const MyDrawer(),
    );
  }
}
