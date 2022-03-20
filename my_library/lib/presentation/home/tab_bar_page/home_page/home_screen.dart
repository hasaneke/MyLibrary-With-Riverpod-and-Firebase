// ignore_for_file: unused_import

import 'package:data_service/exceptions/data_exception.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_library/logic/providers/state_providers/expection_providers.dart';
import 'package:my_library/presentation/home/tab_bar_page/home_page/widgets/drawer/my_drawer.dart';
import 'package:my_library/presentation/widgets/add_category_dialog.dart';
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
        title: Center(
          child: SizedBox(
              height: 45,
              width: 45,
              child: Image.asset('assets/my_library_icon.png')),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_to_photos_outlined,
              color: Theme.of(context).iconTheme.color,
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
