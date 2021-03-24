import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import '../widgets/meal_item.dart';
class CategoryScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;
  CategoryScreen(this.availableMeals);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedInitData = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
    final routeArgs =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
