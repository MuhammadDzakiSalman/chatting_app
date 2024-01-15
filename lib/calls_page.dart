import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CallItem(
            contactName: 'John Doe',
            callType: CallType.incomingVoice,
            time: DateTime.now().subtract(Duration(minutes: 5)),
          ),
          CallItem(
            contactName: 'Jane Smith',
            callType: CallType.outgoingVideo,
            time: DateTime.now().subtract(Duration(hours: 1)),
          ),
          // Add more CallItem widgets for additional call history
        ],
      ),
    );
  }
}

enum CallType { incomingVoice, outgoingVoice, incomingVideo, outgoingVideo }

class CallItem extends StatelessWidget {
  final String contactName;
  final CallType callType;
  final DateTime time;

  const CallItem({
    Key? key,
    required this.contactName,
    required this.callType,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // You can use an image or initials based on your design
        child: Text(contactName[0]),
      ),
      title: Text(contactName),
      subtitle: Row(
        children: [
          Icon(
            callType == CallType.incomingVoice || callType == CallType.incomingVideo
                ? Icons.call_received
                : Icons.call_made,
            color: callType == CallType.incomingVoice || callType == CallType.incomingVideo
                ? Colors.green
                : Colors.red,
          ),
          SizedBox(width: 8),
          Text(
            DateFormat.Hm().format(time),
          ),
        ],
      ),
      trailing: Icon(
        callType == CallType.incomingVoice || callType == CallType.outgoingVoice
            ? Icons.call
            : Icons.videocam,
        color: Colors.blue,
      ),
      onTap: () {
        // Handle tap on the call item
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CallsPage(),
  ));
}
