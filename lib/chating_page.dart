import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChattingPage extends StatefulWidget {
  final String contactName;

  const ChattingPage({
    Key? key,
    required this.contactName,
  }) : super(key: key);

  @override
  _ChattingPageState createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  // Dummy status pengguna (online atau offline)
  bool isUserOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _showProfileModal(context);
              },
              child: _buildProfileImage(),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contactName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                _buildStatusText(),
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
              // Aksi ketika salah satu opsi dipilih
              if (value == 'profile') {
                _showProfileModal(context);
              } else if (value == 'media') {
                // Aksi untuk menu "Media"
              } else if (value == 'hapus_chat') {
                // Aksi untuk menu "Hapus Chat"
              } else if (value == 'blokir') {
                // Aksi untuk menu "Blokir"
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Profile', 'Media', 'Hapus Chat', 'Blokir'}
                  .map((String choice) {
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
      backgroundImage: AssetImage('images/profile_dzaki.png'), // Ganti dengan path atau URL gambar profil
    );
  }

  Widget _buildStatusText() {
    return Text(
      isUserOnline ? 'Online' : 'Offline',
      style: TextStyle(
        color: isUserOnline ? Colors.black45 : Colors.white70,
        fontSize: 12,
      ),
    );
  }

  Widget _buildMessageList() {
    return Column(
      children: _messages.map((message) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: message.isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
            child: MessageBubble(
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
        _messages.add(ChatMessage(message, formattedTime, true));
        // Simulasi balasan dari pengguna lain
        _messages.add(ChatMessage('Hi, nice to meet you!', formattedTime, false));
      });
      _messageController.clear();
    }
  }

  void _showProfileModal(BuildContext context) {
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
                        widget.contactName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      _buildStatusText(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSentByUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isSentByUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isSentByUser
          ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2)
          : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
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
        crossAxisAlignment: isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
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

class ChatMessage {
  final String message;
  final String time;
  final bool isSentByUser;

  ChatMessage(this.message, this.time, this.isSentByUser);
}
