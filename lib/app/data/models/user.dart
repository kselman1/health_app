import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class MyUser with _$MyUser {
  const factory MyUser({
    required String name,
    required String email,
    required String password, 
    required String phone,
  }) = _MyUser;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
}
