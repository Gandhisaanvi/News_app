import 'dart:convert';
import 'package:news_app/model/article_model.dart';
import 'package:http/http.dart' as http;

class News
{

  List<ArticleModel>news=[];

  Future<void>getNews() async
  {
    String url="https://newsapi.org/v2/everything?q=apple&from=2024-05-21&to=2024-05-21&sortBy=popularity&apiKey=ca0416e7f7ab46a4be7e992cd0029c0b";
    var uri=Uri.parse(url);
    var response= await http.get(uri);
    var jsonData=jsonDecode(response.body);

    if(jsonData['status']=='ok')
      {
        jsonData["articles"].forEach((element)
        {
          if(element["urlToImage"]!=null && element["description"]!=null)
            {
              ArticleModel articleModel =ArticleModel
                (
                  title:element['title'],
                  description: element["description"],
                  url: element['url'],
                  urlToImage: element["urlToImage"],
                  content: element['content'],
                  author: element['author']




                );
              news.add(articleModel);
            }

        });
      }


  }
}