import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDialog extends StatefulWidget {
  final LatLng initialPosition;

  const MapDialog({Key? key, required this.initialPosition}) : super(key: key);

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {

  String googleapikey = "AIzaSyDnb1EkL1xnwo9eqmC7dL4WajsqOF23gpM";


  late GoogleMapController mapController;
  LatLng _selectedPosition = const LatLng(0.313625, 32.579449);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _selectedPosition = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.initialPosition,
                zoom: 14.0,
              ),
              mapType: MapType.satellite,
              onTap: (LatLng position) {
                setState(() {
                  _selectedPosition = position;
                });
              },
              markers: {
                Marker(
                  markerId: const MarkerId('selected-location'),
                  position: _selectedPosition,
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_selectedPosition);
              },
              child: const Text('Select Location'),
            ),
          ),
        ],
      ),
    );
  }
}
