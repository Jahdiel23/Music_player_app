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

  late final dynamic playlistProvider;

  @override void initState() {
    super.initState();

    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    //
    playlistProvider.currentSongIndex= songIndex;
    //
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const SongPage(),),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, //Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: const Padding(
        padding:  EdgeInsets.symmetric(horizontal: 60),
        child: Text("P L A Y L I S T", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
      )),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        final List<Song> playlist = value.playlist;
        return ListView.builder(
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            // asigna una cancio individualmente
            final Song song = playlist[index];
            // devuelve la lista de titulos en UI
            return ListTile(
              title: Text(song.songName),
              subtitle: Text(song.artistName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
              leading: Image.asset(song.albumArtImagePath),
              onTap: () => goToSong(index),
            ); 

          });
      }
    ),
    );
  }
}