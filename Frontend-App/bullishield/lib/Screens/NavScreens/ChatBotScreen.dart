import 'dart:convert';
import 'dart:io';

import 'package:bullishield/backend.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  List<Message> messages = [];

  TextEditingController _textEditingController = TextEditingController();

  void sendMessage(String message) async {
    setState(() {
      messages.add(Message(sender: 'You', message: message));
    });
    var response;
    // Make a request to the Bard API
    Backend backend = Backend();
    String backendMeta = backend.backendMeta;
    String chatbotUrl = "$backendMeta/apis/chatbot";
    response =
        await http.post(Uri.parse(chatbotUrl), body: {'user_message': message});
    
    if (response.statusCode == 200) {
      final botResponse = jsonDecode(response.body);
      
      String botMessage = botResponse['ai_message'];
      
      setState(() {
        messages.add(Message(sender: 'Chat Bot', message: botMessage));
      });
    }
    else if(response.statusCode==400){
      if(Platform.isAndroid){
        Fluttertoast.showToast(
          msg: "Please wait a moment and try again later!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }else if(Platform.isWindows){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please wait a moment and try again later!"),
          ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Feel Free Talking To Our ChatBot',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.grey.shade200,
                      child: Text(
                        'Chat Bot',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return MessageBubble(
                            sender: messages[index].sender,
                            message: messages[index].message,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                hintText: 'Type your message...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              String message = _textEditingController.text;
                              if (message.isNotEmpty) {
                                sendMessage(message);
                                _textEditingController.clear();
                              }
                            },
                            child: Text('Send'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String sender;
  final String message;

  Message({required this.sender, required this.message});
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;

  const MessageBubble({
    required this.sender,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(message),
        ],
      ),
    );
  }
}
