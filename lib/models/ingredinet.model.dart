// class IngredientModel {
//   List<String>? users_ids;
//   String? docId;
//   String? name;
//   String? imageUrl;
//   String? mealType;
//   int? time;
//
//   IngredientModel();
//   IngredientModel.fromJson(Map<String, dynamic> data, [String? id]) {
//     docId = id;
//     name = data['name'];
//     imageUrl = data['imageUrl'];
//     mealType=data['mealType'];
//     time =data['time'];
//     users_ids = data['users_ids'] != null
//         ? List<String>.from(data['users_ids'].map((e) => e.toString()))
//         : null;
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "imageUrl": imageUrl,
//       "users_ids": users_ids,
//     };
//   }
// }
