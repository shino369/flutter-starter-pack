import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/configs/app_configs.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _hasError;

  @override
  void initState() {
    _loadItem();
    super.initState();
  }

  void _loadItem() async {
    try {
    final url = Uri.https(
        AppConfigs.baseUrl,
        'shopping-list.json');
    final res = await http.get(url);
    // print(res);

    if (res.statusCode > 400) {
      _hasError = 'Error occured';
      throw const HttpException('error');
    }

    if(res.body == 'null') {
      setState(() {
        _isLoading = false;
      });

      return;
    }

    final Map<String, dynamic> listDate = json.decode(res.body);
    final List<GroceryItem> loadedItem = [];
    for (var item in listDate.entries) {
      loadedItem.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: categories.entries
              .firstWhere((cat) => cat.value.title == item.value['category'])
              .value,
        ),
      );

      setState(() {
        _groceryItems = loadedItem;
        _isLoading = false;
      });
    }
    } catch (err) {
      setState(() {
        _hasError = 'something went wrong';
      });
    }

  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
        AppConfigs.baseUrl,
        'shopping-list/${item.id}.json');

    final res = await http.delete(url);
    if (res.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(_hasError!=null){
      content =  Center(
        child: Text(_hasError!),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,

      //      FutureBuilder(
      //   future: _loadedItem,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text(snapshot.error.toString()),
      //       );
      //     }

      //     if (snapshot.data!.isEmpty) {
      //       return const Center(child: Text('No items added yet.'));
      //     }

      //     return ListView.builder(
      //       itemCount: snapshot.data!.length,
      //       itemBuilder: (ctx, index) => Dismissible(
      //         onDismissed: (direction) {
      //           _removeItem(snapshot.data![index]);
      //         },
      //         key: ValueKey(snapshot.data![index].id),
      //         child: ListTile(
      //           title: Text(snapshot.data![index].name),
      //           leading: Container(
      //             width: 24,
      //             height: 24,
      //             color: snapshot.data![index].category.color,
      //           ),
      //           trailing: Text(
      //             snapshot.data![index].quantity.toString(),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
