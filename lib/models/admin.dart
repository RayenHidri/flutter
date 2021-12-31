
class Admin {
  String username;
  String password;

  Admin(this.username,this.password);

  Map<String, Object?> toMap() => {
    'username' : username,
    'password' : password,

  };

  factory Admin.fromMap(Map<String, dynamic> json) => 
  Admin(json['username'],json['password']);
}