import 'dart:convert';

class AddFields {
  static final String Id = 'Id';
  static final String Title = 'Nama Volume';
  static final String Satuan = 'Satuan';
  static final String TotalHarga = 'Total Harga';

  static List<String> getFields() => [Id, Title, Satuan, TotalHarga];
}

class AddUser {
  final int? Id;
  final String Title;
  final String Satuan;
  final String TotalHarga;

  const AddUser({
    this.Id,
    required this.Title,
    required this.Satuan,
    required this.TotalHarga,
  });
  AddUser Copy({
    int? Id,
    String? Title,
    String? Satuan,
    String? TotalHarga,
  }) =>
      AddUser(
        Id: Id ?? this.Id,
        Title: Title ?? this.Title,
        Satuan: Satuan ?? this.Satuan,
        TotalHarga: TotalHarga ?? this.TotalHarga,
      );
  static AddUser fromJson(Map<String, dynamic> json) => AddUser(
        Id: jsonDecode(json[AddFields.Id]),
        Title: json[AddFields.Title],
        Satuan: json[AddFields.Satuan],
        TotalHarga: json[AddFields.TotalHarga],
      );
  Map<String, dynamic> toJson() => {
        AddFields.Id: Id,
        AddFields.Title: Title,
        AddFields.Satuan: Satuan,
        AddFields.TotalHarga: TotalHarga,
      };
}
