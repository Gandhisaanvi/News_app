import 'dart:convert';
import 'package:news_app/model/show_category.dart';
import 'package:http/http.dart' as http;

class ShowCategoryNews
{

  List<ShowCategoryModel>categories=[];

  Future<void>getCategory(String category) async
  {
    String url="https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=ca0416e7f7ab46a4be7e992cd0029c0b";
    var uri=Uri.parse(url);
    var response= await http.get(uri);
    var jsonData=jsonDecode(response.body);

    if(jsonData['status']=='ok')
    {
      jsonData["articles"].forEach((element)
      {
        if(element["urlToImage"]!=null && element["description"]!=null)
        {
          ShowCategoryModel categorynews = ShowCategoryModel
            (

              title:element['title'],
              description: element["description"],
              url: element['url'],
              urlToImage: element["urlToImage"],
              content: element['content'],
              author: element['author']




          );
          categories.add(categorynews);
        }

      });
    }


  }
}