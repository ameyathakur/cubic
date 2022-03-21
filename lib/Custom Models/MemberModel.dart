

class MemberModel{
  String name, relation, gender, dob, adhar;

  MemberModel({this.name = '', this.relation='', this.gender='', this.dob='', this.adhar=''});

  factory MemberModel.fromJson(dynamic json){
  MemberModel p = new MemberModel();
  p.name = json['name'];
  p.gender = json['gender'];
  p.dob = json['dob'];
  p.adhar = json['adhar'];
  p.relation = json['relation'];
  return p;
}

  Map toJson() => {
    'name': name,
    'relation': relation,
    'gender': gender,
    'dob': dob,
    'adhar': adhar,
  };


}

