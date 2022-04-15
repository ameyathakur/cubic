class MemberModel {
  String name, relation, gender, dob, adhar;
  bool deleted, subscribed;

  MemberModel(
      {this.name = '',
      this.relation = '',
      this.gender = '',
      this.dob = '',
      this.adhar = '',
      this.deleted = true,
      this.subscribed = false});

  factory MemberModel.fromJson(dynamic json) {
    MemberModel p = new MemberModel();
    p.name = json['name'];
    p.gender = json['gender'];
    p.dob = json['dob'];
    p.adhar = json['adhar'];
    p.relation = json['relation'];
    p.deleted = json['deleted'];
    p.subscribed = json['subscribed'];
    return p;
  }

  Map toJson() => {
        'name': name,
        'relation': relation,
        'gender': gender,
        'dob': dob,
        'adhar': adhar,
        'deleted': deleted,
        'subscribed': subscribed,
      };

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'relation': relation,
      'gender': gender,
      'dob': dob,
      'adhar': adhar,
      'deleted': deleted,
      'subscribed': subscribed,
    };
  }
}
