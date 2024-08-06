import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_books_online/constants/api_endpoints.dart';
import 'package:read_books_online/constants/styles.dart';
import 'package:read_books_online/presentation/widgets/home_book_details_screen.dart';
import 'package:read_books_online/service/home_book_provider.dart';

class CustomHomeTile extends StatelessWidget {
  final int index;
  const CustomHomeTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBookProvider>(
        builder: (BuildContext context, value, Widget? child) {
      String? title = value.homeBooks?.items![index].volumeInfo?.title;
      String? authors =
          value.homeBooks?.items![index].volumeInfo?.authors.toString();
      String? imgUrl =
          value.homeBooks?.items![index].volumeInfo!.imageLinks?.thumbnail;
      title ??= "Title Unavailable";
      authors ??= "Authors Unavailable";
      imgUrl ??= imgNotAvailable;
      return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeBookDetailsScreen(
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
