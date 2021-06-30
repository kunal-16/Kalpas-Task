

class Article {
  int id;
  String title;
  String summary;
  String link;
  String published;
  
  Article(
      {this.id,
      this.title,
      this.summary,
      this.link,
      this.published,
      });

  
  factory Article.fromJson(Map<String, dynamic> json) {
    print("_____________________________");
    print(json);
    return Article(
      
      id: json['id'] ,
      title: json['title'] as String,
      summary: json['summary'] as String,
      link: json['link'] as String,
      published: json['published'] as String,
    
    );
  }
}