import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CleanerMessageScreen extends StatefulWidget {
  final String cleanerId;
  final String cleanerName;

  const CleanerMessageScreen({
    Key? key,
    required this.cleanerId,
    required this.cleanerName,
  }) : super(key: key);

  @override
  State<CleanerMessageScreen> createState() => CleanerMessageScreenState();
}

class CleanerMessageScreenState extends State<CleanerMessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.cleanerName} messages',
          style: const TextStyle(color: Color(0xFFF9C4B4)),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF111217), // very dark mix
                Color(0xFF1b2232), // somewhat dark mix
                Color(0xFF253863), // light mix
              ],
              stops: [0.0, 0.5, 1.0],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Cleaner messages')
                  .doc(widget.cleanerId)
                  .collection('userMessages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final messages = snapshot.data?.docs;
                if (messages == null || messages.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index].data() as Map<String, dynamic>;
                    final String text = message['text'] ?? '';
                    final String userName = message['name'] ?? '';
                    final String profilePhotoUrl = message['profile_photo'] ?? '';
                    final bool isAdmin = message['role'] == 'admin'; // Adjust based on your admin identification logic

                    return MessageWidget(
                      text: text,
                      userName: userName,
                      profilePhotoUrl: profilePhotoUrl,
                      isAdmin: isAdmin,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Message',
                    ),
                    controller: _messageController,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111217),
                  ),
                  onPressed: () async {
                    const adminName = 'Admin'; // Assuming the admin name is fixed or retrieved from context
                    const profilePhotoUrl = 'assets/logo.jpg'; // Assuming the admin profile photo is fixed

                    if (_messageController.text.trim().isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection('Cleaner messages')
                          .doc(widget.cleanerId)
                          .collection('userMessages')
                          .add({
                        'text': _messageController.text,
                        'timestamp': FieldValue.serverTimestamp(),
                        'name': adminName,
                        'profile_photo': profilePhotoUrl,
                        'role': 'admin', // Indicate that the sender is an admin
                      });

                      _messageController.clear(); // Clear input field after sending
                    } else {
                      print('Cannot send an empty message.');
                    }
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(color: Color(0xFFF9C4B4)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  final String userName;
  final String profilePhotoUrl;
  final bool isAdmin;

  const MessageWidget({
    Key? key,
    required this.text,
    required this.userName,
    required this.profilePhotoUrl,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isAdmin
          ? const CircleAvatar(
        backgroundImage: AssetImage('assets/logo.jpg'), // Admin's profile image
      )
          : profilePhotoUrl.isNotEmpty
          ? CircleAvatar(
        backgroundImage: NetworkImage(profilePhotoUrl), // Cleaner's profile image
      )
          : const CircleAvatar(
        child: Icon(Icons.person), // Default person icon for cleaners without profile photo
      ),
      title: Text(text),
      subtitle: Text(userName),
    );
  }
}
