import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/cors/widgets/common-snackbar.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_bloc.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_event.dart';
import 'package:ethio_gpt/feutures/chat/presentation/bloc/chat_state.dart';
import 'package:ethio_gpt/feutures/chat/presentation/widget/show-daily-history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  _ChatHistoryScreenState createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> days = ["Today", "Yesterday ", "30 Days"];
  bool isLoading = true;
  bool isDeleting = false;
  String errorMessage = '';
  ChatHistoryEntity chatHistoryEntity =
      ChatHistoryEntity(old: [], today: [], yestarday: []);

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ChatHistoryEvent());
  }

  void showSide() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      appBar: commonAppBar(action: showSide, context: context),
      drawer: const CommonDrawer(),
      body: Container(
        width: double.infinity,
        decoration: bgBoxDecoration(isDarkMode),
        child: BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is ChatHistoryLoadingState) {
              isLoading = true;
              errorMessage = '';
            } else if (state is ChatHistoryLoadedState) {
              isLoading = false;
              chatHistoryEntity = state.chatHistory;
            } else if (state is ChatHistoryErrorState) {
              isLoading = false;
              errorMessage = state.errorMessage;
            } else if (state is DeleteChatHistoryLoadingState) {
              isDeleting = true;
              errorMessage = '';
            } else if (state is DeleteChatHistoryLoadedState) {
              isDeleting = false;
              showCustomSnackBar(
                  context, 'Chat History Deleted Successfully', true);
              context.read<ChatBloc>().add(ChatHistoryEvent());
            } else if (state is DeleteChatHistoryErrorState) {
              isDeleting = false;
              showCustomSnackBar(context, state.errorMessage, false);
              context.read<ChatBloc>().add(ChatHistoryEvent());
            }
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat History',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                if (isLoading || isDeleting)
                  const Center(child: CircularProgressIndicator()),
                if (errorMessage.isNotEmpty)
                  Center(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                if (!isLoading && !isDeleting && errorMessage.isEmpty) ...[
                  if (chatHistoryEntity.today.isNotEmpty)
                    ShowDailyContainer(
                      isDarkMod: isDarkMode,
                      title: days[0],
                      listChatRoomEntity: chatHistoryEntity.today,
                    ),
                  if (chatHistoryEntity.yestarday.isNotEmpty)
                    ShowDailyContainer(
                      isDarkMod: isDarkMode,
                      title: days[1],
                      listChatRoomEntity: chatHistoryEntity.yestarday,
                    ),
                  if (chatHistoryEntity.old.isNotEmpty)
                    ShowDailyContainer(
                      isDarkMod: isDarkMode,
                      title: days[2],
                      listChatRoomEntity: chatHistoryEntity.old,
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
