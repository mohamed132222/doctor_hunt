import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static String supabaseUrl = "https://gqnesiyctvpvsxlaqtto.supabase.co";
  static String publishableKey =
      "sb_publishable_sj9czSyce7ResDBvcxVr5Q_cG2QmLwN";

  static Future<void> supabaseInit() async {
    await Supabase.initialize(url: supabaseUrl, publishableKey: publishableKey);
  }
}
