import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Map<Filter, bool> selectedFilers = kInitialFilters;

  void _selectScreen(String screen) async {
    // Close the drawer
    Navigator.of(context).pop();
    if (screen == 'filters') {
      final filters = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) {
            return const FiltersScreen();
          },
        ),
      );
      setState(() {
        selectedFilers = filters!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final avaiableMeals = meals.where((meal) {
      if (selectedFilers[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilers[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilers[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilers[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: avaiableMeals,
    );
    String activePageTitle = 'Pick your Category';

    if (_selectedPageIndex == 0) {
      setState(() {
        activePage = CategoriesScreen(
          availableMeals: avaiableMeals,
        );
        activePageTitle = 'Pick your Category';
      });
    } else {
      setState(() {
        activePage = MealsScreen(
          meals: ref.watch(favMealsProvider),
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
