import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:supabase/supabase.dart';
import '../../.env/ConstFile.dart';
import '../../Services/supabase/Auth/AuthSupabase.dart';
import '../../Services/supabase/Database/DatabaseSupabase.dart';


class AuthRoute {
  Handler get router {
    final app = Router();

    app.post('/signup', (Request req) async {
      try {
        final body = await json.decode(await req.readAsString());

        Map? newUser = await AuthSupabase.createAccount(
            email: body["email"], password: body["password"] ?? "");

        Map<String, dynamic> dataUser = {
          "name": body["name"],
          "id": newUser!["id"],
          "email": newUser["email"]
        };
        await DatabaseSupabase.addNewUser(userMap: dataUser);
        //------------
        return Response(200,
            body: json.encode(newUser),
            headers: {"Content-Type": "application/json"});
      } on FormatException catch (error) {
        return Response.forbidden(error.message);
      }
    });

    //---------------Login
    app.post('/login', (Request req) async {
      try {
        final body = json.decode(await req.readAsString());

        final Map jsonResponse = await AuthSupabase.loginUser(
            email: body["email"], password: body["password"]);

        return Response.ok(json.encode(jsonResponse),
            headers: {"Content-Type": "application/json"});
      } on FormatException catch (error) {
        return Response.forbidden(error.message);
      }
    });

    //---------------rest password
    app.post('/rest', (Request req) {
      return Response.ok('rest password');
    });

    return app;
  }
}
