class RecipeModel {
  List<String>? ingredients;
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
  List<String>? users_ids;//todo favourite user
  String? docId;
  // Map<String, String>? directions;

  RecipeModel();
  RecipeModel.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
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
    ingredients = data['ingredients']!= null
        ? List<String>.from(data['ingredients'].map((e) => e.toString()))
        : null;

    // directions = data['directions'] != null
    //     ? Map<String, String>.from(data['directions'])
    //     : null;

  }

  Map<String, dynamic> toJson() {
    return {
      // "directions": directions,
      "mealType": mealType,
      "serving": serving,
      "rating": rating,
      "reviews": reviews,
      "description": description,
      "totalTime": totalTime,
      "image": image,
      "ingredients": ingredients,
      "title": title,
      "isActive": isActive,
      "calories": calories,
      "users_ids": users_ids,
    };
  }
}
