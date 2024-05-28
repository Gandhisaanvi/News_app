import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/category_news.dart';
import '../model/article_model.dart';
import '../model/slider_model.dart';
import '../services/news.dart';
import '../services/sliderdata.dart';
import 'article_view.dart';
import 'category_news.dart';

class Viewall extends StatefulWidget {
  String news;
  Viewall({required this.news});

  @override
  State<Viewall> createState() => _ViewallState();
}

class _ViewallState extends State<Viewall> {
  List<Slidermodel>sliders=[];
  List<ArticleModel>articles=[];
  bool _loading=true;

  void initState() {
    super.initState();
    getSlider();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading=false;
    });
  }

  getSlider() async {
    Slidermo slider = Slidermo();
    await slider.getSlider();
    sliders = slider.sliders;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news +" News",
          style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
        margin:EdgeInsets.symmetric(horizontal: 10) ,
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: widget.news=="Breaking"?sliders.length: articles.length,
          itemBuilder: (context, index) {
            return Viewallsection(
              image: widget.news=="Breaking"? sliders[index].urlToImage!:articles[index].urlToImage!,
              title:widget.news=="Breaking"? sliders[index].title!:articles[index].title!,
              desc:widget.news=="Breaking"? sliders[index].description!:articles[index].description!,
              url: widget.news=="Breaking"? sliders[index].url!:articles[index].url!,
            );
          },
        ),
      ),
    );
  }
}
class Viewallsection extends StatelessWidget {
  final String image, desc, title,url;

  Viewallsection({required this.image, required this.url,required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(BlogUrl:url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              desc,
              maxLines: 4,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
