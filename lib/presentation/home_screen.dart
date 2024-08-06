import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:read_books_online/constants/styles.dart';
import 'package:read_books_online/presentation/login_screen.dart';
import 'package:read_books_online/presentation/widgets/custom_home_tile.dart';
import 'package:read_books_online/service/home_book_provider.dart';
import 'package:read_books_online/service/search_books_provider.dart';
import 'package:read_books_online/service/search_button_provider.dart';
import 'searched_books.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeBookProvider>(context, listen: false).fetchBooks("fiction");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    Size size = MediaQuery.of(context).size;
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      drawer: NavigationDrawer(
          backgroundColor: Colors.black,
          indicatorColor: kwhiteColor,
          children: [
            const DrawerHeader(
                child: CircleAvatar(
              backgroundColor: Colors.white30,
            )),
            ListTile(
              onTap: () => FirebaseAuth.instance.signOut().then(
                (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
              ),
              leading:
                  const Icon(Icons.follow_the_signs_sharp, color: kwhiteColor),
              title: Text(
                "SignOut",
                style: customtextstyle,
              ),
            )
          ]),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Book Shelf",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Consumer<SearchButtonProvider>(
              builder: (context, Buttonvalue, child) => IconButton(
                  onPressed: () {
                    Buttonvalue.onbuttontap();
                  },
                  icon: const Icon(
                    CupertinoIcons.search,
                    color: kwhiteColor,
                    size: 30,
                  )),
            ),
            Consumer<HomeBookProvider>(
                builder: (context, homeBookValue, child) {
              return SizedBox(
                width: 120,
                child: DropdownButton(
                    isExpanded: true,
                    dropdownColor: Colors.black,
                    value: homeBookValue.dropdownValue,
                    borderRadius: BorderRadius.circular(10),
                    items: [
                      DropdownMenuItem<int>(
                        value: 0,
                        onTap: () {
                          setState(() {
                            homeBookValue.dropdownValue = 0;
                          });
                        },
                        child: const CustomText(text: "Fiction"),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        enabled: true,
                        onTap: () {
                          setState(() {
                            homeBookValue.dropdownValue = 1;
                          });
                        },
                        child: const CustomText(text: "Non-Fiction"),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        onTap: () {
                          setState(() {
                            homeBookValue.dropdownValue = 2;
                          });
                        },
                        child: const CustomText(text: "Science"),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        onTap: () {
                          setState(() {
                            homeBookValue.dropdownValue = 3;
                          });
                        },
                        child: const CustomText(text: "History"),
                      ),
                    ],
                    onChanged: (value) {
                      index = int.parse(value.toString());
                      log(index.toString());
                      homeBookValue.refreshHome(index);
                    }),
              );
            })
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<SearchButtonProvider>(
                  builder: (context, value, child) {
                return value.istapped
                    ? Center(
                        child: Consumer<SearchBooksProvider>(builder:
                            (BuildContext context, searchValue, Widget? child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.3)),
                            height: 40,
                            width: size.width <= 756 ? size.width * .8 : 600,
                            child: TextFormField(
                              controller: searchController,
                              onEditingComplete: () {
                                searchValue.refreshQuery(searchController.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchedBooks(
                                        searchData: searchController.text,
                                      ),
                                    ));
                              },
                              style: GoogleFonts.ubuntuCondensed(
                                  color: Colors.white, fontSize: 14),
                              autofocus: true,
                              enableSuggestions: true,
                              cursorColor: Colors.white,
                              decoration: const InputDecoration(
                                  hoverColor: Colors.white,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white60),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white60),
                                  )),
                            ),
                          );
                        }),
                      )
                    : const SizedBox(
                        height: 30, //40
                      );
              }),
            ),
            ListView.separated(
              itemBuilder: (context, index) {
                return CustomHomeTile(
                  index: index,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }
}
