import 'package:flutter/material.dart';
import 'package:newsapp/models/liked.dart';
import 'package:newsapp/pages/login.dart';
import 'package:newsapp/pages/register.dart';
import 'package:newsapp/providers/auth_provider.dart';
import 'package:newsapp/providers/user_provider.dart';
import 'package:newsapp/services/api_service.dart';
import 'package:newsapp/utility/shared_preference.dart';
import 'package:provider/provider.dart';

import 'components/customListTile.dart';
import 'domain/user.dart';
import 'models/article_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Future<User> getUserData () => UserPreferences().getUser();

          return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> AuthProvider()),
          ChangeNotifierProvider(create: (_)=>UserProvider())
        ],
      child:  MaterialApp(
        title: 'Login Registration',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data.token == null)
                    return Login();
                  else
                    Provider.of<UserProvider>(context).setUser(snapshot.data);
                    return HomePage();

              }
            }),
        routes: {
          '/login':(context)=>Login(),
          '/register':(context)=>Register(),
          '/dashboard':(context)=>HomePage()
        },
      ),
    );
    
    
      
    
  }
}

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService client=ApiService();
  int _currentIndex=0;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: _currentIndex==0 ?
      FutureBuilder(future:client.getArticle(),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
        if (snapshot.hasData) {
            
            List<Article> articles = snapshot.data;
            return ListView.builder(
             
              itemCount: articles.length,
              itemBuilder: (context, index) =>
                  customListTile(article:articles[index],context: context),
                   
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );


      }):
      FutureBuilder(future:client.getArticle(),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
        if (snapshot.hasData) {
            
            List<Article> articles = snapshot.data;
            return ListView.builder(
             
              itemCount: articles.length,
              itemBuilder: (context, index) {

                if(LikedList.likedarticles.contains(articles[index].id)){
                  return customListTile(article:articles[index],context: context);
                }
                else{
                  return null;
                }
                 


              }
                  

                  
                   
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );


      }),









      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
        BottomNavigationBarItem(
          icon:Icon(Icons.add_to_photos),
          title: Text('Home'),
          backgroundColor: Colors.blue
        ),
         BottomNavigationBarItem(
          icon:Icon(Icons.favorite),
          title: Text('Favourites'),
          backgroundColor: Colors.blue
        ),

      ],
      onTap: (index){
        setState(() {
          _currentIndex=index;
        });
      },),

    );
  }
}