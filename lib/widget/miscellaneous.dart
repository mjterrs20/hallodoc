import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hallodoc/utils/colors.dart';
import 'package:hallodoc/utils/screenutil.dart';

/* [===========================[Standar Widget]===========================]
  [✓] appBar({@required String title, List<Widget> actions})                         - standar gradient appbar flutter
  [✓] nointernetDialog({@required BuildContext context})                             - No Internet dialog
  [✓] errorDialog({@required BuildContext context})                                  - dialog ketika ada error 
  [✓] loadingPageIndicator({@required BuildContext context})                         - Loading Indicator
  [✓] hallodocDialog({
    @required BuildContext context, 
    @required String title, 
    @required String content, 
    List<Widget> hallodocButton, 
    bool isDismissible
  })        - Standar Dialog
  [✓] hallodocButton({String buttonText, Function onPressed, double minWidth = 88.0, double height = 36.0})                    - Button
  [✓] hallodocDialogButton({String buttonText, Function onPressed})
  [✓] noData({String title, String subtitle, Widget button})                         - Widget ketika tidak ada data
  [✓] loadingData({double loadingIndicatorRadius = 10.0, String loadingTitle})       - Widget ketika data sedang di load
  */

//====================[HALLODOC STYLE]====================
class HallodocStyle {
  static TextStyle alertTitleStyle = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w800, fontFamily: 'Comfortaa');
  static TextStyle alertDescriptionStyle = TextStyle(
      fontSize: 14.0,
      fontFamily: 'Comfortaa',
      color: Color.fromRGBO(0, 0, 0, .6));
  static TextStyle alertButtonStyle = TextStyle(
      fontSize: 14.0, fontFamily: 'Comfortaa', color: TemaApp.redColor);
}
//====================[END]====================

//====================[HALLODOC WIDGET]====================
class HallodocWidget {
  static Widget appBar(
      {@required String title,
      List<Widget> actions,
      Widget leading,
      PreferredSizeWidget bottom}) {
    assert(title != null);
    return AppBar(
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: ScreenUtil().setSp(60),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions != null ? actions : <Widget>[],
      centerTitle: true,
      bottom: bottom,
    );
  }

  static Widget hallodocDialogButton(
      {@required String buttonText, Function onPressed}) {
    assert(buttonText != null);
    return FlatButton(
      child: Text(buttonText == null ? '' : buttonText,
          style: HallodocStyle.alertButtonStyle),
      onPressed: onPressed != null ? onPressed : () {},
    );
  }

  static Widget hallodocButton({
    @required String buttonText,
    Function onPressed,
    double minWidth = 88.0,
    double height = 36.0,
    Color color,
    BorderSide side,
    Color textColor = Colors.white,
  }) {
    assert(buttonText != null);
    return ButtonTheme(
      minWidth: minWidth,
      height: height,
      child: FlatButton(
        child: Text(
          buttonText == null ? '' : buttonText,
          style: TextStyle(color: textColor),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: side != null
              ? side
              : BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
        ),
        color: color != null ? color : TemaApp.redColor,
        onPressed: onPressed != null ? onPressed : () {},
      ),
    );
  }

  static Widget noData(
      {@required String title, @required String subtitle, Widget button}) {
    assert(title != null);
    assert(subtitle != null);
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title == null ? '' : title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              subtitle == null ? '' : subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.0, color: Colors.grey),
            ),
            SizedBox(height: 3.0),
            button != null ? button : Container()
          ],
        ),
      ),
    );
  }

  static Widget loadingData(
      {String loadingTitle = '', double loadingSize = 30.0}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SpinKitFadingCircle(
            size: loadingSize,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? TemaApp.redColor : TemaApp.purpleColor,
                ),
              );
            },
          ),
          SizedBox(height: 10.0),
          Text(loadingTitle)
        ],
      ),
    );
  }

  static hallodocDialog(
      {@required BuildContext context,
      @required String title,
      @required String content,
      List<Widget> buttons,
      bool isDismissible = true}) {
    assert(context != null);
    assert(title != null);
    assert(content != null);
    showGeneralDialog(
      context: context,
      barrierDismissible: isDismissible,
      transitionDuration: Duration(milliseconds: 150),
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.6),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (BuildContext context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: HallodocDialog(
              title: Text(title,
                  style: HallodocStyle.alertTitleStyle,
                  textAlign: TextAlign.center),
              content: Text(content, style: HallodocStyle.alertDescriptionStyle),
              buttonActions: buttons != null ? buttons : [],
            ),
          ),
        );
      },
    );
  }

  static nointernetDialog({@required BuildContext context}) {
    assert(context != null);
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 150),
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.6),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (BuildContext context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: HallodocDialog(
              title: Text("Tidak ada koneksi",
                  style: HallodocStyle.alertTitleStyle,
                  textAlign: TextAlign.center),
              content: Text(
                  "Sepertinya internet anda mati, silahkan nyalakan data koneksi terlebih dahulu.",
                  style: HallodocStyle.alertDescriptionStyle),
              buttonActions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: HallodocStyle.alertButtonStyle),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static errorDialog({@required BuildContext context}) {
    assert(context != null);
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 150),
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.6),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (BuildContext context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: HallodocDialog(
              title: Text("Oops",
                  style: HallodocStyle.alertTitleStyle,
                  textAlign: TextAlign.center),
              content: Text("Sepertinya ada kesalahan, silahkan coba lagi.",
                  style: HallodocStyle.alertDescriptionStyle),
              buttonActions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: HallodocStyle.alertButtonStyle),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static comingsoonDialog({@required BuildContext context}) {
    assert(context != null);
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 150),
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.6),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (BuildContext context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: HallodocDialog(
              title: Text("Informasi",
                  style: HallodocStyle.alertTitleStyle,
                  textAlign: TextAlign.center),
              content: Text("Fitur ini akan dirilis di update mendatang.",
                  style: HallodocStyle.alertDescriptionStyle),
              buttonActions: <Widget>[
                FlatButton(
                  child: Text('Ok', style: HallodocStyle.alertButtonStyle),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static loadingPageIndicator(
      {@required BuildContext context,
      String loadingText,
      double loadingSize = 30}) {
    assert(context != null);
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 100),
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.6),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (BuildContext context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
              opacity: a1.value,
              child: LoadingIndicator(
                loadingText: loadingText != null ? loadingText : '',
                loadingSize: loadingSize,
              )),
        );
      },
    );
  }
}
//====================[END]====================

//====================[LOADING INDICATOR]====================
class LoadingIndicator extends StatelessWidget {
  final String loadingText;
  final double loadingSize;
  LoadingIndicator({this.loadingText, this.loadingSize});

  Future<bool> _onWillPop() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      allowFontScaling: true,
    )..init(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: loadingText != ''
          ? Center(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SpinKitFadingCircle(
                      size: loadingSize,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven
                                ? TemaApp.redColor
                                : TemaApp.purpleColor,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(loadingText)
                  ],
                ),
              ),
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  dialogContent(context),
                ],
              ),
            ),
    );
  }

  dialogContent(BuildContext context) {
    return Center(
      child: Container(
        width: ScreenUtil().setWidth(150),
        height: ScreenUtil().setHeight(150),
        decoration: new BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: TemaApp.redColor),
          child: SpinKitFadingCircle(
            size: loadingSize,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? TemaApp.redColor : TemaApp.purpleColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
//====================[END]====================

//====================[HALLODOC DIALOG]====================
class HallodocDialog extends StatelessWidget {
  final Widget title, content;
  final List<Widget> buttonActions;

  HallodocDialog({
    this.title,
    @required this.content,
    this.buttonActions,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      allowFontScaling: true,
    )..init(context);

    return AlertDialog(
        title: title != null ? title : Container(),
        content: content,
        backgroundColor: Colors.white.withOpacity(0.9),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        actions: buttonActions != null ? buttonActions : <Widget>[]);
  }
}
//====================[END]====================

//====================[LIST ANIMATOR]====================
class Animator extends StatefulWidget {
  final Widget child;
  final Duration time;
  Animator(this.child, this.time);
  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  Timer timer;
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 290), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    timer = Timer(widget.time, animationController.forward);
  }

  @override
  void dispose() {
    timer.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0.0, (1 - animation.value) * 20),
            child: child,
          ),
        );
      },
    );
  }
}

Timer timer;
Duration duration = Duration();
wait() {
  if (timer == null || !timer.isActive) {
    timer = Timer(Duration(microseconds: 120), () {
      duration = Duration();
    });
  }
  duration += Duration(milliseconds: 100);
  return duration;
}

class HallodocListAnimator extends StatelessWidget {
  final Widget child;
  HallodocListAnimator({this.child});
  @override
  Widget build(BuildContext context) {
    return Animator(child, wait());
  }
}
//====================[END]====================

//====================[Hallodoc Loading Button]====================
const _kScaleHeight = 36;
const _kScaleFactor = 0.4;

class HallodocLoadingButton extends StatefulWidget {
  HallodocLoadingButton({
    Key key,
    this.child,
    @required this.onPressed,
    this.textTheme,
    this.textColor,
    this.color,
    this.onHighlightChanged,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.disabledTextColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.hoverElevation,
    this.focusElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.materialTapTargetSize,
    this.animationDuration,
    this.minWidth,
    this.height,
    this.indicatorOnly = false,
    this.indicatorColor,
    this.indicatorSize,
    this.loading = false,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final ButtonTextTheme textTheme;
  final ValueChanged<bool> onHighlightChanged;
  final Color textColor;
  final Color color;
  final Color disabledColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color disabledTextColor;
  final Color splashColor;
  final Brightness colorBrightness;
  final double elevation;
  final double focusElevation;
  final double hoverElevation;
  final double highlightElevation;
  final double disabledElevation;
  final EdgeInsetsGeometry padding;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final FocusNode focusNode;
  final MaterialTapTargetSize materialTapTargetSize;
  final Duration animationDuration;
  final double minWidth;
  final double height;

  final Color indicatorColor;
  final double indicatorSize;
  final bool indicatorOnly;
  final bool loading;

  @override
  State<HallodocLoadingButton> createState() => HallodocLoadingButtonState();
}

class HallodocLoadingButtonState extends State<HallodocLoadingButton> {
  @override
  Widget build(BuildContext context) {
    // warna
    final Color indColor =
        widget.indicatorColor ?? Theme.of(context).accentColor;
    // ukuran indikator
    double scaleFactor;
    if (widget.indicatorSize != null && widget.indicatorSize > 0) {
      scaleFactor = widget.indicatorSize / _kScaleHeight;
    } else {
      scaleFactor = (widget.height != null)
          ? _kScaleFactor * (widget.height / _kScaleHeight)
          : _kScaleFactor;
    }
    // area indikator
    final Widget indicator = Transform.scale(
        scale: scaleFactor,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation(indColor),
        ));

    Widget loadingChild;
    if (widget.loading && widget.indicatorOnly) {
      loadingChild = indicator;
    } else if (widget.loading && !widget.indicatorOnly) {
      loadingChild = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          indicator,
          SizedBox(width: 5.0 * scaleFactor),
          widget.child
        ],
      );
    } else {
      loadingChild = widget.child;
    }

    return MaterialButton(
      onPressed: widget.loading ? null : widget.onPressed,
      textTheme: widget.textTheme,
      color: widget.color,
      onHighlightChanged: widget.onHighlightChanged,
      disabledColor: widget.disabledColor,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      highlightColor: widget.highlightColor,
      textColor: widget.textColor,
      disabledTextColor: widget.disabledTextColor,
      splashColor: widget.splashColor,
      colorBrightness: widget.colorBrightness,
      elevation: widget.elevation,
      focusElevation: widget.focusElevation,
      hoverElevation: widget.hoverElevation,
      highlightElevation: widget.highlightElevation,
      disabledElevation: widget.disabledElevation,
      padding: widget.padding,
      shape: widget.shape,
      clipBehavior: widget.clipBehavior,
      focusNode: widget.focusNode,
      materialTapTargetSize: widget.materialTapTargetSize,
      animationDuration: widget.animationDuration,
      minWidth: widget.minWidth,
      height: widget.height,
      child: loadingChild,
    );
  }
}
//====================[END]====================

//====================[Countdown]====================
class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    Key key,
    int secondsRemaining,
    this.countDownTimerStyle,
    this.whenTimeExpires,
    this.countDownFormatter,
  })  : secondsRemaining = secondsRemaining,
        super(key: key);

  final int secondsRemaining;
  final Function whenTimeExpires;
  final Function countDownFormatter;
  final TextStyle countDownTimerStyle;

  State createState() => new _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Duration duration;

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  String get timerDisplayString {
    Duration duration = _controller.duration * _controller.value;
    return widget.countDownFormatter != null
        ? widget.countDownFormatter(duration.inSeconds)
        : formatHHMMSS(duration.inSeconds);
    // In case user doesn't provide formatter use the default one
    // for that create a method which will be called formatHHMMSS or whatever you like
  }

  @override
  void initState() {
    super.initState();
    duration = new Duration(seconds: widget.secondsRemaining);
    _controller = new AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller.reverse(from: widget.secondsRemaining.toDouble());
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.whenTimeExpires();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, Widget child) {
              return Text(
                timerDisplayString,
                style: widget.countDownTimerStyle,
              );
            }));
  }
}
