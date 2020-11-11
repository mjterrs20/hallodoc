import 'package:flutter/material.dart';
import 'package:hallodoc/models/infoPatient.dart';
import 'package:hallodoc/providers/booking/infoPatientProvider.dart';
import 'package:hallodoc/ui/widgets/booking/addInfoPatient.dart';
import 'package:provider/provider.dart';

class InfoPatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InfoPatientProvider>(
      create: (context) => InfoPatientProvider(),
      child: _InfoPatientScreen(),
    );
  }
}

class _InfoPatientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<_InfoPatientScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InfoPatientProvider>(context).getInfoPatientList();
      Provider.of<InfoPatientProvider>(context).checkSelected();
    });
  }

  void callback(val) {
    if(val != null) {
      Navigator.pop(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<InfoPatientProvider>(context).getInfoPatientList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ganti Pasien"),
        ),
        body: Consumer<InfoPatientProvider>(
          builder: (context, data, _) {
            int selected = data.getSelected() != null ? data.getSelected() : 0;
            if(data.getInfoPatients() == null) {
              return Center(
                  child:
                      CircularProgressIndicator(
                backgroundColor: Colors.blue,
                strokeWidth: 2,
              ));
            }
            if(data.getInfoPatients().isEmpty) {
              return Center(
                child: Text("Tidak ada data"),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: data.getInfoPatients().length,
              itemBuilder: (context, index) {
                InfoPatient patient = data.getInfoPatients()[index];
                return GestureDetector(
                  onTap: () {
                    Provider.of<InfoPatientProvider>(context).saveSelected(patient.id);
                    Provider.of<InfoPatientProvider>(context).checkSelected();
                    Navigator.pop(context, patient);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama : ${patient.name}"),
                              Text("Jenis Kelamin : ${patient.sex == 1 ? 'Laki-laki' : 'Perempuan'}"),
                              Text("Status : ${patient.status}")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: selected == patient.id ? Icon(
                            Icons.check_circle_outline_outlined,
                            color: selected == patient.id ? Colors.blue : Colors.grey,
                          ):Container(),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BottomSheetCreate(callback: callback,),
                ),
              ),
            );
          },
          tooltip: 'Add',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class BottomSheetCreate extends StatelessWidget {

  final Function callback;
  BottomSheetCreate({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                width: 40.0,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Tambah Info Pasien',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
              ),
            ),
            AddInfoPatiens(callback: callback,),
          ],
        ),
      ),
    );
  }
}