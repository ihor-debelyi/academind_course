import 'package:flutter/material.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const String routeName = '/place-details';

  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    return FutureBuilder(
      future: Provider.of<UserPlacesProvider>(context, listen: false)
          .getPlaceById(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final place = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(place.title),
          ),
          body: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Image.file(
                  place.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                place.location.address!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => MapScreen(
                      initialLocation: place.location,
                      isSelecting: false,
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text('View on Map'),
              )
            ],
          ),
        );
      },
    );
  }
}
