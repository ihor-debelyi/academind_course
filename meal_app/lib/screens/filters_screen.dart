// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:meal_app/widgets/main_drawer.dart';

import '../models/filters.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Filters currentFilters;
  final Function saveFilters;
  const FiltersScreen(this.currentFilters, this.saveFilters, {Key? key})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final _filters = Filters();

  @override
  void initState() {
    super.initState();
    _filters.glutenFree = widget.currentFilters.glutenFree;
    _filters.lactoseFree = widget.currentFilters.lactoseFree;
    _filters.vegan = widget.currentFilters.vegan;
    _filters.vegetarian = widget.currentFilters.vegetarian;
  }

  Widget _buildSwitch(
      bool switchValue, String title, String subtitle, Function updateValue) {
    return SwitchListTile(
      value: switchValue,
      onChanged: (newValue) => updateValue(newValue),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                widget.saveFilters(_filters);
                Fluttertoast.showToast(
                    msg: "Filters saved",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _filters.glutenFree = false;
                _filters.lactoseFree = false;
                _filters.vegan = false;
                _filters.vegetarian = false;
              });
            },
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitch(
                  _filters.glutenFree,
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  (newValue) => setState(() {
                    _filters.glutenFree = newValue;
                  }),
                ),
                _buildSwitch(
                  _filters.vegetarian,
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  (newValue) => setState(() {
                    _filters.vegetarian = newValue;
                  }),
                ),
                _buildSwitch(
                  _filters.vegan,
                  'Vegan',
                  'Only include vegan meals.',
                  (newValue) => setState(() {
                    _filters.vegan = newValue;
                  }),
                ),
                _buildSwitch(
                  _filters.lactoseFree,
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  (newValue) => setState(() {
                    _filters.lactoseFree = newValue;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
