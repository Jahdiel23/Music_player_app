import 'package:flutter/material.dart';
import 'package:music_player_dreamteam/components/my_drawer.dart';
import 'package:music_player_dreamteam/models/playlist_provider.dart';
import 'package:music_player_dreamteam/models/song.dart';
import 'package:music_player_dreamteam/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
  void goToSong(BuildContext context, int songIndex) {
    Provider.of<PlaylistProvider>(context, listen: false).currentSongIndex = songIndex;

    //navigate to song page
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Text("P L A Y L I S T")),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Song song = playlist[index];

              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName), // Muestra el artista
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(context, index),
              );
            },
          );
        },
      ),
    );
  }
}
