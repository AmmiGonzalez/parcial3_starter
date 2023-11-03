// login Usuario y Contraseña
var loginData = ['ammigonzalez', '202008008'];

// clase de lugares
class Place {
  final String title, description, image;
  final bool visited;

  Place(this.title, this.description, this.image, this.visited);
}

// lista de lugares
List<Place> places = [
  Place('Tikal', 'Civilización maya en su máxima expresión',
      'assets/image1.jpeg', false),
  Place('Atitlán', 'El lago más hermoso del mundo', 'assets/image2.jpeg', true),
  Place('Semuc', 'Un paraiso natural en medio del bosque', 'assets/image3.jpeg',
      true),
  Place('Xela', 'La cuna de la cultura y de los mejores ingenieros',
      'assets/image4.jpeg', false),
  Place('Santa María', 'Un volcán majestuoso', 'assets/image5.jpeg', false),
  Place(
      'Iglesia',
      'Catedral metropolitana de los áltos, el corazón del parque central',
      'assets/image6.jpeg',
      false),
  Place('El baúl', 'Una de las mejores vistas de la ciudad',
      'assets/image7.jpeg', false),
  Place('Todos Santos', 'Las emocionantes carreras de caballos',
      'assets/image8.jpeg', false),
];
