import 'package:flutter/material.dart';
import 'package:peachy/Cleaners/cleanersbottomnav.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peachy/cleaner_auth_provider.dart';

class CleanerMessages extends StatefulWidget {
  const CleanerMessages({Key? key}) : super(key: key);
  static const String id = 'cleanermessages';

  @override
  State<CleanerMessages> createState() => CleanerMessagesState();
}

class CleanerMessagesState extends State<CleanerMessages> {
  final TextEditingController _messageController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: context.watch<CleanerAuthProvider>().getCleanerName(),
      builder: (context, cleanerNameSnapshot) {
        if (cleanerNameSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (cleanerNameSnapshot.hasError) {
          return const Center(child: Text('Error fetching cleaner data'));
        } else if (cleanerNameSnapshot.data == 'Unknown') {
          return const Center(child: Text('No cleaner found.'));
        } else {
          final cleanerName = cleanerNameSnapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                '$cleanerName messages',
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
            bottomNavigationBar: const Cleanersbottomnav(),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Cleaner messages')
                        .doc(userId)
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
                          final cleanerName = await context.read<CleanerAuthProvider>().getCleanerName();
                          final profilePhotoUrl = await getProfilePhoto(userId);

                          if (_messageController.text.trim().isNotEmpty) {
                            FirebaseFirestore.instance
                                .collection('Cleaner messages')
                                .doc(userId)
                                .collection('userMessages')
                                .add({
                              'text': _messageController.text,
                              'timestamp': FieldValue.serverTimestamp(),
                              'name': cleanerName,
                              'profile_photo': profilePhotoUrl,
                              'role': 'cleaner', // Indicate that the sender is a cleaner
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
      },
    );
  }

  Future<String?> getProfilePhoto(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Cleaners')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        return userSnapshot.get('profile_photo');
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting profile photo: $e');
      return null;
    }
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
