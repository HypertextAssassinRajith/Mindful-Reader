import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mindful_reader/src/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../colors/color.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  List<String> categories = [];
  bool isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _fetchCategories();
  }

    Future<void> _checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token == null || token.isEmpty) {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    // );
  }
  else {
    _isLoggedIn = true;
  }
}

  // Fetch categories from the API
  Future<void> _fetchCategories() async {
    await dotenv.load(fileName: "assets/config/.env");
    try {
      var response = await Dio().get('${dotenv.env['API_BASE_URL']}/categorie/categories');
      setState(() {
        categories = List<String>.from(response.data.map((item) => item['name']));
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching categories: $error');
      if (_isLoggedIn) {
          setState(() {
            isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  // Handle category tap
                  print('Selected Category: $category');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                    color: KFourthColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: KPrimaryColor,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
