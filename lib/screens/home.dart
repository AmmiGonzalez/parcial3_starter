import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parcial3/widgets.dart';
import 'package:provider/provider.dart';

int _selectedIndex = 0;

final visitedPlacesProvider = StateNotifierProvider<VisitedPlaces, List<Place>>((ref) {
  return VisitedPlaces([]);
});

class VisitedPlaces extends StateNotifier<List<Place>> {
  VisitedPlaces(List<Place> state) : super(state);

  void toggleVisited(Place place) {
    final index = state.indexOf(place);
    if (index != -1) {
      state = List.from(state)..removeAt(index);
    } else {
      state = List.from(state)..add(place);
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [PlacesPage(), VisitsPage()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Lugares',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            label: 'Visitados',
          ),
        ],
      ),
    );
  }
}

class PlacesCard extends StatelessWidget {
  final String image, title, description;
  final bool visited;
  final Place place;

  const PlacesCard({
    required this.image,
    required this.title,
    required this.description,
    required this.visited,
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visitedPlaces = context.read(visitedPlacesProvider);

    void toggleVisited() {
      visitedPlaces.toggleVisited(place);
    }

    return GestureDetector(
      onTap: toggleVisited,
      child: Container(
        width: 164,
        height: 248,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black54,
                Colors.transparent,
                Colors.transparent,
                Colors.black54
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0, 0.6, 1],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Icon(
                    visited ? Icons.flag : Icons.flag_outlined,
                    color: visited ? Colors.red : Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlacesPage extends ConsumerWidget {
  const PlacesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.read(placesProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              Text('Guatemala', style: Theme.of(context).textTheme.headline6),
              Text('Corazón del mundo maya',
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return PlacesCard(
                  image: place.image,
                  title: place.title,
                  description: place.description,
                  visited: place.visited,
                  place: place,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class VisitsPage extends ConsumerWidget {
  const VisitsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitedPlaces = ref.watch(visitedPlacesProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text('Lugares visitados',
              style: Theme.of(context).textTheme.headline6),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView.builder(
              itemCount: visitedPlaces.length,
              itemBuilder: (context, index) {
                final place = visitedPlaces[index];
                return VisitedCard(image: place.image, title: place.title);
              },
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: HomeScreen(),
        theme: ThemeData(
          // Configura tu tema de la aplicación
        ),
      ),
    ),
  );
}

class Place {
  final String title, description, image;
  final bool visited;

  Place(this.title, this.description, this.image, this.visited);
}

final placesProvider = Provider<List<Place>>((ref) {
  return [
    Place('Tikal', 'Civilización maya en su máxima expresión', 'assets/image1.jpeg', false),
    Place('Atitlán', 'El lago más hermoso del mundo', 'assets/image2.jpeg', true),
    Place('Semuc', 'Un paraíso natural en medio del bosque', 'assets/image3.jpeg', true),
    Place('Xela', 'La cuna de la cultura y de los mejores ingenieros', 'assets/image4.jpeg', false),
    Place('Santa María', 'Un volcán majestuoso', 'assets/image5.jpeg', false),
    Place('Iglesia', 'Catedral metropolitana de los álto, el corazón del parque central', 'assets/image6.jpeg', false),
    Place('El Baúl', 'Una de las mejores vistas de la ciudad', 'assets/image7.jpeg', false),
    Place('Todos Santos', 'Las emocionantes carreras de caballos', 'assets/image8.jpeg', false),
  ];
});