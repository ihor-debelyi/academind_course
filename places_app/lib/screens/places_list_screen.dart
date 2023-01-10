import 'package:flutter/material.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<UserPlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<UserPlacesProvider>(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'There are no places yet. Start adding some!',
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AddPlaceScreen.routeName),
                          child: const Text(
                            'Add place',
                          ),
                        )
                      ],
                    ),
                    builder: (context, places, child) {
                      return places.items.isEmpty
                          ? child!
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                final item = places.items[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: FileImage(item.image)),
                                  title: Text(item.title),
                                  subtitle: Text(item.location.address ?? ''),
                                  onTap: () => Navigator.of(context).pushNamed(
                                    PlaceDetailsScreen.routeName,
                                    arguments: item.id,
                                  ),
                                );
                              },
                              itemCount: places.items.length,
                            );
                    },
                  ),
      ),
    );
  }
}
