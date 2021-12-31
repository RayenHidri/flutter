class Family{
String name;
Family(this.name);
// ignore: non_constant_identifier_names
Map<String, Object?> toMap() => {
    'name' : name
  };
  factory Family.fromMap(Map<String, dynamic> json) => 
  Family(json['name']);

  @override
  String toString() {
    
    return name;
  }
}
