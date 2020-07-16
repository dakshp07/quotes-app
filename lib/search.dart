import 'package:flutter/material.dart';

class Search extends SearchDelegate{

  final List QuotesList;

  Search({this.QuotesList});

  @override

  ThemeData appBarTheme(BuildContext context)  {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey[900],
    );
}

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = "";
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
        IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? QuotesList : QuotesList.where((element) => element["text"].toLowerCase().startsWith(query)).toList();
    return new ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context , index) =>
        new Column(
          children: <Widget>[
            new Card(
                color: Color(0x000080),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: new ListTile(
                  title: new Text(suggestionList[index]["text"],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                  subtitle: new Text("-"+suggestionList[index]["author"],style: TextStyle(fontSize: 15,color: Colors.grey[700],fontWeight: FontWeight.bold),),
                )
            ),
            new Padding(padding: const EdgeInsets.only(bottom: 5)),
          ],
        )
    );
  }
}