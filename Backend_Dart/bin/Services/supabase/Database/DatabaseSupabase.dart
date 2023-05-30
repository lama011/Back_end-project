import 'package:supabase/supabase.dart';

import '../../../.env/ConstFile.dart';

class DatabaseSupabase {
  static final supabase = SupabaseClient(ConstFile.url, ConstFile.key);

static addNewUser({required Map<String, dynamic> userMap}) async {
    try {
      await supabase.from("user").insert(userMap);
    } on PostgrestException catch (error) {
      throw FormatException(error.message);
    }
  }

static getUser({required String id}) async {
    try {
      List userData =
      await supabase.from("user").select().eq("id",id);
    } on PostgrestException catch (error) {
      throw FormatException(error.message);
    }
  }

  static updateProfile({required String id, required Map newData}) async {
    try {
      List userData =
      await supabase.from("user").update(newData).eq("id",id).select();
      print(userData);
      return userData.first;
    } on PostgrestException catch (error) {
      throw FormatException(error.message);
    }
  }
}
