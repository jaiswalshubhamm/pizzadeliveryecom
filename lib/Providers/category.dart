import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/Helpers/category.dart';
import 'package:pizzadeliveryecom/Models/category.dart';

class CategoryProvider with ChangeNotifier{
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];

  CategoryProvider.initialize(){
    _loadCategories();
  }
  
  _loadCategories() async {
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}