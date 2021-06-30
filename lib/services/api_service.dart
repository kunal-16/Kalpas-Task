import 'package:http/http.dart';
import 'dart:convert';
import 'package:newsapp/models/article_model.dart';
class ApiService{
  final endPointUrl = "https://api.first.org/data/v1/news";

    Future<List<Article>> getArticle() async {
    Response res = await get(endPointUrl);
    print(res.body);

    if (res.statusCode == 200) {
      
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['data'];
      
     
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      print("Got articles");
      return articles;
    } else {
      throw ("Can't get the Articles");
    }

}
}