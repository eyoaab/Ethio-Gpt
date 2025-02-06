import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/message-entiry.dart';
import 'package:ethio_gpt/feutures/chat/presentation/widget/message-send-widget.dart';
import 'package:ethio_gpt/feutures/chat/presentation/widget/show-list-of-messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  final List<MessageEntity> _messages = [
    MessageEntity(
        content:
            'ነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝ',
        isBot: false),
    MessageEntity(
        content:
            'ነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝነኝ',
        isBot: true),
  ];

  bool _isLoading = false;
  String? _errorMessage;

  void _sendMessage() {
    if (_isLoading || _messageController.text.isEmpty) return;

    final userMessage = _messageController.text.trim();
    setState(() {
      _messages.add(MessageEntity(content: userMessage, isBot: false));
      _isLoading = true;
      _messageController.clear();
      _errorMessage = null;
    });
    _scrollToBottom();
    FocusScope.of(context).unfocus();

    // BlocProvider.of<ChatBloc>(context).add(GetChatEvent(message: userMessage));
  }

  void _showDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      appBar: commonAppBar(action: _showDrawer, context: context),
      drawer: const CommonDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                isDarkMode ? '/images/backgroun.png' : '/images/whitebg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // widget to show list of messages
            listMessagesWidget(
                messagesList: _messages,
                isLoading: _isLoading,
                errorMessage: _errorMessage,
                isDarkMode: isDarkMode,
                scrollController: _scrollController),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              // widget to send message
              child: searchArea(
                isDarkMod: isDarkMode,
                controller: _messageController,
                action: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
