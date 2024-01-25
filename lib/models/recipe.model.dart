class RecipeModel {
  List<dynamic>? Ingredients;
  String? title;
  String? image;
  int? time;
  int? review;
  int? serving;
  String? description;
  String? mealType;
  int? calories;
  List<String>? users_ids;
  String? docId;

  RecipeModel();
  RecipeModel.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    Ingredients = data['Ingredients'];
    title = data['title'];
    image = data['image'];
    time = data['time'];
    description = data['description'];
    review = data['review'];
    serving = data['serving'];
    mealType = data['mealType'];
    calories = data['calories'];
    users_ids = data['users_ids'] != null
        ? List<String>.from(data['users_ids'].map((e) => e.toString()))
        : null;
  }
}
