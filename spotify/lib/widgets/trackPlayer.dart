///Importing dart libraries to use it.
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:spotify/Providers/user_provider.dart';

///Importing widgets to use it.
import 'collapsed.dart';
import 'panel.dart';
import '../Screens/MainApp/tab_navigator.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../Widgets/stream_builders.dart';

///Importing models and providers to use it.
import '../Models/track.dart';
import '../Providers/playable_track.dart';


class MainWidget extends StatefulWidget {
  static const routeName = '/main_screen';
  MainWidget();
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  ///Sliding panel attributes.
  ///
  ///Panel controller object to control the sliding up panel.
  PanelController _pc = new PanelController();


  ///Palette Generator object to generate a matching background color for the panel.
  PaletteGenerator paletteGenerator;

  ///Background color for the palette.
  Color background=Colors.black87;

  ///Indicates background generated or not.
  bool colorGenerated=false;

  ///The height of the sliding up panel (Opened).
  double _panelHeightOpen;

  ///The height of the sliding up panel (Closed).
  double _panelHeightClosed;

  ///The height of the collapsed.
  double collapsedHeight;

  ///Is the collapsed widget hidden or not.
  bool collapsedHide;

  ///Is the panel opened or closed.
  //var panelState;


  ///Song attributes.
  ///
  ///The audio player object.
  AudioPlayer _player;

  ///The path of the location that the song is downloaded at.
  String songPath;

  ///Indicates if the the track is still downloading to show the progress indicator.
  bool downloading;

  ///Indicates if the track is downloaded to check when deleting.
  bool downloaded;

  ///Indicates if the track is deleted yet or not to avoid deleting an empty path.
  bool deleted;

  ///Indicates if the song is downloaded and ready to be played.
  bool readyToPlay;

  ///The song object.
  Track song;



  ///Navigation attributes
  ///
  /// Indicates which tab item is chosen by the user.
  static TabItem _currentTab = TabItem.home;

  ///Is the bottom navigation bar hidden.
  bool hide = false;

  ///A function to hide the bottom navigation bar.
  void toHide(bool toHide) {
    setState(() {
      hide = toHide;
    });

  }
  

  ///A map of global keys, holding a key for each tab.
  static Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.library: GlobalKey<NavigatorState>(),
    TabItem.premium: GlobalKey<NavigatorState>(),
    TabItem.artist: GlobalKey<NavigatorState>(),
  };

  ///A list of the screens the user can access from the bottom navigation bar.
  final List<Widget> pages = [
    TabNavigator(
      route: TabNavigatorRoutes.search,
      navigatorKey: _navigatorKeys[TabItem.home],
      tabItem: TabItem.home,
    ),
    TabNavigator(
      route: TabNavigatorRoutes.search,
      navigatorKey: _navigatorKeys[TabItem.search],
      tabItem: TabItem.search,
    ),
    TabNavigator(
      route: TabNavigatorRoutes.library,
      navigatorKey: _navigatorKeys[TabItem.library],
      tabItem: TabItem.library,
    ),
    TabNavigator(
      route: TabNavigatorRoutes.premium,
      navigatorKey: _navigatorKeys[TabItem.premium],
      tabItem: TabItem.premium,
    ),
    TabNavigator(
      route: TabNavigatorRoutes.artist,
      navigatorKey: _navigatorKeys[TabItem.artist],
      tabItem: TabItem.artist,
    ),
  ];


  ///A function to change between selected tabs and appearing screens.
  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
    setState(() => _currentTab = tabItem);
  }



  ///Initializations
  @override
  void initState()  {
    collapsedHide=false;
    super.initState();
    init();
  }

  void init() {
    //panelState = PanelState.CLOSED;
    _player = AudioPlayer();
    if(song!=null) {
      colorGenerated=false;
      downloading = true;
      downloaded = false;
      deleted = false;
      readyToPlay = false;
      downloadSong();
    }
  }



  ///Generating a dark muted background color for the panel from the image of the song.
  Future<void> _generatePalette() async {
    if(song!=null) {
      PaletteGenerator _paletteGenerator =
      await PaletteGenerator.fromImageProvider(NetworkImage('https://dailymix-images.scdn.co/v1/img/ab67616d0000b273cfa4e906cda39d8f62fe81e3/1/en/default'/*song.album.images[0]*/),
          size: Size(110, 150), maximumColorCount: 20);
      if(_paletteGenerator.darkMutedColor!=null) {
        background = _paletteGenerator.darkMutedColor.color;
        colorGenerated=true;
      }
      setState(
            () {
          paletteGenerator = _paletteGenerator;
        },
      );
    }
  }



  ///Downloading the mp3 file, save it and save its path and set flags.
  Future<void> downloadSong() async {
    final user =Provider.of<UserProvider>(context,listen:false);
    Dio dio = new Dio();
      try{ 
    var dir = (await path.getExternalStorageDirectory()).path;
   
      setState(() {
        downloading = true;
        print('Downloading...');
      });
  

     
      await dio.download
      (
        
        song.href+'/audio', '$dir/' + song.id,options: Options(headers: {"authorization":"Bearer "+user.token,})).then((_){
         setState(() {
            downloaded = true;
            downloading = false;
            readyToPlay = true;
            songPath = '$dir/' + song.id;
            _player.setFilePath(songPath);
            _pc.open();
            toHide(true);
          });
        });
    } catch (e) {e.toString();}
  }


  ///Deleting the played mp3 file for its path and set flags.
  void deleteFile() async {
    final dir = Directory(songPath);
      print('h' + songPath);
      await dir.delete(recursive: true);
      setState(() {
        deleted=true;
        downloaded=false;
      });
  }


  ///Freeing the memory after closing the app.
  @override
  void dispose() {
    if(downloaded!= null && downloaded)
      deleteFile();
    _player.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    ///Getting the device size to use it when assigning sizes (Responsiveness).
    final deviceSize = MediaQuery
        .of(context)
        .size;

    ///Generating a matching background color if none is generated.
    if(!colorGenerated)
      _generatePalette();

    ///Assigning the whole size of the device to be the size of the panel (Opened).
    _panelHeightOpen = deviceSize.height * 1;

    ///Instantiating a current track provider to get the current track.
    ///Listen is true to rebuilt when a song is added to the provider.
    final currentTrackProvider=Provider.of<PlayableTrackProvider>(context, listen: true);


    ///Checking if there is a song requested to be played in the playable track provider.
    if(currentTrackProvider.getWaitingStatus()){
      setState(() {

        ///Deleting the current song if found.
        if(song!=null){
          deleteFile();
        }

        ///Stopping the current song if any is being played.
        if(_player.playbackEvent.state==AudioPlaybackState.playing){
          _player.stop();
        }

        ///Get the requested song from the provider.
        song=currentTrackProvider.getCurrentSong();

        ///Make sure the collapsed widget isn't hidden.
        collapsedHide=false;

        ///Assigning the size of the collapsed widget.
        _panelHeightClosed=deviceSize.height*0.09;

        ///Initializing the audio player with the new track and setting some flags.
        init();
      });

    }


    ///Check if there is a playing/paused song
    if(song!=null) {
      ///Deleting the song if finished.
      if (_player.playbackState == AudioPlaybackState.completed &&
          !deleted) {
        deleteFile();
      }

      ///If the song is ready to play.
      if (readyToPlay) {

        ///Check the player is not yet connecting and play it automatically.
        print('About to play');
        if (_player.playbackState != AudioPlaybackState.connecting &&
            _player.playbackState != AudioPlaybackState.none) {
          print('Ready');
          _player.play();
          readyToPlay = false;
        }
        else {
          print('Not Ready');
          Timer(Duration(milliseconds: 500), () {
            setState(() {
              print('Timer Dne');
              readyToPlay = false;
              _player.play();
            });
          });
        }
      }
      else {
        collapsedHeight = deviceSize.height * 0.09;
      }
    }
    ///Closing the collapsed widget if there is no song requested to be played.
    else{
      collapsedHide=true;
      _panelHeightClosed=0;
    }



    ///Handling the tool bars of the panel and collapsed to be synchronized.
    ///
    ///Creating the tool bar to pass it to the panel.
    StreamBuilder panelToolBar = StreamBuilder<FullAudioPlaybackState>(

      ///Initializing the audio player attributes.
      stream: song==null?null:_player.fullPlaybackStateStream,
      builder: (context, snapshot) {
        final fullState = snapshot.data;
        final state = fullState?.state;
        final buffering = fullState?.buffering;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///Add to favorites button.
            Container(
              margin: EdgeInsets.only(left: deviceSize.width * 0.05),
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.white24,
                ),
                iconSize: deviceSize.height * 0.04,
              ),
            ),
            SizedBox(
              width: deviceSize.width * 0.12,
            ),
            ///Get the previous track button.
            IconButton(
              icon: Icon(
                Icons.fast_rewind,
                color: Colors.white24,
              ),
              iconSize: deviceSize.height * 0.05,
            ),

            ///Checks if the song is downloading or the player is connecting.
            if (downloading ||
                state == AudioPlaybackState.connecting ||
                buffering == true)
              ///Showing a circular progress indicator if true.
              Container(
                margin: EdgeInsets.all(8.0),
                height: deviceSize.height * 0.05,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white) ,),
              )
              ///Else, checking if the song is playing.
            else if (state == AudioPlaybackState.playing)
              ///Showing a pause button if true.
              IconButton(
                icon: Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
                iconSize: deviceSize.height * 0.07,
                onPressed: _player.pause,
              )
            else
              ///Else, showing a play button.
              IconButton(
                icon: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                ),
                iconSize: deviceSize.height * 0.07,
                onPressed: _player.play,
              ),

            ///Get the next track button.
            IconButton(
              icon: Icon(
                Icons.fast_forward,
                color: Colors.white24,
              ),
              iconSize: deviceSize.height * 0.05,
            ),
            SizedBox(
              width: deviceSize.width * 0.11,
            ),

            ///Share this song button.
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white24,
              ),
              iconSize: deviceSize.height * 0.03,
            ),
          ],
        );
      },
    );



    ///Creating the tool bar to pass it to the collapsed.
    StreamBuilder collapsedToolBar = StreamBuilder<FullAudioPlaybackState>(
      ///Initializing the audio player attributes.
      stream: song==null?null:_player.fullPlaybackStateStream,
      builder: (context, snapshot) {
        final fullState = snapshot.data;
        final state = fullState?.state;
        final buffering = fullState?.buffering;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///Checking if the song is downloading or the player is connecting.
            if (downloading ||
                state == AudioPlaybackState.connecting ||
                buffering == true)
              Container(
                margin: EdgeInsets.all(8.0),
                height: deviceSize.height * 0.05,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white) ,),
              )
              ///Checking if the song is playing.
            else if (state == AudioPlaybackState.playing)
              ///Showing the pause button if true.
              IconButton(
                icon: Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
                iconSize: deviceSize.height * 0.05,
                onPressed: _player.pause,
              )
            else
              ///Else, show the play button.
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                iconSize: deviceSize.height * 0.05,
                onPressed: _player.play,
              ),
          ],
        );
      },
    );




    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },

      ///Sliding Up Panel Widget.
      child: Scaffold(
        bottomNavigationBar: hide
            ? Container(
                height: 0.0,
              )
            : BottomNavigation(
                currentTab: _currentTab,
                onSelectTab: _selectTab,
              ),
        body: SlidingUpPanel(
          controller: _pc,
          defaultPanelState: PanelState.CLOSED,
          backdropTapClosesPanel: true,
          color: background,
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          body: pages[_currentTab.index],
          panel: Panel(
            song: song,
            pc: _pc,
            bar: song==null?null:panelBar(_player),
            toolBar: song==null?null:panelToolBar,
            toHide: toHide,
          ),
          collapsed: collapsedHide?Container():InkWell(
            onTap: ()=>setState(() {
              hide=true;
              _pc.open();
            }),
            child:Slidable(
              actionPane: SlidableBehindActionPane(),
              actions: <Widget>[
               IconSlideAction(
                 caption: 'Close',
                 color: Colors.red,
                 icon: Icons.close,
                 onTap: (){
                   setState(() {
                     _player.playbackEvent.state == AudioPlaybackState.playing? _player.stop():null;
                     collapsedHide=true;
                     _panelHeightClosed=0;
                     song=null;
                   });
                 },
               ),
              ],
              child:Collapsed(
              song: song,
              playButton: collapsedToolBar,
              bar: collapsedBar(_player),
              collapsedHeight: collapsedHeight,
          ),)
        ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
          isDraggable: false,
        ),
      ),
    );
  }
}
