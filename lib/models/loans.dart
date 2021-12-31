import 'package:intl/intl.dart';

class Loans{
  int? idMember;
  int? idComponent;
  DateTime? DateEmp;
  DateTime? DateReturn;
  int returned = 0;
  String? returnCond;

  Loans(this.idMember,this.idComponent,this.DateEmp,this.DateReturn,this.returned,this.returnCond);
  Loans.withoutId(this.idMember,this.idComponent,this.DateEmp,this.returned);
  Loans.noParams();

 

  Map<String, Object?> toMapWithoutId() => {
    'idMember' : idMember,
    'idComponent' : idComponent,
    'DateEmp' : DateEmp.toString(),
    'DateReturn' : DateReturn.toString(),
    'returned':returned,
    'returnCond': returnCond
  };




factory Loans.fromMapNoReturn(Map<String, dynamic> json) => 
Loans.withoutId(json['idMember'], json['idComponent'], DateFormat('yyyy-MM-dd').parse(json['dateEmp']),0);

factory Loans.fromMap(Map<String, dynamic> json) => 
  Loans(json['idMember'],json['idComponent'],DateFormat('yyyy-MM-dd').parse(json['dateEmp']),DateFormat('yyyy-MM-dd').parse(json['dateReturn']),json['returned'],json['returnCond']);


}