import 'package:flutter/material.dart';
 // Drawer personalizado para la navegación lateral
 // Proveedor para manejar la lista de canciones
 // Modelo de canción
 // // Página de detalles de una canción
import 'package:music_player_dreamteam/components/my_drawer.dart';
import 'package:music_player_dreamteam/models/playlist_provider.dart';
import 'package:music_player_dreamteam/models/song.dart';
import 'package:music_player_dreamteam/pages/song_page.dart';
import 'package:provider/provider.dart'; // Paquete para el manejo de estado con Provider

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Función que navega a la página de detalles de la canción al hacer clic en una canción
  void goToSong(BuildContext context, int songIndex) {
    // Establece el índice de la canción actual en el PlaylistProvider
    Provider.of<PlaylistProvider>(context, listen: false).currentSongIndex = songIndex;

    // Navega a la página SongPage con la canción seleccionada
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // Color de fondo según el tema
      appBar: AppBar(
        title: const Text("P L A Y L I S T"), // Título de la barra superior
      ),
      drawer: const MyDrawer(), // El drawer para la navegación lateral
      body: Consumer<PlaylistProvider>( // Consumer para escuchar los cambios en el PlaylistProvider
        builder: (context, value, child) {
          // Obtiene la lista de canciones desde el PlaylistProvider
          final List<Song> playlist = value.playlist;

          // Crea una lista de canciones utilizando ListView.builder
          return ListView.builder(
            itemCount: playlist.length, // Número de elementos en la playlist
            itemBuilder: (context, index) {
              final Song song = playlist[index]; // Obtiene la canción en el índice actual

              return ListTile(
                title: Text(song.songName), // Muestra el nombre de la canción
                subtitle: Text(song.artistName), // Muestra el nombre del artista
                leading: Image.asset(song.albumArtImagePath), // Muestra la portada del álbum
                onTap: () => goToSong(context, index), // Llama a goToSong al hacer clic
              );
            },
          );
        },
      ),
    );
  }
}