class EngModel {
  String? id;
  String? name;
  String? email;
  String? image;




  EngModel(
      {required this.id,
        required this.name,
        required this.email,

        required this.image,

      });

  Map<String, dynamic> toMap() => {

    'id': id,
    'name': name,
    'email': email,
    'image': image,

  };

  EngModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];

  }
}
