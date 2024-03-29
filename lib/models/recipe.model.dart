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
  List<String>? users_ids;
  String? docId;
  List<String>? recentlyView;
  Map<String, String>? directions;
  List<String>? favourite_users_ids; //todo favourite user

  RecipeModel();
  RecipeModel.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    recentlyView = data['recentlyView'] != null
        ? List<String>.from(data['recentlyView'].map((e) => e.toString()))
        : null;
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
    favourite_users_ids = data['favourite_users_ids'] != null
        ? List<String>.from(
            data['favourite_users_ids'].map((e) => e.toString()))
        : null;
    users_ids = data['users_ids'] != null
        ? List<String>.from(data['users_ids'].map((e) => e.toString()))
        : null;

    ingredients = data['ingredients'] != null
        ? List<String>.from(data['ingredients'].map((e) => e.toString()))
        : null;

    directions = data['directions'] != null
        ? Map<String, String>.from(data['directions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "directions": directions,
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
      "favourite_users_ids": favourite_users_ids,
    };
  }
}
