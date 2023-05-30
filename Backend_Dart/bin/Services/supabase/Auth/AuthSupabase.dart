
import 'package:supabase/supabase.dart';
import 'package:test/test.dart';

import '../../../.env/ConstFile.dart';

class AuthSupabase{
  static final supabase = SupabaseClient(ConstFile.url, ConstFile.key);

  static createAccount({required String email,required String password})async{
   
try{
   AuthResponse newUser = await supabase.auth.signUp(email: email, password:password);
    Map<String, dynamic> customJson = {
      "id":newUser.user?.id,
      "email":newUser.user?.email,
      "last_sign":newUser.user?.lastSignInAt,
      "token":newUser.session?.accessToken,

    };
  
    return customJson;
  }on AuthException catch(error){
   Map<String, dynamic> customJson = {
    "msg":error.message
   };
    return customJson;
    
  }
  }

  //----------login------------

 static loginUser({required String email,required String password})async{
    try{
    AuthResponse newUser = await supabase.auth.signInWithPassword(email: email, password:password); 
    Map<String, dynamic> customJson = {
      "id":newUser.user?.id,
      "userEMail":newUser.user?.email,
      "last_sign":newUser.user?.lastSignInAt,
      "token":newUser.session?.accessToken,
      "refreshToken":newUser.session?.refreshToken

    };
    return customJson;
    }on AuthException catch(error){
  throw FormatException(error.message);
   }
    
  }

  }