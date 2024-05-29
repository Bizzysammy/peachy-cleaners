import 'package:flutter/material.dart';
import 'package:peachy/Customer/customerbottomnav.dart';
import 'package:peachy/Customer/customerprofilesettings.dart';
import 'package:peachy/logoutscreen.dart';

class customerhomepage extends StatefulWidget {
  const customerhomepage({Key? key}) : super(key: key);

  @override
  State<customerhomepage> createState() => customerhomepageState();
}

class customerhomepageState extends State<customerhomepage> {
  List<String> paymentMethod = ['VISA CARD', 'CASH', 'MOBILE MONEY'];
  String? payment;

  List<String> cleaningCategory = ['One Bed Room', 'Two Bed Room', 'Three Bed Room'];
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
                                  MaterialPageRoute(builder: (context) => const Logout()),
                                );
                                // Handle menu icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.menu, color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                            const CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage('assets/person.jpg'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const customerprofilesetting()),
                                );
                                // Handle settings icon tap
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.settings, color: Color(0xFFF9C4B4), size: 30),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        const Text(
                          "Customer Name",
                          style: TextStyle(
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
                  // Background image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/back.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Main content
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
                                prefixIcon: Icon(Icons.house, color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                prefixIcon: Icon(Icons.clean_hands_rounded, color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                prefixIcon: Icon(Icons.location_city_rounded, color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              decoration: const InputDecoration(
                                labelText: 'Location',
                                prefixIcon: Icon(Icons.place, color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onTap: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: TextFormField(
                              controller: _dateController,
                              decoration: const InputDecoration(
                                labelText: 'Date',
                                prefixIcon: Icon(Icons.date_range, color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    _dateController.text = selectedDate.toString();
                                  }
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: TextFormField(
                              controller: _timeController,
                              decoration: const InputDecoration(
                                labelText: 'Time',
                                prefixIcon: Icon(Icons.access_time, color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((selectedTime) {
                                  if (selectedTime != null) {
                                    _timeController.text = selectedTime.format(context);
                                  }
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: DropdownButtonFormField<String>(
                              items: paymentMethod.map((String payment) {
                                return DropdownMenuItem<String>(
                                  value: payment,
                                  child: Text(payment),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  payment = value;
                                });
                              },
                              value: payment,
                              decoration: const InputDecoration(
                                labelText: 'Payment Method',
                                prefixIcon: Icon(Icons.money, color: Color(0xFF111217)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(14)),
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
                              onPressed: () async {},
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
