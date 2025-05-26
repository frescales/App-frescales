import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future initialize() async {
    await Supabase.initialize(
      url: 'https://nhdumjitwzfpmtgtmvsk.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5oZHVtaml0d3pmcG10Z3RtdnNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2OTcyNTQsImV4cCI6MjA2MzI3MzI1NH0.2A_8twUONaN4XF2rk3RELfoF_VEr1cviSbyU2sJ8B1Q',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
