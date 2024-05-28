import 'package:news_app/model/category_model.dart';
import 'package:news_app/services/sliderdata.dart';

List<CategoryModel>getCategories() {
  List<CategoryModel>category = [];
  CategoryModel categoryModel=new CategoryModel();

  categoryModel .categoryName="Business";
  categoryModel.image="assets/images/business.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();


  categoryModel .categoryName="General";
  categoryModel.image="assets/images/general.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();


  categoryModel .categoryName="Sports";
  categoryModel.image="assets/images/sports.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();


  categoryModel .categoryName="Entertainment";
  categoryModel.image="assets/images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();


  categoryModel .categoryName="Health";
  categoryModel.image="assets/images/health.jpg";
  category.add(categoryModel);
  categoryModel=new CategoryModel();
  return category;
}