import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

final handleLocationPermissionProvider =
    Provider<HandleLocationPermission>((ref) {
  return HandleLocationPermission();
});

class HandleLocationPermission {
  Future<bool> handleLocationPermission({
    required BuildContext context,
  }) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition({
    required Position currentPosition,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final hasPermission = await ref
        .watch(handleLocationPermissionProvider)
        .handleLocationPermission(context: context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _getAddressFromLatLng(
        position: position,
        currentPosition: currentPosition,
      );
    }).catchError((e) {
      debugPrint("vvvvvvvvvvvvvvvvvvv $e");
    });
  }

  Future<void> _getAddressFromLatLng({
    required Position position,
    required Position currentPosition,
  }) async {
    await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude)
        .then((List<Placemark> placemarks) {
      // Placemark place = placemarks[0];
      // setState(() {
      //   _currentAddress =
      //       '${place.street}, ${place.subLocality} ${place.subAdministrativeArea}, ${place.postalCode}';
      // });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
