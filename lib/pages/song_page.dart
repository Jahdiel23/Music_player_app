import 'package:flutter/material.dart';
import 'package:music_player_dreamteam/components/neu_box.dart';
import 'package:music_player_dreamteam/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // Get playlist
        final playlist = value.playlist;
        // Get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: SingleChildScrollView( // Allow scrolling if necessary
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        // Title
                        const Text(
                          "PLAYLIST",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Menu button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // Album artwork
                    NeuBox(
                      child: Column(
                        children: [
                          // Album image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              currentSong.albumArtImagePath,
                            ),
                          ),
                          // Song and artist name with icon
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Song and artist name
                                Expanded( // Use Expanded to prevent overflow
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentSong.songName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        currentSong.artistName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Heart icon
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          // Song duration progress
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Start time
                                    Text("0:00"),
                                    // Shuffle icon
                                    Icon(Icons.shuffle),
                                    // Repeat icon
                                    Icon(Icons.repeat),
                                    // End time
                                    Text("0:00"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8.0, // Set the desired thumb radius here
                              ),
                            ),
                            child: Slider(
                              min: 0,
                              max: 100,
                              value: 50,
                              activeColor: Colors.pink,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Playback controls
                    Row(
                      children: [
                        // Skip previous
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const NeuBox(
                              child: Icon(Icons.skip_previous),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Play pause
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const NeuBox(
                              child: Icon(Icons.play_arrow),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Skip forward
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
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
      }
    );
  }
}
