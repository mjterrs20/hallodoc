import 'package:flutter/material.dart';
import 'package:hallodoc/providers/chatbot/chatbotProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class ChatbotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatbotProvider(),
      child: _ChatbotPage(),
    );
  }
}

class _ChatbotPage extends StatefulWidget {
  @override
  __ChatbotPageState createState() => __ChatbotPageState();
}

class __ChatbotPageState extends State<_ChatbotPage> {
  int index = 2;
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<ChatbotProvider>(builder: (context, data, _) {
            return Row(children: [
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: "Butuh bantuan"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text)),
              ),
            ]);
          })),
    );
  }

  // void response(query) async {
  //   _textController.clear();
  //   AuthGoogle authGoogle =
  //       await AuthGoogle(fileJson: "assets/key/kp-likvcc-55d8760cde3e.json")
  //           .build();
  //   Dialogflow dialogflow =
  //       Dialogflow(authGoogle: authGoogle, language: Language.english);
  //   AIResponse response = await dialogflow.detectIntent(query);
  //   ChatMessage message = ChatMessage(
  //     text: response.getMessage() ??
  //         CardDialogflow(response.getListMessage()[0]).title,
  //     name: "Pabanang",
  //     type: false,
  //   );
  //   setState(() {
  //     _messages.insert(0, message);
  //   });
  // }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      name: "Me",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Provider.of<ChatbotProvider>(context).response(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbot"),
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          child: Text(
            'P',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.name, style: Theme.of(context).textTheme.subhead),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
          child: Text(
            this.name[0],
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.yellow,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
