import 'package:cloud_firestore/cloud_firestore.dart';

class Document{
  String name, illness, doctor, dov, comments, category, id;
  List<String> tags = [];
  List<String> images = [];

  Document(this.name, this.illness, this.doctor, this.dov, this.comments,
      this.category, this.images, this.tags, this.id);

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'illness' : illness,
      'doctor' : doctor,
      'date of visit' : dov,
      'comments' : comments,
      'category' : category,
      'images' : images,
      'tags' : tags,
      'id' : id
    };
  }
}