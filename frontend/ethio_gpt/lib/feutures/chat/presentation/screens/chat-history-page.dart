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
    return Scaffold(
      key: _scaffoldKey,
      appBar: commonAppBar(action: showSide, context: context),
      drawer: const CommonDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                Theme.of(context).scaffoldBackgroundColor == Colors.black
                    ? '/images/backgroun.png'
                    : '/images/whitebg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Chat History',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
                ShowDailyContainer(
                    title: days[0], listChatRoomEntity: dummylistChatRoom),
                ShowDailyContainer(
                    title: days[1], listChatRoomEntity: dummylistChatRoom),
                ShowDailyContainer(
                    title: days[2], listChatRoomEntity: dummylistChatRoom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
