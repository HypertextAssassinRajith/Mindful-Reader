import 'package:flutter/material.dart';
import '../colors/color.dart';
import 'read.dart'; // Import the ReadBookScreen

class DetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String description;
  final String bookUrl; // Add the book URL

  const DetailsScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.description,
    required this.bookUrl, // Add the book URL to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 300,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/imgae_not.jpg',
                    fit: BoxFit.cover,
                    height: 300,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  // Navigate to the ReadBookScreen when the "Read" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReadBookScreen(bookUrl: bookUrl),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                    color: KFourthColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Read',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: KPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        color: KFourthColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        author,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          color: KPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
