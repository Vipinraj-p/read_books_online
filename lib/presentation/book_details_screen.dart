import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_books_online/constants/api_endpoints.dart';
import 'package:read_books_online/constants/styles.dart';
import 'package:read_books_online/service/search_books_provider.dart';

class BookDetailsScreen extends StatelessWidget {
  final int index;
  const BookDetailsScreen({super.key, required this.index});

  get imageNotAvailable => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SearchBooksProvider>(
      builder:
          (BuildContext context, SearchBooksProvider value, Widget? child) {
        var data = value.searchingBooks!.items![index].volumeInfo!;
        String? imgUrl = value
            .searchingBooks?.items![index].volumeInfo!.imageLinks?.thumbnail;
        imgUrl ??= imgNotAvailable;
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              data.title ?? "unavailable",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                SizedBox(
                  width: size.width,
                  height: 250,
                  child: Image.network(imgUrl),
                ),
                const SizedBox(height: 10),
                const CustomText(
                    text: "Description", fs: 18, fw: FontWeight.w600),
                const SizedBox(height: 8),
                CustomText(
                  text: data.description ?? "discription not available",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
