import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class User extends HiveObject{
  
  @HiveField(0)
  String userid;

  @HiveField(1)
  String password;

  User({
    required this.userid,
    required this.password,
  });

  @override
  String toString() {
    return '$userid : $password';

  }
}


// class User{
  
//   String userid;
//   String password;
//   String password2;
//   String phone;

//   User({
//     required this.userid,
//     required this.password,
//     required this.password2,
//     required this.phone,
//   });
// }