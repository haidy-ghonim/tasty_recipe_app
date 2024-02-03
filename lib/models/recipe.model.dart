class RecipeModel {
  List<dynamic>? ingredients;
  num? calories;
  String? description;
  String? image;
  bool? isActive;
  String? mealType;
  num? reviews;
  num? rating;
  String? title;
  num? totalTime;
  num? serving;
  List<String>? users_ids;
  String? docId;
  List<dynamic>? directions;

  RecipeModel();
  RecipeModel.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    directions = data['directions'];
    ingredients = data['ingredients'];
    isActive = data['isActive'];
    title = data['title'];
    image = data['image'];
    totalTime = data['totalTime'];
    description = data['description'];
    reviews = data['reviews'];
    rating = data['rating'];
    serving = data['serving'];
    mealType = data['mealType'];
    calories = data['calories'];
    users_ids = data['users_ids'] != null
        ? List<String>.from(data['users_ids'].map((e) => e.toString()))
        : null;
  }
}
