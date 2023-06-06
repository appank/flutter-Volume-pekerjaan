import 'dart:convert';

class UserFields {
  static final String id = 'ID';
  static final String satuan = 'SATUAN';

  static List<String> getFields() => [id, satuan];
}

class User {
  final int? id;
  final String satuan;

  const User({
    this.id,
    required this.satuan,
  });
  User Copy({
    int? id,
    String? satuan,
  }) =>
      User(
        id: id ?? this.id,
        satuan: satuan ?? this.satuan,
      );
  static User fromJson(Map<String, dynamic> json) => User(
        id: jsonDecode(json[UserFields.id]),
        satuan: json[UserFields.satuan],
      );
  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.satuan: satuan,
      };
}
