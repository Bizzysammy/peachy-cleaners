import 'package:flutter/material.dart';
import 'package:peachy/Cleaners/cleanersbottomnav.dart';
import 'package:peachy/Cleaners/cleanershomescreen.dart';

class CleanerReports extends StatefulWidget {
  @override
  State<CleanerReports> createState() => CleanerReportsState();
}

class CleanerReportsState extends State<CleanerReports> {
  TextEditingController cleanername = TextEditingController();
  TextEditingController dayofcleaning = TextEditingController();
  TextEditingController dateofcleaning = TextEditingController();
  TextEditingController customername = TextEditingController();
  TextEditingController numberofrooms = TextEditingController();
  TextEditingController customeraddress = TextEditingController();
  TextEditingController totalcashcollection = TextEditingController();
  TextEditingController totalvisacollection = TextEditingController();
  TextEditingController totalmobilemoneycollection = TextEditingController();
  TextEditingController totalcollection = TextEditingController();

  @override
  void initState() {
    super.initState();
    totalcashcollection.addListener(_updateTotalCollection);
    totalvisacollection.addListener(_updateTotalCollection);
    totalmobilemoneycollection.addListener(_updateTotalCollection);
  }

  @override
  void dispose() {
    totalcashcollection.removeListener(_updateTotalCollection);
    totalvisacollection.removeListener(_updateTotalCollection);
    totalmobilemoneycollection.removeListener(_updateTotalCollection);
    totalcashcollection.dispose();
    totalvisacollection.dispose();
    totalmobilemoneycollection.dispose();
    totalcollection.dispose();
    super.dispose();
  }

  void _updateTotalCollection() {
    double cash = double.tryParse(totalcashcollection.text) ?? 0.0;
    double visa = double.tryParse(totalvisacollection.text) ?? 0.0;
    double mobileMoney = double.tryParse(totalmobilemoneycollection.text) ?? 0.0;
    double total = cash + visa + mobileMoney;

    totalcollection.text = total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
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
          title: const Text(
            "Write Report",
            style: TextStyle(
              color: Color(0xFFF9C4B4),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => CleanersHomePage()));
              },
              child: Text(
                "Back",
                style: TextStyle(
                  fontSize: 20,
                  color: const Color(0xFFF9C4B4),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                // Handle save action
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 20,
                  color: const Color(0xFFF9C4B4),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Cleanersbottomnav(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildTextField(controller: cleanername, hintText: 'Cleaner Name'),
              SizedBox(height: 11),
              _buildTextField(controller: dayofcleaning, hintText: 'Day of Cleaning'),
              SizedBox(height: 11),
              _buildTextField(controller: dateofcleaning, hintText: 'Date of Cleaning'),
              SizedBox(height: 11),
              _buildTextField(controller: customername, hintText: 'Customer Name'),
              SizedBox(height: 11),
              _buildTextField(controller: numberofrooms, hintText: 'Number of Rooms'),
              SizedBox(height: 11),
              _buildTextField(controller: customeraddress, hintText: 'Customer Address'),
              SizedBox(height: 11),
              _buildTextField(
                controller: totalcashcollection,
                hintText: 'Total Cash Collection',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 11),
              _buildTextField(
                controller: totalvisacollection,
                hintText: 'Total Visa Collection',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 11),
              _buildTextField(
                controller: totalmobilemoneycollection,
                hintText: 'Total MobileMoney Collection',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 11),
              _buildTextField(
                controller: totalcollection,
                hintText: 'Total Collection',
                keyboardType: TextInputType.number,

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return Container(
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}
