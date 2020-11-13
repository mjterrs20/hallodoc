import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/providers/baseProvider.dart';

class BaseContentProvider extends BaseProvider {

  Content content;

  void setContent(value) {
    content = value;
    notifyListeners();
  }

  Content getContent() { 
    return content;
  }

  List<Data> getFasilitas(List<Data> data, ) {
    List<Data> listData = List<Data>();
    for(int i =0; i < data.length; i ++) {
      if(data[i].category == "Fasilitas" || data[i].category == "Layanan") {
        listData.add(data[i]);
      }
    }
    return listData;
  }

  List<Data> getPromoAndEvent(List<Data> data, ) {
    List<Data> listData = List<Data>();
    for(int i =0; i < data.length; i ++) {
      if(data[i].category == "Promo" || data[i].category == "Event") {
        listData.add(data[i]);
      }
    }
    return listData;
  }

  List<Data> getFilteredContent(List<Data> data, filter) {
    List<Data> listData = List<Data>();
    for(int i =0; i < data.length; i ++) {
      if(data[i].category ==  filter) {
        listData.add(data[i]);
      }
    }
    return listData;
  }

  bool isExist() {
    return content != null && content.data.isNotEmpty;
  }
}