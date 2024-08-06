import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_books_online/presentation/widgets/custom_tile.dart';
import 'package:read_books_online/service/search_books_provider.dart';

class SearchedBooks extends StatefulWidget {
  final String searchData;
  const SearchedBooks({super.key, required this.searchData});

  @override
  State<SearchedBooks> createState() => _SearchedBooksState();
}

class _SearchedBooksState extends State<SearchedBooks> {
  @override
  void initState() {
    Provider.of<SearchBooksProvider>(context, listen: false)
        .fetchSearchBooks("");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SearchBooksProvider>(builder:
        (BuildContext context, SearchBooksProvider value, Widget? child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.searchData,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CustomTile(
                  index: index,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: value.searchingBooks!.items!.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
            ),
          ));
    });
  }
}
