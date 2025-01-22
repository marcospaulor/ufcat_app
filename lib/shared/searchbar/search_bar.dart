import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ufcat_app/providers/firebase_api.dart';
import 'package:ufcat_app/shared/searchbar/result_screen.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class MySearchBar extends SearchDelegate {
  final int maxSearchHistory = 10;
  final BuildContext context;

  MySearchBar({required this.context});

  Future<List<String>> _getRecentSearches() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList('search_history')?.reversed.toList() ?? [];
  }

  @override
  String get searchFieldLabel => 'Pesquisar...';

  @override
  TextStyle? get searchFieldStyle => Theme.of(context).textTheme.labelLarge;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(FontAwesomeIcons.xmark),
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
          } else {
            close(context, null);
          }
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

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done ||
            snapshot.hasError) {
          return const Center(child: CircularProgressIndicator(color: orangeUfcat,));
        }
        return ResultScreen(query: query, data: snapshot.data ?? []);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(color: orangeUfcat,));
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados'));
        }

        final bool isQueryEmpty = query.isEmpty;

        return FutureBuilder<List<String>>(
          future: _getRecentSearches(),
          builder: (context, recentSearchesSnapshot) {
            if (recentSearchesSnapshot.connectionState !=
                ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            final recentSearches = recentSearchesSnapshot.data;

            final databaseList = snapshot.data!;
            final titles = databaseList
                .where((element) =>
                    element['title'] != null && element['title'] is String)
                .map<String>((element) => element['title'] as String)
                .toList();

            if (isQueryEmpty) {
              return _buildDefaultSuggestions(context, recentSearches, titles);
            } else {
              final filteredTitles = titles
                  .where((title) =>
                      title.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              final filteredRecentSearches = recentSearches
                  ?.where((element) =>
                      element.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              return _buildFilteredSuggestions(
                  context, filteredRecentSearches, filteredTitles);
            }
          },
        );
      },
    );
  }

  Widget _buildDefaultSuggestions(
      BuildContext context, List<String>? recentQueries, List<String> titles) {
    titles = titles.take(15).toList(); // Limitando para 15 elementos
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < recentQueries.length) {
          return ListTile(
            tileColor: Colors.white,
            onTap: () {
              query = recentQueries[index];
              showResults(context);
            },
            leading: const Icon(FontAwesomeIcons.clockRotateLeft),
            title: Text(
              recentQueries[index],
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.left,
            ),
          );
        } else {
          final databaseIndex = index - recentQueries.length;
          return ListTile(
            tileColor: Colors.white,
            onTap: () {
              query = titles[databaseIndex];
              showResults(context);
            },
            leading: const Icon(FontAwesomeIcons.magnifyingGlass),
            title: Text(
              titles[databaseIndex],
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.left,
            ),
          );
        }
      },
      itemCount: recentQueries!.length + titles.length,
    );
  }

  Widget _buildFilteredSuggestions(BuildContext context,
      List<String>? recentQueries, List<String> filteredTitles) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < recentQueries.length) {
          final queryIndex =
              recentQueries[index].toLowerCase().indexOf(query.toLowerCase());
          return ListTile(
            tileColor: Colors.white,
            onTap: () {
              query = recentQueries[index];
              showResults(context);
            },
            leading: const Icon(FontAwesomeIcons.clockRotateLeft),
            title: RichText(
              text: TextSpan(
                text: recentQueries[index].substring(0, queryIndex),
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: recentQueries[index]
                        .substring(queryIndex, queryIndex + query.length),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: recentQueries[index]
                        .substring(queryIndex + query.length),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        } else {
          final titlesIndex = index - recentQueries.length;
          final title = filteredTitles[titlesIndex];
          final matchIndex = title.toLowerCase().indexOf(query.toLowerCase());

          return ListTile(
            tileColor: Colors.white,
            onTap: () {
              query = title;
              showResults(context);
            },
            leading: const Icon(FontAwesomeIcons.magnifyingGlass),
            title: RichText(
              text: TextSpan(
                text: title.substring(0, matchIndex),
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text:
                        title.substring(matchIndex, matchIndex + query.length),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: title.substring(matchIndex + query.length),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        }
      },
      itemCount: recentQueries!.length + filteredTitles.length,
    );
  }

  Future<List<Map<String, dynamic>>> _loadData() async {
    return await FirebaseApi().getData();
  }

  void _saveSearchQuery(String query) async {
    if (query.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> searchHistory =
        prefs.getStringList('search_history')?.toList() ?? [];

    if (searchHistory.contains(query)) {
      searchHistory.remove(query);
    } else if (searchHistory.length >= maxSearchHistory) {
      searchHistory.removeAt(0);
    }

    searchHistory.add(query);
    await prefs.setStringList('search_history', searchHistory);
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);
    _saveSearchQuery(query);
  }

  @override
  void showSuggestions(BuildContext context) {
    super.showSuggestions(context);
    _saveSearchQuery(query);
  }
}
