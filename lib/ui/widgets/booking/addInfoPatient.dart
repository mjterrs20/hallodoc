import 'package:flutter/material.dart';
import 'package:hallodoc/models/infoPatient.dart';
import 'package:hallodoc/providers/booking/infoPatientProvider.dart';
import 'package:provider/provider.dart';

class AddInfoPatiens extends StatefulWidget {

  final Function callback;
  AddInfoPatiens({this.callback});

  @override
  State<StatefulWidget> createState() {
    return _AddInfoPatien();
  }
}

class _AddInfoPatien extends State<AddInfoPatiens> {
  final _formKey = GlobalKey<FormState>();
  String jenisKelamin = '';
  int selectedRadioJenKel = 0;
  bool checkJenisKelamin = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  setSelectedJenKel(int val) {
    setState(() {
      selectedRadioJenKel = val;
      if (val == 1) {
        jenisKelamin = "laki-laki";
      } else {
        jenisKelamin = "perempuan";
      }
    });
  }


  List _statuses = ["Pilih Salah satu","Saya Sendiri", "Anak"," Ibu", "Ayah", "Lainnya"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _status;

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _status = _dropDownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String status in _statuses) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: status,
          child: new Text(
            status,
            style: TextStyle(
              color: Colors.grey
            ),
          )
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InfoPatientProvider>(
      create: (context) => InfoPatientProvider(),
      child:  Form(
        key: _formKey,
        child: Consumer<InfoPatientProvider>(
          builder: (context, data, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, bottom: 15, right: 15),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintStyle: new TextStyle(
                            color: Colors.grey[500],
                            fontFamily: 'Poppins',
                            fontSize: 16.0),
                        hintText: "Nama Lengkap",
                        fillColor: Colors.white70),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Tidak boleh kosong';
                      }
                      return null;
                    }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Text(
                    "Jenis Kelamin",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                // sex
                Padding(
                  padding: EdgeInsets.only(bottom: 10, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: selectedRadioJenKel,
                            onChanged: (val) {
                              setSelectedJenKel(val);
                            },
                          ),
                          GestureDetector(
                            onTap: () => setSelectedJenKel(0),
                            child: new Text(
                              'Perempuan',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: selectedRadioJenKel,
                            onChanged: (val) {
                              setSelectedJenKel(val);
                            },
                          ),
                          GestureDetector(
                            onTap: () => setSelectedJenKel(1),
                            child: new Text(
                              'Laki-laki',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      checkJenisKelamin == true
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Text("Harus diisi",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12)),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Text(
                    "Status",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: new DropdownButton(
                      value: _status,
                      iconEnabledColor: Colors.grey,
                      underline: SizedBox(),
                      isExpanded: true,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                  ),
                ),
                // button create account
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Align(
                        child: 
                          data.isLoading() ?
                          CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 2,) :
                          Text('Simpan', style: TextStyle(color: Colors.white),),
                      ), onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (selectedRadioJenKel != null && _status != _statuses[0]) {
                            widget.callback('anjeng');
                            Provider.of<InfoPatientProvider>(context).createInfoPatient(
                              InfoPatient.fromMap({
                                  "name": nameController.text,
                                  "status": _status,
                                  "sex": selectedRadioJenKel,
                              })
                            ).then((value) {
                              if(data.isCreated()) {
                                print("berhasil");
                                Navigator.pop(context);
                              }
                            });
                          } else {
                            setState(() {
                              checkJenisKelamin = false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      )
    );
  }


  void changedDropDownItem(String status) {
    print("Selected city $status, we are going to refresh the UI");
    setState(() {
      _status = status;
    });
  }
}