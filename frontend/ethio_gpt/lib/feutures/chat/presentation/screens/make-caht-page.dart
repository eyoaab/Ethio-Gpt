import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/feutures/chat/presentation/widget/message-send-widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  // Function to send message
  void _sendMessage() {}

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: commonAppBar(action: showSide),
        drawer: const CommonDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroun.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: searchArea(
                    controller: _messageController,
                    action: _sendMessage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
