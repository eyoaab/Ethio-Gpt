import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:ethio_gpt/cors/widgets/common-app-bar.dart';
import 'package:ethio_gpt/cors/widgets/common-drawer.dart';
import 'package:ethio_gpt/dummy-data.dart';
import 'package:ethio_gpt/feutures/chat/presentation/widget/show-daily-history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  _ChatHistoryScreenState createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  void showSide() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> days = ["Today", "7 Days", "30 Days"];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMod =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      appBar: commonAppBar(action: showSide, context: context),
      drawer: const CommonDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: bgBoxDecoration(isDarkMod),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Chat History',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Theme.of(context).scaffoldBackgroundColor ==
                              Colors.black
                          ? Colors.white
                          : Colors.black,
                    )),
                const SizedBox(height: 10),
                ShowDailyContainer(
                    isDarkMod: isDarkMod,
                    title: days[0],
                    listChatRoomEntity: dummylistChatRoom),
                ShowDailyContainer(
                    isDarkMod: isDarkMod,
                    title: days[1],
                    listChatRoomEntity: dummylistChatRoom),
                ShowDailyContainer(
                    isDarkMod: isDarkMod,
                    title: days[2],
                    listChatRoomEntity: dummylistChatRoom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
