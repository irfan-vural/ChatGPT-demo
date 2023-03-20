import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chat_messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  late OpenAI api;
  StreamSubscription? _subscription;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT Demo'),
      ),
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return _messages[index];
            },
          )),
          Container(
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(20),
                border:
                    Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            child: buildTextComposer(),
          )
        ],
      ),
    );
  }

  sendMessage() {
    ChatMessage message = ChatMessage(
      text: _textEditingController.text,
      sender: 'Me',
    );
    setState(() {
      _messages.insert(0, message);
    });
    _textEditingController.clear();
  }

  buildTextComposer() {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: TextField(
            onSubmitted: (value) {
              sendMessage();
            },
            controller: _textEditingController,
            decoration:
                InputDecoration.collapsed(hintText: 'Send a message...'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            sendMessage();
          },
        )
      ],
    ).px16();
  }
}
