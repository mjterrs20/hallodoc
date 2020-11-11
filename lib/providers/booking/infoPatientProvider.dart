import 'package:hallodoc/models/infoPatient.dart';
import 'package:hallodoc/providers/baseProvider.dart';
import 'package:hallodoc/resources/local/infoPatienRepository.dart';
import 'package:hallodoc/utils/sharedpreferences.dart';
import 'package:sqflite/sqflite.dart';

class InfoPatientProvider extends BaseProvider {

  InfoPatientRepository dbHelper = InfoPatientRepository();

  List<InfoPatient> infopatients;

  PreferenceUtil appData = PreferenceUtil();
  int selected;

  bool _created = false;
  bool _updated = false;

  Future<void> getInfoPatientList() async {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      dbHelper.getinfopatientList().then((data) {
        setInfoPatients(data);
      });
    });
  }

  Future<void> getInfoPatient(id) async {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      dbHelper.getInfoPatient(id).then((data) {
        setInfoPatients(data);
      });
    });
  }

  Future<void> createInfoPatient(InfoPatient infoPatient) async {
    setLoading(true);
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      dbHelper.insert(infoPatient).then((_) {
        setLoading(false);
        setCreated(true);
      });
    });
  }

  setInfoPatients(value) {
    infopatients = value;
    notifyListeners();
  }

  List<InfoPatient> getInfoPatients() {
    return infopatients;
  }

  setCreated(val) {
    _created = val;
    notifyListeners();
  }

  bool isCreated() {
    return _created;
  }

  setUpdated(val) {
    _updated = val;
    notifyListeners();
  }

  bool isUpdated() {
    return _updated;
  }

  void saveSelected(int id) {
    try {
      appData.saveIntVariable("selectedPatient", id);
      checkSelected();
      notifyListeners();
    } catch(e) {
      print(e.toString());
    }
  }

  void checkSelected() {
    appData.getIntVariable("selectedPatient").then((result) {
      setSelected(result);
    }).catchError((e){
      print(e.toString());
    });
    notifyListeners();
  }

  void setSelected(value) {
    selected = value;
    notifyListeners();
  }

  int getSelected() {
    return selected;
  }
}