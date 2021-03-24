import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatefulWidget {
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  MainDrawer(this.saveFilters, this.currentFilters);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String description, bool currentValue, Function update) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: update);
  }

  Widget buildListTile(String title, IconData iconData, Function tapHandler) {
    return ListTile(
        leading: Icon(
          iconData,
          size: 26,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'RobotoCondenced',
              fontSize: 24,
              fontWeight: FontWeight.w700),
        ),
        onTap: tapHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          Expanded(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    "Filters:",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                _buildSwitchListTile(
                    'Gluten Free',
                    'select only gluten free receipts',
                    _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose Free',
                    'select only Lactose free receipts',
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile('Vegetarian',
                    'select only vegetarian receipts', _vegetarian, (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'select only vegan receipts', _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                ElevatedButton(
                  onPressed: () {
                    final selectedFilters = {
                      'gluten': _glutenFree,
                      'lactose': _lactoseFree,
                      'vegan': _vegan,
                      'vegetarian': _vegetarian
                    };
                    widget.saveFilters(selectedFilters);
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: Row(children: <Widget>[
                    Icon(Icons.filter_alt, size: 20),
                    Text(
                      "Apply filter",
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
