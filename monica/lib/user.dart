

class User {
 String username;
 User(this.username);

 String getName() {
   return username;
 }

 static User fromDB(user) {
  var localUser = User(user['username']);
  return localUser;
 }

 String toString() {
   return username;
 }
}