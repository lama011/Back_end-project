import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../User-Routers/user.dart';
import '../Auth-Routers/Auth-route.dart';

class BaseRoute{

Handler get router{
    final app = Router();
    app.mount('/user/', user().router);
    app.mount('/auth/', AuthRoute().router); 
      return app;   
  }
    
  }