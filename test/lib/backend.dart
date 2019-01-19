import 'db_client.dart';
import 'auth.dart';

class Backend {

  static void init() {
    DBClient client = DBClient("backend yey");
    client.setDBClient(client);

    Auth auth = Auth();
    auth.setAuth(auth);
  }
}