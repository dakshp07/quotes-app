import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List QuotesData;
  fetchQuoteData() async {
    http.Response response = await http.get("https://type.fit/api/quotes");
    setState(() {
      QuotesData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchQuoteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Quotes App",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: Search(QuotesList: QuotesData));
          })
        ],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Quotes App",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                accountEmail: new Text("quotesapphelp@gmail.com",style: TextStyle(fontSize: 15,color: Colors.white),),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.blue[800],
                child: new Text("QA",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
            new ListTile(
              title: new Text("Quotes",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: new Icon(Icons.format_quote,size: 20,color: Colors.white,),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
              },
            ),
            new Padding(padding: const EdgeInsets.only(top: 10)),
            new Divider(
              height: 10,
              thickness: 2,
              color: Colors.grey[700],
            ),
            new Padding(padding: const EdgeInsets.only(top: 10)),
            new ListTile(
              title: new Text("Close",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: new Icon(Icons.close,size: 20,color: Colors.white,),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: QuotesData == null ? new Center(
        child: new CircularProgressIndicator(),
      ) : new ListView.builder(
          itemCount: QuotesData.length,
          itemBuilder: (context , index) =>
          new Column(
            children: <Widget>[
              new Card(
                color: Color(0x000080),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: new ListTile(
                  title: new Text(QuotesData[index]["text"],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                  subtitle: new Text("-"+QuotesData[index]["author"],style: TextStyle(fontSize: 15,color: Colors.grey[700],fontWeight: FontWeight.bold),),
                )
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 5)),
            ],
          )
      ),
    );
  }
}