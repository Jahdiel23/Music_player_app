import 'package:flutter/material.dart';
import 'package:music_player_dreamteam/components/neu_box.dart';
import 'package:music_player_dreamteam/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // Convert duration into min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${duration.inMinutes}:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // Get playlist
        final playlist = value.playlist;

        // Get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];

        // Return scaffold UI
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: SingleChildScrollView( // Solución para evitar desbordamiento
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Text(
                          "P L A Y L I S T",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Album artwork
                    NeuBox(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              currentSong.albumArtImagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSong.songName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      currentSong.artistName,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Song duration progress
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(formatTime(value.currentDuration)),
                              const Icon(Icons.shuffle),
                              const Icon(Icons.repeat),
                              Text(formatTime(value.totalDuration)),
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 0),
                            ),
                            child: Slider(
                              min: 0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              value: value.currentDuration.inSeconds.toDouble(),
                              activeColor: Colors.pink,
                              inactiveColor: Colors.grey,
                              onChanged: (double newValue) {
                                // During sliding
                              },
                              onChangeEnd: (double newValue) {
                                value.seek(Duration(seconds: newValue.toInt()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Playback controls
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playPreviousSong,
                            child: const NeuBox(
                              child: Icon(Icons.skip_previous),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                              child: Icon(value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playNextSong,
                            child: const NeuBox(
                              child: Icon(Icons.skip_next),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}