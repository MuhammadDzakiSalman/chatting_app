import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:chatting_app/chatting_group_page.dart'; // Sesuaikan dengan nama file chatting_group_page.dart

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10, // Ganti dengan jumlah grup yang sebenarnya
        itemBuilder: (context, index) {
          return CardGroupListItem(
            // Gantilah dengan data grup yang sesuai
            groupName: 'Group $index',
            lastMessage: 'Contact $index: Last message from group $index',
            time: '12:34 PM',
            hasUnreadMessages: index % 2 == 0, // Contoh: setengah dari grup memiliki pesan belum dibaca
            onTap: () {
              // Navigasi ke halaman chatting_group_page saat card ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChattingGroupPage(groupName: 'Group $index'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CardGroupListItem extends StatelessWidget {
  final String groupName;
  final String lastMessage;
  final String time;
  final bool hasUnreadMessages;
  final VoidCallback onTap;

  const CardGroupListItem({
    Key? key,
    required this.groupName,
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
          child: Text(groupName[0]),
        ),
        title: Text(groupName),
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
