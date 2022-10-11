import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function(Map<String, bool>) saveFilters;
  Map<String, bool> currentFilter = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  FiltersScreen(this.currentFilter, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _gluttenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _gluttenFree = widget.currentFilter['gluten'] as bool;
    _vegetarian = widget.currentFilter['vegetarian'] as bool;
    _vegan = widget.currentFilter['vegan'] as bool;
    _lactoseFree = widget.currentFilter['lactose'] as bool;
    super.initState();
  }

  Widget _buildSwitchTile(
    String title, 
    String subtitle, 
    bool currentValue, 
    Function(bool) updateValue
  ) {
    return  SwitchListTile(
        value: currentValue, 
        title: Text(title),
        subtitle: Text(subtitle),
        onChanged: updateValue
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () { 
              final filters = {
                'gluten': _gluttenFree,
                'lactose': _lactoseFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
              };
              widget.saveFilters(filters);
            }, 
            icon: Icon(Icons.save)
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchTile(
                  'Gluten-free', 
                  'Only include gluten-free meals', 
                  _gluttenFree, 
                  (newVal) {
                    setState(() {
                      _gluttenFree = newVal;
                    });
                  }
                ),
                _buildSwitchTile(
                  'Vegetarian', 
                  'Only include Vegetarian meals', 
                  _vegetarian, 
                  (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  }
                ),
                _buildSwitchTile(
                  'Vegan', 
                  'Only include vegan meals', 
                  _vegan, 
                  (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  }
                ),
                _buildSwitchTile(
                  'Lactose-free', 
                  'Only include lactose-free meals', 
                  _lactoseFree, 
                  (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  }
                )
              ],
            ) 
          )
        ],
      ),
    );
  }
}