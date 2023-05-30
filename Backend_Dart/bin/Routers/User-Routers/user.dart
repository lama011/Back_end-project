import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../Services/supabase/Database/DatabaseSupabase.dart';


class user{
Router get router {
    final app = Router();

    app.get('/home',(Request req){
      return Response.ok('home');
    });

    //-----------------login
    app.get('/setting',(Request req){
      return Response.ok('setting');

    });

    //----------------rest password
  app.get('/update_profile',(Request req)async{
    final token = req.headers["Authorization"];//the one which is sent with header to enclode the token with we add barer in the postman
    bool hasExpired = JwtDecoder.isExpired(token ?? "");

if(hasExpired){
return Response.ok('token has expired');
}

Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
final bodyJson = json.decode(await req.readAsString());

Map user = await DatabaseSupabase.updateProfile(
id: decodedToken["sub"],newData: bodyJson);
return Response.ok(json.encode(user),
headers: {"Content-Type":"application/json"});
});

//--------------rest password

app.get("/profile",(Request req)async{
  final token = req.headers["authorization"];
  bool hasExpired = JwtDecoder.isExpired( token ?? "");
if(hasExpired){
  return Response.ok("token is expired");
}
Map<String,dynamic>decodedToken = JwtDecoder.decode(token!);
Map user = await DatabaseSupabase.getUser(id: decodedToken["sub"]);

return Response.ok(json.encode(user),
headers: {"Content-Type":"application/json"}
);

});
return app;
}
}