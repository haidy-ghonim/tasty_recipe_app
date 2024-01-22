class RecipeModel{
 List <dynamic> ? Ingredients;
  String? title ;
  String? image;
  int?   time;
  int? review;
  int? serving;
  String ? description;
 String? mealType;

  RecipeModel();
  RecipeModel.fromJson(Map<String,dynamic>data,[String? id]){
    // docId = id;
    Ingredients=data['Ingredients'];
    title =data['title'];
    image =data['image'];
    time=data['time'];
    description=data['description'];
   review=data['review'];
    serving=data['serving'];
    mealType=data['mealType'];
  }


  // Map<String,dynamic> toJson(){
  //   return {
  //     "title":title,
  //     "image":image,
  //
  //
  //   };

  }
// }