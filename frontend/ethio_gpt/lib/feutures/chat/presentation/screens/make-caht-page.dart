import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/message-entiry.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_bloc.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_event.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_state.dart';
import 'package:ethio_gpt/feutures/chat/presentation/widget/message-send-widget.dart';
import 'package:ethio_gpt/feutures/chat/presentation/widget/show-list-of-messages.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_bloc.dart';
import 'package:ethio_gpt/feutures/meta-features/setting/bloc/setting_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  String? roomId;
  List<MessageEntity>? previousMessages;
  ChatScreen({super.key, this.roomId, this.previousMessages});

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

  List<MessageEntity> _messages = [];
  String _roomId = '';

  bool _isLoading = false;
  String? _errorMessage;

  void _sendMessage(bool isAmharic) {
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

    // emit the state
    context.read<ChatBloc>().add(ChatRequestEvent(
          prompt: userMessage,
          roomId: _roomId,
          isAmharic: isAmharic,
        ));
  }

  void _showDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    _roomId = widget.roomId ?? '';
    _messages = widget.previousMessages ?? [];
    // if (_messages.isNotEmpty) {
    //   _messages = _messages.reversed.toList();
    // }
    _scrollToBottom();
    context.read<SettingBloc>().add(CangeSetingEvent(0));
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
        body: BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is ChatResponseLoadingState) {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
            } else if (state is ChatResponseErrorState) {
              setState(() {
                _isLoading = false;
                _errorMessage = state.errorMessage;
              });
            } else if (state is ChatResponseLoadedState) {
              setState(() {
                _isLoading = false;
                _messages.add(MessageEntity(
                    content: state.chatResponseModel.response, isBot: true));
                _roomId = state.chatResponseModel.roomId;
              });
              _scrollToBottom();
            }
          },
          child: Container(
            decoration: bgBoxDecoration(isDarkMode),
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
                    action: () =>
                        _sendMessage(context.locale.languageCode == 'am'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
