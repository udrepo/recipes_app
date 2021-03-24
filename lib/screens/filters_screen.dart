import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;


  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
   initState(){
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
     super.initState();
   }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function update) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtered"),
      ),
      drawer: MainDrawer(widget.saveFilters, widget.currentFilters),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust selection',
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
              ),
            ),
            Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildSwitchListTile(
                        'Gluten Free', 'select only gluten free receipts',
                        _glutenFree, (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    }),
                    _buildSwitchListTile(
                        'Lactose Free', 'select only Lactose free receipts',
                        _lactoseFree, (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    }),
                    _buildSwitchListTile(
                        'Vegetarian', 'select only vegetarian receipts',
                        _vegetarian, (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }),
                    _buildSwitchListTile(
                        'Vegan', 'select only vegan receipts', _vegan, (
                        newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    })
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          final selectedFilters = {
            'gluten': _glutenFree,
            'lactose': _lactoseFree,
            'vegan': _vegan,
            'vegetarian': _vegetarian
          };
          widget.saveFilters(selectedFilters);
        },
      ),
    );
  }
}
