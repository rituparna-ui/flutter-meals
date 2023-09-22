import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> favourites = [];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _selectScreen(String screen) {
    // Close the drawer
    Navigator.of(context).pop();
    if (screen == 'filters') {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const FiltersScreen();
      }));
    }
  }

  void _toggleFavouriteMeal(Meal meal) {
    final isPresent = favourites.contains(meal);

    setState(() {
      if (isPresent) {
        favourites.remove(meal);
        _showSnackBar('Meal removed from favourites');
      } else {
        favourites.add(meal);
        _showSnackBar('Meal added to favourites');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      toggleFavouriteMeal: _toggleFavouriteMeal,
    );
    String activePageTitle = 'Pick your Category';

    if (_selectedPageIndex == 0) {
      setState(() {
        activePage = CategoriesScreen(
          toggleFavouriteMeal: _toggleFavouriteMeal,
        );
        activePageTitle = 'Pick your Category';
      });
    } else {
      setState(() {
        activePage = MealsScreen(
          meals: favourites,
          toggleFavouriteMeal: _toggleFavouriteMeal,
        );
        activePageTitle = 'Favourites';
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: bottomNavigationBar(),
      drawer: MainDrawer(onSelectScreen: _selectScreen),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: _selectPage,
      currentIndex: _selectedPageIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.lunch_dining),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourites',
        ),
      ],
    );
  }
}
