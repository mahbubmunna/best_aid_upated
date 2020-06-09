import 'package:bestaid/splash.dart';
import 'package:bestaid/src/repository/user_repository.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileChangeDialog extends StatefulWidget {
  VoidCallback onChanged;

  UserProfileChangeDialog({Key key, this.onChanged}) : super(key: key);

  @override
  _UserProfileChangeDialogState createState() => _UserProfileChangeDialogState();
}

class _UserProfileChangeDialogState extends State<UserProfileChangeDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();
  final nameController = TextEditingController(text: appUser.name);
  final weightController = TextEditingController(text: appUser.weight);
  DateTime dob = DateTime.now();
  final addressController = TextEditingController(text: appUser.location);
  final heightController = TextEditingController(text: appUser.height);
  final phoneController = TextEditingController(text: appUser.phone);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
         showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(Icons.people),
                    SizedBox(width: 10),
                    Text(
                      'Profile Settings',
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return DateTimeField(
                              decoration: getInputDecoration(hintText: '1996-12-31', labelText: 'Birth Date'),
                              format: new DateFormat('yyyy-MM-dd'),
                              initialValue: dob,
                              onSaved: (dateTime) { dob = dateTime;},
                              onShowPicker: (context, currentValue) async{
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                            );
                          },
                        ),
                        new TextFormField(
                          controller: weightController,
                          style: TextStyle(color: Theme.of(context).textTheme.subtitle.color),
                          keyboardType: TextInputType.number,
                          decoration: getInputDecoration(hintText: '60', labelText: 'Weight'),
                        ),
                        new TextFormField(
                          controller: addressController,
                          style: TextStyle(color: Theme.of(context).textTheme.subtitle.color),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'Mirpur 11, Block A, Road 1, House 11', labelText: 'Address'),
//                          validator: (input) => input.trim().length < 3 ? 'Not a valid full name' : null,
                        ),

                        new TextFormField(
                          controller: heightController,
                          style: TextStyle(color: Theme.of(context).textTheme.subtitle.color),
                          keyboardType: TextInputType.number,
                          validator: (height) => double.parse(height) > 8 || double.parse(height) < 4 ? 'not vaid value' : null,
                          decoration: getInputDecoration(hintText: '5.11', labelText: 'Height'),
                        ),
                        new TextFormField(
                          controller: phoneController,
                          style: TextStyle(color: Theme.of(context).textTheme.subtitle.color),
                          keyboardType: TextInputType.phone,
                          decoration: getInputDecoration(hintText: '01XXX XXXXXX', labelText: 'Phone'),
                        ),
//                        FormField<String>(
//                          builder: (FormFieldState<String> state) {
//                            return DropdownButtonFormField<String>(
//                              decoration: getInputDecoration(hintText: 'Female', labelText: 'Gender'),
//                              hint: Text("Select Device"),
//                              value: appUser.gender,
//                              onChanged: (input) {
//                                setState(() {
//                                  appUser.gender = input;
//                                  widget.onChanged();
//                                });
//                              },
//                              onSaved: (input) => appUser.gender = input,
//                              items: [
//                                new DropdownMenuItem(value: 'Male', child: Text('Male')),
//                                new DropdownMenuItem(value: 'Female', child: Text('Female')),
//                              ],
//                            );
//                          },
//                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Icon(Icons.edit, color: Colors.white,)
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() async {
    _profileSettingsFormKey.currentState.save();
    if (_profileSettingsFormKey.currentState.validate()) {
      Map updatedUserData = {
        'location' : addressController.text == null ? appUser.location : addressController.text,
        'phone' : phoneController.text == null ? appUser.phone : phoneController.text,
        'dob' : dob == null ? appUser.dob : dob.toIso8601String(),
        'weight' : weightController.text == null ? appUser.weight : weightController.text,
        'height' : heightController.text == null ? appUser.height : heightController.text,
      };
      await UserRepository.updateUserData(updatedUserData).then((response) {
        appUser = response.user;
        print(response.user);
      });
      widget.onChanged();
      Navigator.pop(context);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Your Profile data successfully updated'),));
    }

  }
}
