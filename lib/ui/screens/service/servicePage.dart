import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hallodoc/models/content.dart';
import 'package:hallodoc/providers/content/contentProvider.dart';
import 'package:hallodoc/ui/widgets/content/serviceItem.dart';
import 'package:hallodoc/ui/widgets/content/serviceItemNews.dart';
import 'package:hallodoc/ui/widgets/content/serviceList.dart';
import 'package:provider/provider.dart';


class Layanans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> ContentProvider(),
      child: LayananPage(),
    );
  }
}

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

  @override
  void initState() { 
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ContentProvider>(context, listen: false).fetchContent(query: null);
    });
  }

  Widget body() {
    return  ListView(
      children: [
        divider("Fasilitas & Layanan Terkini"),
        Consumer<ContentProvider>(
          builder: (context, data, child) {
            if(!data.isExist()) {
              return Container();
            }
            Content contentLayanan = Content(data: data.getFasilitas(data.getContent().data));
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
        divider("Event & Promo"),
        Consumer<ContentProvider>(
          builder: (context, data, child) {
            if(!data.isExist()) {
              return Container();
            }
            Content contentPromo = Content(data: data.getPromoAndEvent(data.getContent().data));
            return Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ServiceList(
                canScroll: false,
                scrollDirection: Axis.vertical,
                content: contentPromo,
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
          // color: Color(0xffF5F6FC),
          color: Colors.white),
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
        body: RefreshIndicator(
          onRefresh: _getData,
          child: Provider.of<ContentProvider>(context).isLoading() ?
          SingleChildScrollView(
            child: Container(
              height: ScreenUtil().screenHeight,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white, strokeWidth: 2,
                )
              )
            ),
          )
          :Column(
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
              // Provider.of<ContentProvider>(context).isLoading() ?
              // Container(
              //   margin: EdgeInsets.only(top: 100),
              //   child: Center(
              //     child: CircularProgressIndicator(
              //       backgroundColor: Colors.white, strokeWidth: 2,
              //     )
              //   )
              // ) :
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
          ),
        )
      ),
    );
  }
}