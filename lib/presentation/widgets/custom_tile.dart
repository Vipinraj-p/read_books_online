import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_books_online/constants/api_endpoints.dart';
import 'package:read_books_online/constants/styles.dart';
import 'package:read_books_online/presentation/book_details_screen.dart';
import 'package:read_books_online/service/search_books_provider.dart';

class CustomTile extends StatelessWidget {
  final int index;
  const CustomTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBooksProvider>(
        builder: (BuildContext context, value, Widget? child) {
      String? title = value.searchingBooks?.items![index].volumeInfo?.title;
      String? authors =
          value.searchingBooks?.items![index].volumeInfo?.authors.toString();
      String? imgUrl =
          value.searchingBooks?.items![index].volumeInfo!.imageLinks?.thumbnail;
      title ??= "Title Unavailable";
      authors ??= "Authors Unavailable";
      imgUrl ??= imgNotAvailable;
      return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsScreen(
                index: index,
              ),
            )),
        child: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              value.isLoading
                  ? Container(
                      width: 137,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(imgUrl))),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : Container(
                      width: 137,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(imgUrl))),
                    ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(text: title, fs: 18, fw: FontWeight.w600),
                    CustomText(text: authors, fs: 14, fw: FontWeight.w400),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
