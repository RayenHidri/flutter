import 'package:intl/intl.dart';

class Component{
  int id=-1;
  String? name;
  String? family;
  int? quantity;
  DateTime? date;
  Component(this.id,this.name,this.family,this.quantity,this.date);
  Component.withoutId(this.name,this.family,this.quantity,this.date);
  Component.noParams();
Map<String, Object?> toMap() => {
    'id' : id,
    'name' : name,
    'family' : family,
    'quantity' : quantity,
    'date' : date.toString()
  };

Map<String, Object?> toMapNoId() => {
    
    'name' : name,
    'family' : family,
    'quantity' : quantity,
    'date' : date.toString()
  };

  factory Component.fromMap(Map<String, dynamic> json) => 
  Component(json['id'],json['name'],json['family'],json['quantity'],DateFormat('yyyy-MM-dd').parse(json['date']));
}