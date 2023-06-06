import 'dart:convert';

import 'package:gsheets/gsheets.dart';
import 'package:volume_pekerjaan/api/user.dart';

class UserSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "rising-artifact-387810",
  "private_key_id": "5b804e6de8366cdfc7e1c2d6535836302349786e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCjQsdy/CaOmIWe\nfeqZ1HH3o9FN7Jbp2CFGl/ww/BRRnbwejVgf1909BPxdXZfYblFwSpZO6055uMp9\n/uV5WnmjtJ8z+1sAYozm3ruBrH3F6dpVmvcfzXe0hvt6p+DcVAhgU6jhdPyOFsZg\nkx0+7E988dyuCse7ZA4BkoLGt8nUCfXGwHo8z4QtSOgXo8r8pZhQFnAhWRA3cJu4\nkuvf4Ua1RID5Q8vKrX9t3B1oNa8prmNxVrpaVVKcZejrrqtmG+aftQAk/s89YE+d\ndeHBZ/obNxQcGrweIktsli8PfHfmLffkeg8zUv7+xzYkIHOJj0BGKrCw7hnTPjz1\nJ8/eVkQhAgMBAAECggEABQ4HoRulwXc/Ntqo8XmajDtwGvCq9QNON3Jz+lvJsMO4\nm/0OGBFNzip5+lWQIqE6yAZlLD0cnUfvjBJg7j6TAtKwNbKv/P1wJaNKjK+npsGw\ncwNU6LEKxmYCAgiR3ZyD9GCOu2lM+wTBQGL5rjWwmdqetaxLhhWpWdrcjfTJjNUz\n5zlij2zLev5Ea2RtbjFPs9d3SpJBnSRBWN/dLAK9GR73cYpwqNBBIygq+VW1woMu\npA2b0t0gX+HkldIbuqJIanUPn44U/iRHsxyoqhxxoOHglg/1Aej0Jlner2Nh/NGs\npLej93fkUL8TtYOXSGOAEvbOhTYBjc7AQdaks9VKAQKBgQDfiMM6QX93/eaASJyV\niW16Mndps9PD+zQ7en6eptiaV6L/P0zJhap2YEWhDxiB1nGaLilP/yix6u19l+Y+\nvaPisz6ATkE+NERKnZ1lYFBoNZvN2bxfFodMBb676eO1P+Uc8/MBLfkJXC4Lu+7g\n3GnTZSEH/QC+Kz6dacD9mX5ggQKBgQC6+P061T7ers8fGmHlFcPjPdGZf1HEu82L\nGw7rCWMeRuHDRF1FIqi9ll9yTVN6agBZxJbC2Na2XE7uemFLvxDzKTqb9V9FBp1n\nV1NpkA7pzpTD6MGM0Jp4PjLt0scwKjbx4h/89Z1bkq8PfcblfS81JrHR9LFRhg3G\n3U9BW7IToQKBgQCatt3pBExlkKZpQ9ic53GOkj90ObLogoW0ZSQeSvzAVsfKQtWy\n5YEGTbvjrb8YnoQiYrDVXZWdDy0xMGF8K2WzEry/sWoW07Ywrsax0+fTOMeNwpZO\nehlK1O8ewNOKL580WuRmfJtRjyuPk5PSrrvQRL6H+OT6upOr//ZDkGmYAQKBgQC4\nQbIEbaxEdU9GXpCE2zstUXmiZHdngpBf+u1rsNeOOdo4vcGQ5UQXef5bvVp788Se\nsn7ETD7kffmHSPFjXUrN5x6MHXaipo8uDT/1cvNPdLbkjhdXtyfTQbCc8LA9hgyZ\nuPc/KanGWbrNcG03MXP5VEW/G/420f33sZduWHgYoQKBgBn1VBunBuUQwE0LbxP/\nCO8C6CFKdziDTWGlLU8b1IZmHTdzSUxxIYXeN6s7nFpZz3HxcVCb5PTJrWJtYR5b\nApASH8Thn9eEmEj5SvFWwDiWjN67JTiHri2M8/HGZZzYVwjBhsDA+IndXSPpMbzS\n1SS8rVsy6kRhDBWhZ16qfv7G\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@rising-artifact-387810.iam.gserviceaccount.com",
  "client_id": "113437380702068004354",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40rising-artifact-387810.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

''';

  static final _spreadsheetId = "1bGffbJkxAuDMocwwTRtUnfHo5ZQ8nzttkX2afOwkQf0";
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheets = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheets, title: 'Satuan');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Erorr: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<User?> getById(int id) async {
    if (_userSheet == null) return null;
    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }
}
