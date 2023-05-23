import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_player/Views/SpeedDial/addSong.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../Apiservice/restApi.dart';
import '../../widgets/AppBar.dart';
import '../../widgets/drawer.dart';

class SongUploadForm extends StatefulWidget {
  final String storageId;
  SongUploadForm({
    Key? key,
    required this.storageId,
  }) : super(key: key);

  @override
  _SongUploadFormState createState() => _SongUploadFormState();
}

class _SongUploadFormState extends State<SongUploadForm> {
  File? imageFile;
  var description = TextEditingController();
  var url = TextEditingController();
  bool isList_visible = false;
  List urlList = [];
  var userOrcompany = TextEditingController();
  double? _distanceToField;
  TextfieldTagsController? _controller;
  List tagUsers = [];
  List<String> _pickUsers = [];
  List<String> _pickImage = [];
  List tagselectedUsers = [];
  List _tagselectedUserslist = [];
  List _tagselectedUsersImage = [];
  List<XFile>? _imageFileList;
  String? _retrieveDataError;
  dynamic _pickImageError;

  bool _symmetry = false;
  bool _startDirection = false;
  int _column = 0;
  bool _horizontalScroll = false;
  double _fontSize = 16;
  String path = " ";
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  StateSetter? _setState;
  final ImagePicker _picker = ImagePicker();
  TextEditingController iFrame = TextEditingController();
  TextEditingController videoUrl = TextEditingController();
  String artistDropdown = 'Artist';
  String releaseyearDropdown = 'Year';
  String genreDropdown = 'Genre';
  String noofsogsDropdown = 'Number';
  var albumTitle = TextEditingController();
  var songTitle = TextEditingController();
  Offset? _tapPosition;
  var artist = [
    'Artist',
    'Hip-Hop/Rap',
    'Pop',
    'Rnb/Blues',
    'Classical',
    'Folk/Regional',
  ];
  var releaseyear = [
    'Year',
    '1999',
    '2000',
    '2001',
    '2002',
    '2003',
  ];
  var genre = [
    'Genre',
    'Hip-Hop/Rap',
    'Pop',
    'Rnb/Blues',
    'Classical',
    'Folk/Regional',
  ];
  var noofsongs = [
    'Number',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName = "";
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.audio;

  List addSongList = [];

  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  onGoBack(dynamic value) {
    setState(() {});
    setState(() {
      addSongList = jsonDecode(Utilities.songDetails.toString()) as List;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Color(0xFFffab00),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Container(
            child: TitleBar(),
          )),
      drawer: AppDrawer(),
      body: Container(
        decoration: new BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Services_BG.png",
                ),
                fit: BoxFit.fill)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                    ),
                    Container(
                      child: Text(
                        'Share A Music On Bulletin',
                        style: TextStyle(
                            fontFamily: 'crimson',
                            color: Color(0xFFffab00),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 60),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        tooltip: "back",
                        onPressed: () {
                          Navigator.pop(context);
                          Utilities.songDetails.clear();
                        },
                        icon: Image.asset(
                          'assets/images/return-icon.jpg',
                          color: Color(0xFFffab00),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Artist*",
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    border: Border.all(
                      color: Color(0xFFffab00).withOpacity(0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 15,
                  ),
                  width: 300,
                  height: 50,
                  child: DropdownButton(
                    isExpanded: true,
                    underline: DropdownButtonHideUnderline(
                      child: Container(),
                    ),
                    dropdownColor: Colors.black.withOpacity(0.8),
                    iconSize: 20,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    value: artistDropdown,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFFffab00)),
                    items: artist.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,
                            style: TextStyle(
                              fontFamily: 'Crimson',
                              color: Color(0xFFffab00).withOpacity(0.4),
                            )),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        artistDropdown = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Album Title",
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFffab00).withOpacity(0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: albumTitle,
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 25,
                      ),
                      border: InputBorder.none,
                      hintText: "Album Title",
                      hintStyle: TextStyle(
                          fontFamily: 'Crimson',
                          color: Color(0xFFffab00).withOpacity(0.4),
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Year of Release",
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    border: Border.all(
                      color: Color(0xFFffab00).withOpacity(0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 15,
                  ),
                  width: 300,
                  height: 50,
                  child: DropdownButton(
                    isExpanded: true,
                    underline: DropdownButtonHideUnderline(
                      child: Container(),
                    ),
                    dropdownColor: Colors.black.withOpacity(0.8),
                    iconSize: 20,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    value: releaseyearDropdown,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFFffab00)),
                    items: releaseyear.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,
                            style: TextStyle(
                              fontFamily: 'Crimson',
                              color: Color(0xFFffab00).withOpacity(0.4),
                            )),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        releaseyearDropdown = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Album Art(square dimension)",
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFffab00).withOpacity(0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
                  width: 300,
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Card(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "Choose File",
                                      style: TextStyle(
                                          fontFamily: 'Crimson', fontSize: 16),
                                    )),
                              ),
                              Container(
                                  child: _paths == null
                                      ? Text("No file choosen",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontFamily: 'Crimson',
                                              fontSize: 16,
                                              color: Colors.white))
                                      : Text(
                                          _paths![0]
                                              .path!
                                              .substring(50)
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'Crimson',
                                              fontSize: 16,
                                              color: Colors.white)))
                            ],
                          ),
                          onTap: () async {
                            final pickedFileList = await _picker.pickMultiImage(
                              maxWidth: 1000,
                              maxHeight: 1000,
                            );
                            setState(() {
                              _imageFileList = pickedFileList;
                              path = _imageFileList![0].path.substring(63);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Genre",
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    border: Border.all(
                      color: Color(0xFFffab00).withOpacity(0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 15,
                  ),
                  width: 300,
                  height: 50,
                  child: DropdownButton(
                    isExpanded: true,
                    underline: DropdownButtonHideUnderline(
                      child: Container(),
                    ),
                    dropdownColor: Colors.black.withOpacity(0.8),
                    iconSize: 20,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    value: genreDropdown,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFFffab00)),
                    items: genre.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,
                            style: TextStyle(
                              fontFamily: 'Crimson',
                              color: Color(0xFFffab00).withOpacity(0.4),
                            )),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        genreDropdown = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Album Description",
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFffab00).withOpacity(0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
                  width: 300,
                  child: TextField(
                    maxLines: 3,
                    controller: description,
                    style:
                        TextStyle(color: Colors.white70, fontFamily: 'crimson'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20, top: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 70),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    // color: Colors.blueGrey,
                    child: Text(
                      "Add Song",
                      style: TextStyle(
                          fontFamily: 'crimson',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddSongDetails()))
                          .then(onGoBack);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  child: ListView.builder(
                    itemCount: addSongList.isEmpty ? 0 : addSongList.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(20),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Table(children: [
                            TableRow(children: [
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Song Name',
                                  style: TextStyle(
                                    fontFamily: 'crimson',
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                              TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      addSongList[index]['songTitle']
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'crimson',
                                          color: Colors.black,
                                          fontSize: 16),
                                    )),
                              )
                            ]),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 70),
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          // color: Color(0xFFffab00),
                          child: Text(
                            "Post",
                            style: TextStyle(
                                fontFamily: 'crimson',
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          onPressed: () {
                            if (artistDropdown == 'Artist') {
                              Utilities.showAlert(
                                  context, "Please Select Artist");
                            } else if (albumTitle.text.length == 0) {
                              Utilities.showAlert(
                                  context, "Please Enter Album Title");
                            } else if (releaseyearDropdown == 'Year') {
                              Utilities.showAlert(
                                  context, "Please Select Title");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          // color: Colors.white70,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontFamily: 'crimson',
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Utilities.songDetails.clear();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 18,
      maxHeight: 18,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  void _selectFolder() async {
    _resetState();
    try {
      String? path = await FilePicker.platform.getDirectoryPath();
      setState(() {
        _directoryPath = path;
        _userAborted = path == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  makeUploadSongApicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ApiService.uploadMp3("app-album-song-add", prefs.getString('userid'), widget.storageId, songTitle.text.toString(), filePath, song_featured_artists, song_produced_by, song_written_by).then((success) async {
    //   final body = json.decode(success);
    //   print(body);
    // });
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: ListView.builder(
            physics: ScrollPhysics(),
            key: UniqueKey(),
            itemBuilder: (context, index) {
              // Why network for web?
              // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFileList![index].path)
                    : Image.file(File(_imageFileList![index].path)),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  makeApicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Utilities.displayDialog(context);
    List taggedUsers = [];

    // convert each item to a string by using JSON encoding
    final jsonList = tagselectedUsers.map((item) => jsonEncode(item)).toList();

    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();

    // convert each item back to the original form using JSON decoding
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();

    // print(result);
    for (int i = 0; i < result.length; i++) {
      taggedUsers.add(result[i]['tag_link']);
      // print(tagselectedUsers[i]['tag_link']);
    }
    Map<String, dynamic> formMap = {
      "userId": prefs.getString('userid'),
      "companyId": prefs.getString('companyid'),
      "description": description.text.toString(),
      "tagedPeople": taggedUsers,
      "type": "Bulletin",
    };

    print(formMap);
    ApiService.postcall("app-add-bulletin-content", formMap)
        .then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      Utilities.showAlertHome(context, body["message"].toString());
    });
  }
}
