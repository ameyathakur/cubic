class Document{
  String name, illness, doctor, dov, comments, category, documentUrl, ocr;
  List<String> tags = [];

  Document(this.name, this.illness, this.doctor, this.dov, this.comments,
      this.category, this.documentUrl, this.ocr, this.tags);

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'illness' : illness,
      'doctor' : doctor,
      'date of visit' : dov,
      'comments' : comments,
      'category' : category,
      'documentUrl' : documentUrl,
      'ocr' : ocr,
      'tags' : tags,
    };
  }
}