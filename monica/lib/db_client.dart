

class DBClient {

  static DBClient dbClient;
  String name;


  DBClient(name) {
    this.name = name;
  }

  void setDBClient(DBClient client) {
    dbClient = client;
  }

  static DBClient getInstance() {
    return dbClient;
  }

  List<Map<String, String>> getUsers() {
    return [{"name":"jake"}, {"name":"truls"}];
  }

}