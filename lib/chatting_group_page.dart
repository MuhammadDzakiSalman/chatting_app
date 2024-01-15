import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChattingGroupPage extends StatefulWidget {
  final String groupName;

  const ChattingGroupPage({
    Key? key,
    required this.groupName,
  }) : super(key: key);

  @override
  _ChattingGroupPageState createState() => _ChattingGroupPageState();
}

class _ChattingGroupPageState extends State<ChattingGroupPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<GroupChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _showGroupInfoModal(context);
              },
              child: _buildProfileImage(),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.groupName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // Aksi ketika tombol call ditekan
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              // Aksi ketika tombol videocam ditekan
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                _showGroupInfoModal(context);
              } else if (value == 'media') {
                // Aksi untuk menu "Media"
              } else if (value == 'hapus_chat') {
                // Aksi untuk menu "Hapus Chat"
              } else if (value == 'blokir') {
                // Aksi untuk menu "Blokir"
              } else if (value == 'tambah_anggota') {
                // Aksi untuk menu "Tambah Anggota"
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'Profile',
                'Media',
                'Hapus Chat',
                'Blokir',
                'Tambah Anggota'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase().replaceAll(' ', '_'),
                  child: Text(choice),
                );
              }).toList();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  _buildMessageList(),
                ],
              ),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage(
          'images/profile_dzaki.png'), // Ganti dengan path atau URL gambar profil
    );
  }

  Widget _buildMessageList() {
    return Column(
      children: _messages.map((message) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: message.isSentByUser
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: GroupMessageBubble(
              username: 'Dzaki',
              message: message.message,
              time: message.time,
              isSentByUser: message.isSentByUser,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            },
            color: Colors.blue,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat.Hm().format(now);
      setState(() {
        _messages.add(GroupChatMessage(message, formattedTime, true));
        // Simulasi balasan dari anggota grup lain
        _messages.add(
            GroupChatMessage('Hi, nice to meet you!', formattedTime, false));
      });
      _messageController.clear();
    }
  }

  void _showGroupInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileImage(),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.groupName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Created by: Dzaki',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Created at: ${DateFormat.yMMMMd().format(DateTime.now())}',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Members: 5',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Members:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildGroupMembers(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGroupMembers() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  'images/profile_dzaki.png'), // Ganti dengan path atau URL gambar profil anggota grup
            ),
          );
        },
      ),
    );
  }
}

class GroupMessageBubble extends StatelessWidget {
  final String username; // Tambahkan parameter untuk nama pengguna
  final String message;
  final String time;
  final bool isSentByUser;

  const GroupMessageBubble({
    Key? key,
    required this.username,
    required this.message,
    required this.time,
    required this.isSentByUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: isSentByUser ? 64 : 8,
        right: isSentByUser ? 8 : 64,
        top: 8,
        bottom: 8,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSentByUser ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align nama pengguna ke kiri
        children: [
          isSentByUser
              ? SizedBox
                  .shrink() // Jangan tampilkan nama pengguna untuk pesan yang dikirim oleh pengguna
              : Text(
                  username,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          Text(
            message,
            style: TextStyle(
              color: isSentByUser ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 10,
              color: isSentByUser ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class GroupChatMessage {
  final String message;
  final String time;
  final bool isSentByUser;

  GroupChatMessage(this.message, this.time, this.isSentByUser);
}
