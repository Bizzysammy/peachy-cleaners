import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerMessageScreen extends StatefulWidget {
  final String customerId;
  final String customerName;

  const CustomerMessageScreen({
    Key? key,
    required this.customerId,
    required this.customerName,
  }) : super(key: key);

  @override
  State<CustomerMessageScreen> createState() => CustomerMessageScreenState();
}

class CustomerMessageScreenState extends State<CustomerMessageScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.customerName} Messages',
          style: const TextStyle(color: Color(0xFFF9C4B4)),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D1F2D), // very dark mix
                Color(0xFF23313D), // somewhat dark mix
                Color(0xFF455A64), // light mix
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
                  .collection('messages')
                  .doc(widget.customerId)
                  .collection('userMessages')
                  .orderBy('timestamp', descending: true)
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
                    final bool isAdmin = message['role'] == 'admin'; // Admin identification logic

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
                    if (_messageController.text.trim().isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('messages')
                          .doc(widget.customerId)
                          .collection('userMessages')
                          .add({
                        'text': _messageController.text,
                        'timestamp': FieldValue.serverTimestamp(),
                        'name': 'Admin',
                        'profile_photo': null, // Set to null for admin
                        'role': 'admin',
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
      leading: CircleAvatar(
        backgroundImage: isAdmin
            ? const AssetImage('assets/logo.jpg')  // Correctly using AssetImage
            : profilePhotoUrl.isNotEmpty
            ? NetworkImage(profilePhotoUrl)  // NetworkImage for customer profile photos
            : null, // No image if customer profile photo is not available
        child: isAdmin || profilePhotoUrl.isNotEmpty
            ? null // No child widget for admin or if using Firebase profile photo for customer
            : const Icon(Icons.person), // Show person icon if no profile photo for customers
      ),
      title: Text(text),
      subtitle: Text(userName),
    );
  }
}
