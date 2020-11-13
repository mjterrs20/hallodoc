import 'dart:convert';

import 'package:hallodoc/providers/baseProvider.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:hallodoc/ui/screens/chatbot/chatbot.dart';

class ChatbotProvider extends BaseProvider{
  Future<void> response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/key/kp-likvcc-55d8760cde3e.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    print(CardDialogflow(response.getListMessage()[0]).title);
    ChatMessage message = ChatMessage(
      text: response.getMessage() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: "Pabanang",
      type: false,
    );
    return  message;
    // setState(() {
    //   _messages.insert(0, message);
    // });
  }

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     ChatMessage message = ChatMessage(
//       text: text,
//       name: "Me",
//       type: true,
//     );
//     setState(() {
//       _messages.insert(0, message);
//     });
//     response(text);
//   }
  
}