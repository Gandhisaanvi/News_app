import 'dart:convert';
import 'package:news_app/model/slider_model.dart';
import 'package:http/http.dart' as http;

class Slidermo
{

  List<Slidermodel>sliders=[];

  Future<void>getSlider() async
  {
    String url="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=ca0416e7f7ab46a4be7e992cd0029c0b";
    var uri=Uri.parse(url);
    var response= await http.get(uri);
    var jsonData=jsonDecode(response.body);

    if(jsonData['status']=='ok'&& jsonData["totalResults"]==10)
    {
      jsonData["articles"].forEach((element)
      {
        if(element["urlToImage"]!=null && element["description"]!=null)
        {
          Slidermodel sliderModel =Slidermodel
            (

              title:element['title'],
              description: element["description"],
              url: element['url'],
              urlToImage: element["urlToImage"],
              content: element['content'],
              author: element['author']




          );
          sliders.add(sliderModel);
        }

      });
    }


  }
}