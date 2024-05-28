
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/pages/allnews.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/sliderdata.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:news_app/services/news.dart';
import '../model/category_model.dart';
import '../model/slider_model.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/show_category_news.dart';

import 'category_news.dart';


class Home extends StatefulWidget
{
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  List<CategoryModel>categories=[];
  List<Slidermodel>sliders=[];
  List<ArticleModel>articles=[];
  int activeIndex=0;
  bool _loading=true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    fetchSliderAndNews();
  }

  fetchSliderAndNews() async {
    await getSlider();
    await getNews();
    setState(() {
      _loading = false;
    });
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
  }

  getSlider() async {
    Slidermo slider = Slidermo();
    await slider.getSlider();
    sliders = slider.sliders;
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Flutter"),
              Text("News", style: TextStyle(fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),)
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:_loading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0),
                height: 80,
                child: ListView.builder(

                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,itemBuilder:(context,index){
               return CategoryTile
                 (
                 image: categories[index].image,
                 categoryName: categories[index].categoryName,



                 );
              }),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Breaking News !",style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewall(news:"Breaking")));
                      },
                        child: Text("View all",style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.blue),)),

                  ],
                ),
              ),
              CarouselSlider.builder(itemCount:5, itemBuilder: (context,index,realIndex){
                String? res=sliders[index].urlToImage;
                String? res1=sliders[index].title;
                return BuildImage(res!,index,res1!);
              }, options: CarouselOptions(
                height: 220,
                viewportFraction: 1,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index,reason){
                  setState(() {
                    activeIndex=index;
                  });
                })),
              SizedBox(height: 30,),
              Center(child: BuildIndicator()),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending News",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                    GestureDetector(onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewall(news:"Trending")));
                    },child: Text("View all",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.blue),))
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(


                child: ListView.builder( shrinkWrap:true,
                    physics: ClampingScrollPhysics(),
                    itemCount:articles.length,itemBuilder:(context,index)
                    {
                      return BlogTile(title :articles[index].title??'',imageUrl: articles[index].urlToImage??'', desc: articles[index].description??'no',url:articles[index].url??"");
                    }),
              )


            ],
          ),
        ),
      ),

    );

  }


  Widget BuildImage(String image,int index,String name)=>Container(
    margin: EdgeInsets.symmetric(horizontal: (5)),
    child: Stack(
      children:[ ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          fit: BoxFit.cover,width: MediaQuery.of(context).size.width,imageUrl: image,),

      ),
        Container(
          height: 200,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 150),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10) )
          ),
          child: Center(child: Text(name,maxLines:2,style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),)),
        )
  ]
    ),
  );

  Widget BuildIndicator()=>AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count:5,
     effect: SlideEffect(dotColor: Colors.grey,dotHeight: 12,dotWidth: 12),
  );
}

class CategoryTile extends StatelessWidget{
   final image,categoryName;
   CategoryTile({this.categoryName,this.image});
   @override
   Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> CategoryNews(name:categoryName ,)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child:Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.asset(image,width: 150,height: 360,fit: BoxFit.cover,)),
            Container(
              width: 150,
              height: 360,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black38,),
              child: Center(child: Text(categoryName,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300),)),
            )
      
          ],
        ) ,
      ),
    );
  }
}
class BlogTile extends StatelessWidget
{
   String imageUrl,title,desc,url;
   BlogTile({required this.title,required this.imageUrl,required this.desc,required this.url});
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder:(context)=>ArticleView(BlogUrl:url)));
     },
     child: Container(
       margin: EdgeInsets.only(bottom: 10),
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
         child: Material(
           elevation: 3.0,
           borderRadius: BorderRadius.circular(10),
           child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     child: ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                         child: CachedNetworkImage(
                           imageUrl: imageUrl,
                          height:150, width: 150,
                          fit: BoxFit.cover)),

                   ),
                   SizedBox(width: 5,),
                   Column(
                     children: [
                       Container(
                         width: MediaQuery.of(context).size.width/2.0,
                         child: Text(title,maxLines:2,style: TextStyle(
                             color: Colors.black,
                             fontSize: 16,
                             fontWeight: FontWeight.w500
                         ),),
                       ),
                       SizedBox(height: 7,),
                       Container(

                         width: MediaQuery.of(context).size.width/2.0,
                         child: Text(desc,
                             maxLines: 3
                             ,style:TextStyle(
                                 color: Colors.black38,
                                 fontWeight: FontWeight.w500,
                                 fontSize: 14

                             )),
                       ),

                     ],
                   )
                 ],
               ),
             ),
           ),
         ),
       ),
     ),
   );
  }


}
