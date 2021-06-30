import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import "package:newsapp/models/liked.dart";


class customListTile extends StatefulWidget {


  Article article;
  BuildContext context;
  customListTile({this.article,this.context});

  @override
  _customListTileState createState() => _customListTileState();
}

class _customListTileState extends State<customListTile> {

  
  Color _iconColor= Colors.grey;
  bool _liked=false;

  void initState(){
      super.initState();
      if(LikedList.likedarticles.contains(widget.article.id)){
         _liked=true;


      }
      else{_liked=false;}

  }


  @override
  Widget build(BuildContext context) {
    if(widget.article.id==null || widget.article.summary==null || widget.article.link==null ){
      return Container(

      );
    }

   return InkWell(
    onTap: () {
     
    },
    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        InkWell(
            onTap: () {},
            child: Container(
              
              width: 80,
              child: IconButton(
        icon: Icon(_liked?Icons.favorite:Icons.favorite_border, color: _iconColor),
        onPressed: () {
          if(_liked){
              LikedList.likedarticles.removeWhere((element){
                 element==widget.article.id; 



              });

              _liked=false;
          }
          else{
              LikedList.likedarticles.add(widget.article.id);

              _liked=true;
          }


          setState(() {
            
          });
          
        }
         
    ),
            )),
        SizedBox(width: 3.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  // borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  widget.article.title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                widget.article.summary,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Text(
                widget.article.link,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ]),
    ),
  );
  }
}




























