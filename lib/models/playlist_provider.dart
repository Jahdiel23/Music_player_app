import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player_dreamteam/models/song.dart';

// Proveedor para gestionar la lista de reproducción y controlar la reproducción de canciones.
class PlaylistProvider extends ChangeNotifier {

  // Lista de reproducción con canciones, cada una representada por un objeto Song.
  final List<Song> _playList = [
    // Canción 1
    Song(
      songName: 'Ahora te puedes marchar',
      artistName: 'Luis Miguel',
      albumArtImagePath: 'assets/images/Ahora_te_puedes_marchar.jpg',
      audioPath: 'song/ahora_te_puedes_marcahar.mp3'
    ),
    // Canción 2
    Song(
      songName: 'Bad',
      artistName: 'Michael Jackson',
      albumArtImagePath: 'assets/images/Bad.jpg',
      audioPath: 'song/bad.mp3'
    ),
    // Canción 3
    Song(
      songName: 'ballad of a homeschooled girl',
      artistName: 'Olivia Rodrigo',
      albumArtImagePath: 'assets/images/ballad_of_a_homeschooled_girl.jpg',
      audioPath: 'song/ballad of a homeschool girl.mp3'
    ),
    // Canción 4
    Song(
      songName: 'Beat it',
      artistName: 'Michael Jackson',
      albumArtImagePath: 'assets/images/Beat_it.jpg',
      audioPath: 'song/Beat it.mp3'
    ),
    // Canción 5
    Song(
      songName: 'Enemy',
      artistName: 'Imagine Dragons',
      albumArtImagePath: 'assets/images/Enemy.jpg',
      audioPath: 'song/Enemy.mp3'
    ),
    // Canción 6
    Song(
      songName: 'eternal sunshine',
      artistName: 'Ariana Grande',
      albumArtImagePath: 'assets/images/eternal_sunshine.jpg',
      audioPath: 'song/eternal sunshie.mp3'
    ),
    // Canción 7
    Song(
      songName: "What I've Done",
      artistName: 'Linkin Park',
      albumArtImagePath: 'assets/images/link_in_park.jpg',
      audioPath: 'song/link in park.mp3'
    ),
    // Canción 8
    Song(
      songName: 'Me enamoré en la cola de tortillas',
      artistName: 'Los Estrambóticos',
      albumArtImagePath: 'assets/images/me_enamore_en_la_cola_de_las_tortillas.jpg',
      audioPath: 'song/Me enamore en la cola de las tortillas.mp3'
    ),
    // Canción 9
    Song(
      songName: 'Mi cucú',
      artistName: 'La Sonora Dinamita',
      albumArtImagePath: 'assets/images/Mi_cucu.jpg',
      audioPath: 'song/Mi cucu.mp3'
    ),
    // Canción 10
    Song(
      songName: 'Secreto de amor',
      artistName: 'Joan Sebastian',
      albumArtImagePath: 'assets/images/secreto_de_amor.jpg',
      audioPath: 'song/Secreto de amor.mp3'
    ),
    // Canción 11
    Song(
      songName: 'Suave',
      artistName: 'Luis Miguel',
      albumArtImagePath: 'assets/images/suave.jpg',
      audioPath: 'song/suave.mp3'
    ),
    // Canción 12
    Song(
      songName: 'Levitating',
      artistName: ' Dua Lipa',
      albumArtImagePath: 'assets/images/Levitating.jpg',
      audioPath: 'song/Levitating.mp3'
    ),
  ];

  // Índice de la canción actual. Es opcional y puede ser nulo si no hay ninguna seleccionada.
  int? _currentSongIndex;

  // Atributos para gestionar el audio.
  final AudioPlayer _audioPlayer = AudioPlayer(); // Controlador de reproducción de audio.
  Duration _currentDuration = Duration.zero; // Duración actual de la canción.
  Duration _totalDuration = Duration.zero; // Duración total de la canción.

  // Constructor que inicializa los listeners para la duración.
  PlaylistProvider() {
    listenToDuration();
  }

  // Indica si una canción está en reproducción.
  bool _isPlaying = false;

  // Reproduce la canción actual.
  void play() async {
    final String path = _playList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // Detiene cualquier canción previamente en reproducción.
    await _audioPlayer.play(AssetSource(path)); // Reproduce la nueva canción.
    _isPlaying = true;
    notifyListeners(); // Notifica a los listeners que hubo un cambio.
  }

  // Pausa la canción actual.
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Reanuda la reproducción de la canción actual.
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Alterna entre pausar y reanudar la canción actual.
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // Salta a una posición específica en la canción actual.
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Reproduce la siguiente canción de la lista.
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playList.length - 1) {
        // Si no es la última canción, avanza al siguiente índice.
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // Si es la última canción, vuelve a la primera.
        currentSongIndex = 0;
      }
    }
  }

  // Reproduce la canción anterior de la lista.
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      // Si han pasado más de 2 segundos, reinicia la canción actual.
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        // Si no es la primera canción, retrocede al índice anterior.
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        // Si es la primera canción, pasa a la última.
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  // Configura los listeners para las duraciones y el evento de finalización de la canción.
  void listenToDuration() {
    // Listener para la duración total de la canción.
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // Listener para la posición actual de la canción.
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // Listener para cuando una canción termina de reproducirse.
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // Getters para exponer información de forma segura.
  List<Song> get playlist => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setter para cambiar la canción actual.
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); // Reproduce la canción en el nuevo índice.
    }

    notifyListeners();
  }
}
