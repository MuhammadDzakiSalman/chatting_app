import 'package:chatting_app/chating_page.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10, // Ganti dengan jumlah obrolan yang sebenarnya
        itemBuilder: (context, index) {
          return CardChatListItem(
            // Gantilah dengan data obrolan yang sesuai
            contactName: 'Contact $index',
            lastMessage: 'Last message from contact from contact $index',
            time: '12:34 PM',
            hasUnreadMessages: index % 2 == 0, // Contoh: setengah dari obrolan memiliki pesan belum dibaca
            onTap: () {
              // Navigasi ke halaman chatting saat card ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChattingPage(contactName: 'Contact $index'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CardChatListItem extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  final String time;
  final bool hasUnreadMessages;
  final VoidCallback onTap;

  const CardChatListItem({
    Key? key,
    required this.contactName,
    required this.lastMessage,
    required this.time,
    required this.hasUnreadMessages,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(1),
      elevation: 0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(contactName[0]),
        ),
        title: Text(contactName),
        subtitle: Text(
          _truncateText(lastMessage),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(time),
            SizedBox(width: 8), // Spacer antara waktu dan badge
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: -5, end: -5),
              badgeContent: Text('1', style: TextStyle(color: Colors.white)),
              showBadge: hasUnreadMessages,
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.red,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  String _truncateText(String text, {int maxLength = 50}) {
    return (text.length <= maxLength) ? text : '${text.substring(0, maxLength)}...';
  }
}
