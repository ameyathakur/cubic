import 'package:cubic/Custom%20Models/MemberModel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../UI/RegisterScreen.dart';


typedef OnDelete();


class FamilyMember extends StatefulWidget {
  final MemberModel memberModel;
  final state = _FamilyMemberState();
  final OnDelete onDelete;



  FamilyMember({Key? key, required this.memberModel, required this.onDelete}) : super(key: key);
  @override
  _FamilyMemberState createState() => state;
}

class _FamilyMemberState extends State<FamilyMember> {
  final form = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  String selectedGender='Select Gender';
  @override
  Widget build(BuildContext context) {
    return

        Material(
            color: Colors.white,
            child: Expanded(
      child: Form(child:
      Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(7)),
            child: Center(
              child: TextFormField(
                onChanged: (val) => widget.memberModel.name = val!,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    hintText: 'Name',
                    border: InputBorder.none),
              ),
            )),
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(7)),
            child: Center(
              child: TextFormField(
                onChanged: (val) => widget.memberModel.relation = val!,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    hintText: 'Relation',
                    border: InputBorder.none),
              ),
            )),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1.5),
              borderRadius: BorderRadius.circular(7)),


          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                    hint: Text(
                      'Select Gender',
                    ),
                    items: genders
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),
                    value: selectedGender,
                    // value: selectedValue,
              onChanged: (val) => {widget.memberModel.gender = val.toString(),
              setState(() {
              selectedGender = val.toString();
              })}

              )),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Date of Birth',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Flexible(
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(7)),
                  child: Center(
                    child: TextFormField(
                      controller: dateinput,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10.0),
                          border: InputBorder.none),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900, 1),
                          lastDate: DateTime.now(),
                        ).
                        then((pickedDate) {

                          var date = DateTime.parse(
                              pickedDate.toString());
                          var formattedDate =
                              "${date.day}-${date.month}-${date.year}";
                          widget.memberModel.dob = formattedDate;
                          dateinput.text = formattedDate;
                        });
                      }),
                  )),
            ),

          ],

        ),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                padding: EdgeInsets.fromLTRB(
                    0, 10, 10, 20),
                color: Colors.red,
                onPressed: widget.onDelete,
                icon: Icon(Icons.delete)))
      ],
      ) )));
  }



}
