import 'package:flutter/material.dart';
import 'package:peachy/Customer/customerbottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:peachy/customer_auth_provider.dart';

class CustomerMessages extends StatefulWidget {
  const CustomerMessages({Key? key}) : super(key: key);
  static const String id = 'customermessages';

  @override
  State<CustomerMessages> createState() => CustomerMessagesState();
}

class CustomerMessagesState extends State<CustomerMessages> {
  final TextEditingController _messageController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: context.watch<CustomerAuthProvider>().getCustomerName(),
      builder: (context, customerNameSnapshot) {
        if (customerNameSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (customerNameSnapshot.hasError) {
          return const Center(child: Text('Error fetching user data'));
        } else if (customerNameSnapshot.data == 'Unknown') {
          return const Center(child: Text('No user found.'));
        } else {
          final customerName = customerNameSnapshot.data!;

          return Scaffold(
            appBar: AppBar(
              leading: const SizedBox.shrink(), // Remove the back arrow
              title: Text(
                '$customerName\'s messages',
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
            bottomNavigationBar: const Customerbottomnav(),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .doc(userId)
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
                          final customerName = await context.read<CustomerAuthProvider>().getCustomerName();
                          final profilePhotoUrl = await getProfilePhoto(userId);

                          if (_messageController.text.trim().isNotEmpty) {
                            FirebaseFirestore.instance
                                .collection('messages')
                                .doc(userId)
                                .collection('userMessages')
                                .add({
                              'text': _messageController.text,
                              'timestamp': FieldValue.serverTimestamp(),
                              'name': customerName,
                              'profile_photo': profilePhotoUrl,
                              'role': 'customer', // Indicate that the sender is a customer
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
          .collection('Customers')
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
        backgroundImage: NetworkImage(profilePhotoUrl), // Customer's profile image
      )
          : const CircleAvatar(
        child: Icon(Icons.person), // Default person icon for customers without profile photo
      ),
      title: Text(text),
      subtitle: Text(userName),
    );
  }
}
