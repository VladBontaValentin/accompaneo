import 'package:accompaneo/models/simple_playlist.dart';
import 'package:accompaneo/services/api_service.dart';
import 'package:flutter/material.dart';
import 'playlist_page.dart';
import 'package:accompaneo/widgets/new_playlist_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({super.key});

  @override
  State<PlaylistsPage> createState() => _PlaylistsPageState();
}

class CardList extends StatelessWidget {
  
  final Future<List<SimplePlaylist>> futurePlaylists;

  const CardList({super.key, required this.futurePlaylists});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          FutureBuilder<List<SimplePlaylist>>(
            future: futurePlaylists, 
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Wrap(
                        children: [
                          ListTile(
                            title: Text(snapshot.data![index].name),
                            leading: CircleAvatar(radius: 28, backgroundColor: Colors.red, child: Icon(Icons.favorite, color: Colors.white, size: 28)),
                            subtitle: Text('${snapshot.data![index].totalSongs} songs'),
                            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistPage(playlistUrl: '/${snapshot.data![index].code}', playlistCode: '')))
                          ),
                          Divider(),
                        ],
                      );
                    }
                    return ListTile(
                            leading: CircleAvatar(radius: 28, backgroundColor: Theme.of(context).colorScheme.primary, child: Icon(Icons.music_note, color: Colors.white, size: 28)),
                            title: Text(snapshot.data![index].name),
                            subtitle: Text('${snapshot.data![index].totalSongs} songs'),
                            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistPage(playlistUrl:'/${snapshot.data![index].code}', playlistCode: snapshot.data![index].code)))
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('ERROR ${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })),
        ],
      ),
    );
  }
}

class _PlaylistsPageState extends State<PlaylistsPage> {

  late Future<List<SimplePlaylist>> futurePlaylists;

  PanelController pc = PanelController();

  bool _isCreatePlaylistOpen = false;

  void __toggleCreatePlaylistOpen() {
    setState(() {
      _isCreatePlaylistOpen = !_isCreatePlaylistOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    futurePlaylists = ApiService.getPlaylistsForCurrentUser();
  }

  @override
  Widget build(BuildContext context) {

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      body: SlidingUpPanel(backdropEnabled: true, 
                           body: createPlaylist(), 
                           controller: pc, 
                           panel: NewPlaylistWidget(panelController : pc, onPlaylistCreate: () {
                            setState(() {
                              futurePlaylists = ApiService.getPlaylistsForCurrentUser();
                            });
                           }),
                           borderRadius: radius,
                           maxHeight: MediaQuery.of(context).size.height - 300,
                           minHeight: 0
      ),
      floatingActionButton: Visibility(visible: true, child:FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          onPressed: () {
            pc.isPanelOpen ? pc.close() : pc.open();
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
      )),
    );
  }

  Widget createPlaylist() {
    return CardList(futurePlaylists: futurePlaylists);
  }
}