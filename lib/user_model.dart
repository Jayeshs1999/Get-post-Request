

class UserModel{
  final String category_name;
  final String name;
  final String img;

  UserModel({ required this.category_name,required this.name,required this.img});
  factory UserModel.fromJson(final json){
    return UserModel(category_name: json['category_name'].toString(), name: json['category_name_english'].toString(),img: json['active_category_icon_thumb_path']);
  }
  
}