import 'package:ethio_gpt/feutures/chat/domain/entity/chat-room-entity.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/history-entity.dart';
import 'package:ethio_gpt/feutures/chat/domain/entity/message-entiry.dart';
import 'package:ethio_gpt/feutures/meta-features/FAQ/domain/entiry/faq-entity.dart';

List<MessageEntity> dummyMessage = [
  MessageEntity(
      content:
          "Here’s an improved version of your chatHistoryRow function with the following enhancements:Fixed Message Index Issue: chatRoomEntity.messages[-1] is incorrect; use chatRoomEntity.messages.last instead.Spacing and Alignment: Added mainAxisAlignment for better spacing between elements",
      isBot: true),
  MessageEntity(content: "I need help with my order.", isBot: false),
];

List<ChatRoomEntity> dummylistChatRoom = [
  ChatRoomEntity(id: "chat_001", messages: dummyMessage),
  ChatRoomEntity(
    id: "chat_002",
    messages: dummyMessage,
  ),
  ChatRoomEntity(id: "chat_003", messages: dummyMessage),
];

ChatHistoryEntity dummyChathistory = ChatHistoryEntity(
    old: dummylistChatRoom,
    today: dummylistChatRoom,
    yestarday: dummylistChatRoom);

ChatRoomEntity dummySingleRoom =
    ChatRoomEntity(id: "chat_001", messages: dummyMessage);

List<FaqEntity> dummyFaq = [
  FaqEntity(
    question: 'What information do we collect?',
    answer:
        'We collect only the necessary personal information required to provide our services, such as your name, email, and usage data.',
  ),
  FaqEntity(
    question: 'How do we use your information?',
    answer:
        'Your information is used to improve our services, personalize your experience, and communicate important updates.',
  ),
  FaqEntity(
    question: 'Do we share your data with third parties?',
    answer:
        'No, we do not sell or share your personal data with third parties, except when required by law.',
  ),
  FaqEntity(
    question: 'How do we protect your data?',
    answer:
        'We implement industry-standard security measures to prevent unauthorized access, disclosure, or modification of your personal data.',
  ),
  FaqEntity(
    question: 'Can I request my data to be deleted?',
    answer:
        'Yes, you can request data deletion by contacting our support team via support@example.com.',
  ),
  FaqEntity(
    question: 'Do we use cookies?',
    answer:
        'Yes, we use cookies to enhance your browsing experience and analyze site traffic. You can manage cookie preferences in your browser settings.',
  ),
  FaqEntity(
    question: 'How can I contact you for privacy concerns?',
    answer:
        'For any privacy-related inquiries, please reach out to us at privacy@example.com.',
  ),
  FaqEntity(
    question: 'Will this policy change?',
    answer:
        'We may update our privacy policy periodically. Any changes will be communicated through our website or email notifications.',
  ),
  FaqEntity(
    question: 'How long do we retain your data?',
    answer:
        'We retain collected information only as long as necessary to provide services or as required by law.',
  ),
  FaqEntity(
    question: 'Do we comply with data protection laws (e.g., GDPR, CCPA)?',
    answer:
        'Yes, we comply with all relevant data protection laws, including GDPR and CCPA, to ensure your data privacy.',
  ),
];
