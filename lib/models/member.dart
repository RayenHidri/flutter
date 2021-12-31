class Member {
  int id = -1;
  String? first_name;
  String? last_name;
  int? num1;
  int? num2;

  Member(this.id,this.first_name,this.last_name,this.num1,this.num2);
  Member.withoutId(this.first_name,this.last_name,this.num1,this.num2);
  Member.noParams();

  Map<String, Object?> toMap() => {
    'id' : id,
    'first_name' : first_name,
    'last_name' : last_name,
    'num1':num1,
    'num2' : num2

  };

  Map<String, Object?> toMapNoId() => {
   
    'first_name' : first_name,
    'last_name' : last_name,
    'num1':num1,
    'num2' : num2

  };

  factory Member.fromMap(Map<String, dynamic> json) => 
  Member(json['id'],json['first_name'],json['last_name'],json['num1'],json['num2']);
}