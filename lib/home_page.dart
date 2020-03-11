import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authservice.dart';
import 'bookmark.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser currentUser;

  HomePage(this.currentUser);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notesData = Bookmark.getData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BookNotes - Bookmarks"),
        actions: <Widget>[searchButton(), logoutButton()],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView.builder(
          itemCount: notesData.length,
          itemBuilder: (context, position) {
            return buildCard(notesData[position]);
          },
        ),
      ),
    );
  }

  Widget buildCard(data) {
    return Card(
      child: Column(children: <Widget>[
        Text(
          data.book,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(data.note),
      ]),
    );
  }

  logoutButton() {
    return IconButton(
        icon: Icon(Icons.close),
        onPressed: () async {
          await Provider.of<AuthService>(context).logout();
        });
  }

  searchButton() {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchAppBar(notesData),
          );
        });
  }
}

class SearchAppBar extends SearchDelegate<String> {
  final List<Bookmark> books;
  List<String> history = ["Harry", "Cochi"];

  SearchAppBar(this.books);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          //showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = books.where((b) => b.book.contains(query));
    return ListView.builder(itemBuilder: (context, index) => Card(
      child: Column(children: <Widget>[
        Text(
          result.elementAt(index).book,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(result.elementAt(index).note),
      ]),
    ),
      itemCount: result.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = this.query.isEmpty
        ? books
        : books.where((b) => b.book.contains(query));
    return ListView.builder(itemBuilder: (context, index) => ListTile(
      title: Text(history[index]),
    ));
  }
}