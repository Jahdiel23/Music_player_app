import 'package:flutter/material.dart';
import 'package:music_player_dreamteam/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  //lista de canciones
    final List<Song> _playlist = [
   //cancion 1
   Song(
    songName: "ballad of a homeschooled girl",
    artistName: "Olivia Rodrigo",
    albumArtImagePath: "assets/images/ballad_of_a_homeschooled_girl.jpg",
    audioPath: "audio/ballad of a homeschooled girl.mp3",
    ),

  //cancion 2
   Song(
    songName: "Suave",
    artistName: "Luis Miguel",
    albumArtImagePath: "assets/images/suave.jpg",
    audioPath: "audio/suave.mp3",
    ),

   //cancion 3
   Song(
    songName: "Bad",
    artistName: "Michael Jackson",
    albumArtImagePath: "assets/images/Bad.jpg",
    audioPath: "audio/bad.mp3",
    ),

    //cancion 4
    Song(
    songName: "Ahora te puedes marchar",
    artistName: "Luis Miguel",
    albumArtImagePath: "assets/images/Ahora_te_puedes_marchar.jpg",
    audioPath: "audio/ahora_te_puedes_marcahar.mp3",
    ),

   //cancion 5
   Song(
    songName: "Me enamoré en la cola de las tortillas",
    artistName: "Los Estrambóticos",
    albumArtImagePath: "assets/images/me_enamore_en_la_cola_de_las_tortillas.jpg",
    audioPath: "audio/Me enamore en la cola de las tortillas.mp3",
    ),

   //cancion 6
   Song(
    songName: "eternal sunshine",
    artistName: "Ariana Grande",
    albumArtImagePath: "assets/images/eternal_sunshine.jpg",
    audioPath: "audio/eternal sunshie.mp3",
    ),

   //cancion 7
   Song(
    songName: "Beat It",
    artistName: "Michael Jackson",
    albumArtImagePath: "assets/images/Beat_it.jpg",
    audioPath: "audio/Beat it.mp3",
    ),

   //cancion 8
   Song(
    songName: "Levitating",
    artistName: "Dua Lipa Ft. DaBaby",
    albumArtImagePath: "assets/images/Levitating.jpg",
    audioPath: "audio/Levitating.mp3",
    ),

   //cancion 9
   Song(
    songName: "Mi cucu",
    artistName: "La Sonora Dinamita",
    albumArtImagePath: "assets/images/Mi_cucu.jpg",
    audioPath: "audio/Mi cucu.mp3",
    ),

   //cancion 10
   Song(
    songName: "Secreto de amor",
    artistName: "Joan Sebastián",
    albumArtImagePath: "assets/images/secreto_de_amor.jpg",
    audioPath: "audio/Secreto de amor.mp3",
    ),

   //cancion 11
   Song(
    songName: "Enemy",
    artistName: "Imagine Dragons X JID",
    albumArtImagePath: "assets/images/Enemy.jpg",
    audioPath: "audio/Enemy.mp3",
    ),

  //cancion 12
   Song(
    songName: "What I've Done",
    artistName: "Linkin Park",
    albumArtImagePath: "assets/images/What_i've_done.jpg",
    audioPath: "audio/link in park.mp3",
    ),
    ];


    //cancion current playing index
 int? _currentSongIndex;
 
 /*

G E T T E R S

*/

 List<Song> get playlist => _playlist;
 int? get currentSongIndex => _currentSongIndex;

 /*

 S E T T E R S


 */

  set currentSongIndex(int? newIndex) {

   //update current song index
   _currentSongIndex = newIndex;

   //update UI
   notifyListeners();

  }
}
