// anim_search_bar statefull widget
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class Search_Bar extends SearchDelegate {
  final List<String> listExample;
  Search_Bar({required this.listExample});

  // change search textfield hint text
  @override
  String get searchFieldLabel => 'Pesquisar...';

  // change search textfield text color
  @override
  TextStyle get searchFieldStyle => const TextStyle(color: greenUfcat);

  // Change appbar color to greenUfcat
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        color: greenUfcat,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Color.fromARGB(157, 41, 121, 124)),
        // border radius
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(FontAwesomeIcons.xmark),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(FontAwesomeIcons.arrowLeft),
      onPressed: () {
        close(context, '');
      },
    );
  }

  // TODO: change search result list
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: grayUfcat,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? listExample
        : listExample
            .where((element) => element.toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
        tileColor: Colors.white,
        leading: const Icon(
          FontAwesomeIcons.clockRotateLeft,
          size: 20,
        ),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
              color: Colors.black.withOpacity(0.15),
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
