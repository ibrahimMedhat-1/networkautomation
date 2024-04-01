class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? image;
  String? floors;
  String? rooms;
  String? desks;
  String? computers;
  String? buisnessTitle;
  int? steps;



  UserModel(
      {required this.id,
      required this.name,
      required this.email,
     required this.phoneNo,
        required this.image,
        required this.rooms,
        required this.computers,
        required this.desks,
        required this.floors,
        required this.buisnessTitle,
        this.steps
      });

  Map<String, dynamic> toMap() => {

        'id': id,
        'name': name,
        'email': email,
        'phoneNo': phoneNo,
        'image': image,
        'floors': floors,
        'rooms': rooms,
        'desks': desks,
        'computers': computers,
        'buisnessTitle': buisnessTitle,

      };

  UserModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    image = json['image'];
    floors = json['floors'];
    rooms = json['rooms'];
    desks = json['desks'];
    computers = json['computers'];
    buisnessTitle = json['buisnessTitle'];
  }
}
