import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player_dreamteam/models/song.dart';

class PlaylistProvider extends ChangeNotifier{
  
  final List<Song> _playList = [
    // song 1 
    Song(songName: 'Ahora te puedes marchar', 
    artistName: 'Luis Miguel',
     albumArtImagePath: 'assets/images/Ahora_te_puedes_marchar.jpg',
      audioPath: 'song/ahora_te_puedes_marcahar.mp3'),
    // cancion 2
    Song(songName: 'Bad', 
    artistName: 'Michael Jackson',
     albumArtImagePath: 'assets/images/Bad.jpg',
      audioPath: 'song/bad.mp3'),
    // cancion 3
    Song(songName: 'ballad of a homeschooled girl', 
    artistName: 'Olivia Rodrigo',
     albumArtImagePath: 'assets/images/ballad_of_a_homeschooled_girl.jpg',
      audioPath: 'song/ballad of a homeschool girl.mp3'),
    //cancion 4
    Song(songName: 'Beat it', 
    artistName: 'Michael Jackson',
     albumArtImagePath: 'assets/images/Beat_it.jpg',
      audioPath: 'song/Beat it.mp3'),
    //cancion 5
    Song(songName: 'Enemy', 
    artistName: 'Imagine Dragons',
     albumArtImagePath: 'assets/images/Enemy.jpg',
      audioPath: 'song/Enemy.mp3'),
    //cancion 6
    Song(songName: 'eternal sunshine', 
    artistName: 'Ariana Grande',
     albumArtImagePath: 'assets/images/eternal_sunshine.jpg',
      audioPath: 'song/eternal sunshie.mp3'),
    // cancion7
    Song(songName: "What I've Done", 
    artistName: 'Linkin Park',
     albumArtImagePath: 'assets/images/link_in_park.jpg',
      audioPath: 'song/link in park.mp3'),
    // cancion 8
    Song(songName: 'Me enamoré en la cola de tortillas', 
    artistName: 'Los Estrambóticos',
     albumArtImagePath: 'assets/images/me_enamore_en_la_cola_de_las_tortillas.jpg',
      audioPath: 'song/Me enamore en la cola de las tortillas.mp3'),
    // cancion9
    Song(songName: 'Mi cucú', 
    artistName: 'La Sonora Dinamita',
     albumArtImagePath: 'assets/images/Mi_cucu.jpg',
      audioPath: 'song/Mi cucu.mp3'),
    //cancion 10
    Song(songName: 'Secreto de amor', 
    artistName: 'Joan Sebastian',
     albumArtImagePath: 'assets/images/secreto_de_amor.jpg',
      audioPath: 'song/Secreto de amor.mp3'),
    //cancion 11
    Song(songName: 'Suave', 
    artistName: 'Luis Miguel',
     albumArtImagePath: 'assets/images/suave.jpg',
      audioPath: 'song/suave.mp3'),
    //cancion 12
    Song(songName: 'Levitating', 
    artistName: ' Dua Lipa',
     albumArtImagePath: 'assets/images/Levitating.jpg',
      audioPath: 'song/Levitating.mp3'),
  ];

  //current song
  int? _currentSongIndex;

  //A U D I O P L A Y E R 

  //audio player 
  final AudioPlayer _audioPlayer = AudioPlayer();
  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  //constructor
  PlaylistProvider() {
    listenToDuration();
  }
  // initialliy not playing
  bool _isPlaying = false;

  //play the song
  void play() async{
    final String path = _playList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(  path));
    _isPlaying = true;
    notifyListeners();
  }
  // pause current song 
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume the song
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = false;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async{
    if (_isPlaying){
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async{
    await _audioPlayer.seek(  position);
  }

  //play next song 
  void playNextSong() {
    if (_currentSongIndex!= null){
      if (_currentSongIndex! < _playList.length -1){
        // go to song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else{
        //if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  //play previus song 
  void playPreviousSong() async{
    //if more tha 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds >2) {
      seek(Duration.zero);
      //if it's within first 2s of the song, go to previus song

    }
    else{
      if(_currentSongIndex!>0) {
        currentSongIndex = _currentSongIndex! -1;
      } else{
        //if it's the first song, loop back to last song
        currentSongIndex = _playList.length -1;
      }
    }
  }

  //listen to duration 
  void listenToDuration() {

    // listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration){
      _totalDuration = newDuration;
      notifyListeners();
    });

    //lisetn forcurrent duration 
    _audioPlayer.onPositionChanged.listen((newPosition){
      _currentDuration = newPosition;
      notifyListeners();
    });
    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });

  }


  /*
  G E T  T E R S
  */

  List<Song> get playlist => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /* 
  S E T T E R S
  */

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if(newIndex != null){
      play(); //play the song at the new index

    }

    notifyListeners();
  }




}