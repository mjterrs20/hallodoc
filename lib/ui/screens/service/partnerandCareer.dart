import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/providers/content/contentProvider.dart';
import 'package:hallodoc/ui/widgets/content/serviceItem.dart';
import 'package:hallodoc/ui/widgets/content/serviceItemNews.dart';
import 'package:hallodoc/ui/widgets/content/serviceList.dart';
import 'package:provider/provider.dart';


class PartnerAndCareerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> ContentProvider(),
      child: PartnerAndCareerScreen(),
    );
  }
}

class PartnerAndCareerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<PartnerAndCareerScreen> {

  TextEditingController _controller = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  bool isSearching = false;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    textFieldFocus.dispose();
    super.dispose();
  }

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ContentProvider>(context, listen: false).fetchContent(query: null);
    });
  }

  Widget body() {
    return ListView(
      children: [
        divider("Partner"),
        Consumer<ContentProvider>(
          builder: (context, data, child) {
            if(!data.isExist()) {
              return Container();
            }
            Content contentLayanan = Content(data:data.getFilteredContent(data.getContent().data, 'Partner'));
            return Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 260,
              child: ServiceList(
                canScroll: true,
                scrollDirection: Axis.horizontal,
                content: contentLayanan,
                item: ServiceItem().itemSmall,
              )
            );
          },
        ),
        divider("Career"),
        Consumer<ContentProvider>(
          builder: (context, data, child) {
            if(!data.isExist()) {
              return Container();
            }
            Content contentPartner = Content(data: data.getFilteredContent(data.getContent().data, 'Career'));
            return Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ServiceList(
                canScroll: false,
                scrollDirection: Axis.vertical,
                content: contentPartner,
                item: ServiceItemNews().view
              )
            );
          },
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
          color: Color(0xffF5F6FC),
      ),
      child: TextFormField(
        focusNode: textFieldFocus,
        controller: _controller,
        onEditingComplete: () {
          if(_controller.text.isNotEmpty) {
            isSearching = true;
            Provider.of<ContentProvider>(context, listen: false).fetchContent(query: "/search?query=${_controller.text}");
          } else {
            isSearching = false;
            Provider.of<ContentProvider>(context, listen: false).fetchContent(query: null);
          }
          textFieldFocus.unfocus();
          setState(() {});
        },
        textInputAction: TextInputAction.done,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
          // isDense: true,
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Partner & Career"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchField(),
            Provider.of<ContentProvider>(context).isLoading() ?
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white, strokeWidth: 2,
                )
              )
            ) :
            Expanded(
              child: isSearching ? 
                ListView(
                  children: [
                    Consumer<ContentProvider>(
                      builder: (context, data, child) {
                        if(data.isLoading()) {
                          return Container(
                            height: ScreenUtil().screenHeight * .5,
                            margin: EdgeInsets.only(top: 100),
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white, strokeWidth: 2,
                              )
                            )
                          );
                        }

                        if(!data.isExist()) {
                          return Container(
                            height: ScreenUtil().screenHeight * .5,
                            margin: EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text("Tidak ada data yang cocok"),
                            )
                          );
                        }
                        return Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: ServiceList(
                            canScroll: false,
                            scrollDirection: Axis.vertical,
                            content: data.getContent(),
                            item: ServiceItemNews().view,
                          )
                        );
                      },
                    ),
                  ],
                ) : body(),
            )
          ],
        )
      ),
    );
  }
}