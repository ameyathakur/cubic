class MemberModel{
  String name, relation, gender, dob, adhar;

  MemberModel({this.name = '', this.relation='', this.gender='', this.dob='', this.adhar=''});

  Map toJson() => {
    'name': name,
    'relation': relation,
    'gender': gender,
    'dob': dob,
    'adhar': adhar,
  };

}