import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/resources/content/contentRepository.dart';
import 'package:hallodoc/ui/widgets/content/serviceList.dart';

class LayananPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LayananState();
  }
}

class _LayananState extends State<LayananPage> {

  TextEditingController _controller = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  bool isSearching = false;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    textFieldFocus.dispose();
    super.dispose();
  }

  Widget searchResult() {
    return FutureBuilder(
      future: ContentRepository().getContent(filter: "/search?query=${_controller.text}"),
      builder: (context, snapshot) {
        print(snapshot);
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return  Container(
          padding: EdgeInsets.only(left: 15, right: 10),
          child: ServiceList(
            canScroll: false,
            scrollDirection: Axis.vertical,
            content: snapshot.data,
          )
        );
      },
    );
  }

  Widget body() {
    return ListView(
      children: [
        divider("Fasilitas & Layanan Terkini"),
        futureBuilder(
          canScroll: true,
          heigth: 260,
          scrollDirection: Axis.horizontal,
          filter: "?category[]=fasilitas&category[]=layanan"
        ),
        divider("Event & Promo"),
        futureBuilder(
          canScroll: false,
          heigth: ScreenUtil().screenHeight,
          scrollDirection: Axis.vertical,
          filter: "?category[]=event&category[]=promo"
        ),
      ],
    );
  }

  Widget searchField() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 30, left: 15, right: 20, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: Color(0xffF5F6FC),
          color: Colors.white),
      child: TextFormField(
        focusNode: textFieldFocus,
        controller: _controller,
        onEditingComplete: () {
          if(_controller.text.isNotEmpty) {
            isSearching = true;
          } else {
            isSearching = false;
          }
          FocusScope.of(context).unfocus();
          setState(() {});
        },
        textInputAction: TextInputAction.done,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 1.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.grey, width: 0.1),
          ),
        ),
      ),
    );
  }

  Widget divider(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 10, top: 25, bottom: 10),
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(40),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget futureBuilder({@required bool canScroll,  @required Axis scrollDirection, @required double heigth, String filter}) {
    return FutureBuilder(
      future: ContentRepository().getContent(filter: filter),
      builder: (context, snapshot) {
        print(snapshot);
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return  Container(
          height: scrollDirection == Axis.horizontal ? heigth : null,
          padding: EdgeInsets.only(left: 15, right: 10),
          child: ServiceList(
            canScroll: canScroll,
            scrollDirection: scrollDirection,
            content: snapshot.data,
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, left: 20, right: 10),
              child: Text("Layanan",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(50),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            searchField(),
            Expanded(
              child: isSearching ? 
                ListView(
                  children: [
                    searchResult()
                  ],
                ) : body(),
            )
          ],
        )
      ),
    );
  }
}