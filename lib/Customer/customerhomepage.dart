import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:peachy/Customer/customerbottomnav.dart';
import 'package:peachy/Customer/customerlogout.dart';
import 'package:peachy/Customer/customerprofilesettings.dart';
import 'package:peachy/Customer/mapdialogue.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class customerhomepage extends StatefulWidget {
  const customerhomepage({Key? key}) : super(key: key);

  @override
  State<customerhomepage> createState() => customerhomepageState();
}

class customerhomepageState extends State<customerhomepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;
  String? userName;
  String? userProfilePicture;
  String? userPhoneNumber;

  String googleapikey = "AIzaSyDnb1EkL1xnwo9eqmC7dL4WajsqOF23gpM";

  Future<void> _getCurrentLocation(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return;
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final String location = '${position.latitude}, ${position.longitude}';
    _locationController.text = location;
  }

  List<String> paymentMethod = ['VISA CARD', 'MOBILE MONEY', 'CASH'];
  String? payment;

  List<String> cleaningCategory = [
    'One Bed Room',
    'Two Bed Room',
    'Three Bed Room',
    'Offices',
    'Sites',
    'Others'
  ];
  String? category;

  List<String> cleaningSites = [
    'Basic Cleaning',
    'Deep Cleaning',
    'General Cleaning',
    'Other Related Services e.g.',
    'Carpet Washing',
    'Scrubbing',
    'Hoovering'
  ];
  String? sites;

  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserdata();
    _loadUserProfilePicture();
  }

  Future<void> _loadUserdata() async {
    currentUser = _auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot userDoc = await _firestore.collection('Customers').doc(currentUser!.uid).get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'] ?? 'No Name';
          userPhoneNumber = userDoc['phoneNumber'] ?? 'No Phone Number';
        });
        print('User name loaded: $userName');
      } else {
        print('User document does not exist.');
      }
    } else {
      print('No user is logged in.');
    }
  }

  Future<void> _loadUserProfilePicture() async {
    currentUser = _auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot userDoc = await _firestore.collection('Customers').doc(currentUser!.uid).get();

      if (userDoc.exists) {
        setState(() {
          userProfilePicture = userDoc['profile_photo'] ?? 'https://example.com/default-profile-picture.png';
        });
        print('User profile picture loaded: $userProfilePicture');
      } else {
        print('User document does not exist.');
      }
    } else {
      print('No user is logged in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: const Customerbottomnav(),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.3,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const customerlogout()),
                                );
                                // Handle menu icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.menu,
                                    color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: userProfilePicture != null
                                  ? NetworkImage(userProfilePicture!)
                                  : const AssetImage('assets/person.jpg')
                              as ImageProvider,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const customerprofilesetting()),
                                );
                                // Handle settings icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.settings,
                                    color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          userName ?? "Customer Name",
                          style: const TextStyle(
                            color: Color(0xFFF9C4B4),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        const Text(
                          '"when things are peachy, everything is wonderful"',
                          style: TextStyle(
                            color: Color(0xFFF9C4B4),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/back.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: DropdownButtonFormField<String>(
                              items: cleaningCategory.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  category = value;
                                });
                              },
                              value: category,
                              decoration: const InputDecoration(
                                labelText: 'Room category',
                                prefixIcon:
                                Icon(Icons.house, color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: DropdownButtonFormField<String>(
                              items: cleaningSites.map((String site) {
                                return DropdownMenuItem<String>(
                                  value: site,
                                  child: Text(site),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  sites = value;
                                });
                              },
                              value: sites,
                              decoration: const InputDecoration(
                                labelText: 'Cleaning options',
                                prefixIcon: Icon(Icons.clean_hands_rounded,
                                    color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: TextField(
                              controller: _placeController,
                              decoration: const InputDecoration(
                                labelText: 'Place',
                                prefixIcon: Icon(Icons.location_city_rounded,
                                    color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: TextField(
                              controller: _locationController,
                              decoration: InputDecoration(
                                labelText: 'Location',
                                prefixIcon: const Icon(Icons.place, color: Color(0xFF111217)),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.my_location),
                                      onPressed: () async {
                                        await _getCurrentLocation(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.map),
                                      onPressed: () {
                                        _showMapDialog(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              readOnly: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: TextField(
                              controller: _dateController,
                              decoration: const InputDecoration(
                                labelText: 'Date',
                                prefixIcon: Icon(Icons.calendar_today_rounded,
                                    color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Icon(Icons.calendar_month),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (selectedDate != null) {
                                  _dateController.text =
                                  selectedDate.toLocal().toString().split(' ')[0];
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: TextField(
                              controller: _timeController,
                              decoration: const InputDecoration(
                                labelText: 'Time',
                                prefixIcon: Icon(Icons.timer,
                                    color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Icon(Icons.timer),
                              ),
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  _timeController.text = selectedTime.format(context);
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: DropdownButtonFormField<String>(
                              items: paymentMethod.map((String method) {
                                return DropdownMenuItem<String>(
                                  value: method,
                                  child: Text(method),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  payment = value;
                                });
                              },
                              value: payment,
                              decoration: const InputDecoration(
                                labelText: 'Payment method',
                                prefixIcon: Icon(Icons.payment,
                                    color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF111217),
                                backgroundColor: const Color(0xFFF9C4B4),
                                minimumSize: const Size(200, 50),
                              ),
                              onPressed: () async {
                                final String place = _placeController.text;
                                final String location = _locationController.text;
                                final String time = _timeController.text;
                                final String date = _dateController.text;

                                if (place.isEmpty ||
                                    location.isEmpty ||
                                    time.isEmpty ||
                                    date.isEmpty ||
                                    payment == null ||
                                    category == null ||
                                    sites == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fill all the fields')),
                                  );
                                  return;
                                }

                                if (currentUser == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('User is not authenticated')),
                                  );
                                  return;
                                }

                                final userQuery = _firestore
                                    .collection('Customers')
                                    .where('uid', isEqualTo: currentUser!.uid)
                                    .limit(1);

                                final userQuerySnapshot = await userQuery.get();

                                if (userQuerySnapshot.docs.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Customer does not exist')),
                                  );
                                  return;
                                }

                                final userDocRef = userQuerySnapshot.docs[0].reference;

                                final userData = userQuerySnapshot.docs[0].data();
                                final int currentOrderCount = userData['orderCount'] ?? 0;
                                final int nextOrderCount = currentOrderCount + 1;

                                final orderData = {
                                  'place': place,
                                  'location': location,
                                  'paymentmethod': payment,
                                  'time': time,
                                  'date': date,
                                  'category': category,
                                  'sites': sites,
                                  'name': userName,
                                  'phoneNumber': userPhoneNumber,
                                };

                                userDocRef
                                    .collection('myorders')
                                    .doc('my order $nextOrderCount')
                                    .set(orderData)
                                    .then((_) {
                                  _placeController.clear();
                                  _locationController.clear();
                                  _timeController.clear();
                                  _dateController.clear();
                                  payment = null;
                                  category = null;
                                  sites = null;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Order saved successfully')),
                                  );

                                  userDocRef.update({'orderCount': nextOrderCount});
                                }).catchError((e) {
                                  print('Error making order: $e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Failed to save order')),
                                  );
                                });
                              },
                              child: const Text('Book Now'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMapDialog(BuildContext context) async {
    LatLng? selectedLocation = await showDialog<LatLng>(
      context: context,
      builder: (BuildContext context) {
        return const MapDialog(
          initialPosition: LatLng(37.7749, -122.4194), // Replace with default position if necessary
        );
      },
    );

    if (selectedLocation != null) {
      setState(() {
        _locationController.text =
        '${selectedLocation.latitude}, ${selectedLocation.longitude}';
      });
    }
  }


  Future<bool> _handleLocationPermission(BuildContext context) async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return false;
    }
    return true;
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy, secondLastCurve.dx, secondLastCurve.dy);

    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy, thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
