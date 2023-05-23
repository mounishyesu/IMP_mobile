import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_player/helpers/Utilities.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../Apiservice/restApi.dart';
import '../../widgets/AppBar.dart';

class AddSongDetails extends StatefulWidget {
  const AddSongDetails({Key? key}) : super(key: key);

  @override
  State<AddSongDetails> createState() => _AddSongDetailsState();
}

class _AddSongDetailsState extends State<AddSongDetails> {
  File? imageFile;
  var description = TextEditingController();
  var url = TextEditingController();
  bool isList_visible = false;
  List urlList = [];
  var userOrcompany = TextEditingController();
  double? _distanceToField;
  String _itemCombine = 'withTextAfter';
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
  String artistDropdown = 'Produced by';
  String writtenByDropdown = 'Written by';
  String releaseyearDropdown = 'Year';
  String genreDropdown = 'Genre';
  String noofsogsDropdown = 'Number';
  var albumTitle = TextEditingController();
  var songTitle = TextEditingController();
  Offset? _tapPosition;
  var artist = [
    'Produced by',
    'Hip-Hop/Rap',
    'Pop',
    'Rnb/Blues',
    'Classical',
    'Folk/Regional',
  ];
  var writtenBy = [
    'Written by',
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
    getTaggedusers();
    _controller = TextfieldTagsController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.black87,
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/Services_BG.png",
                  ),
                  fit: BoxFit.fill)),
        child:  Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add Song Details",style: TextStyle(fontFamily: 'crimson',color: Color(0xFFffab00),),),
                    IconButton(onPressed: (){
                      _controller!.clearTags();
                      Navigator.pop(context);
                    },
                        icon: Icon(Icons.close_sharp,color:Color(0xFFffab00),)),
                  ],
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    color: Colors.white24,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ListBody(
                        children: [
                          Container(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    // margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Upload Song(MP3 format)",
                                      style: TextStyle(fontFamily: 'Crimson', color: Colors.white70,fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white70,
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
                                                    child:  AutoSizeText(_fileName.toString(),
                                                        maxLines: 2,
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            fontFamily: 'Crimson',
                                                            fontSize: 16,
                                                            color: Colors.white70)))
                                              ],
                                            ),
                                            onTap: (){
                                              _pickFiles();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height:10,),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Song Title",
                                      style: TextStyle(fontFamily: 'Crimson', color: Colors.white70,fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white70,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // padding: EdgeInsets.only(left: 20, right: 15,top: 10),
                                    width: 300,
                                    height: 50,
                                    child: TextField(
                                      controller: songTitle,
                                      style: TextStyle(color: Colors.white70),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 25,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:10,),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    // margin: EdgeInsets.only(left: 70),
                                    child: Text(
                                      "Featured Artists",
                                      style: TextStyle(fontFamily: 'Crimson', color: Colors.white70,fontSize: 15),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Autocomplete<String>(
                                        optionsViewBuilder: (context, onSelected, options) {
                                          return Container(
                                            width: 300,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 4.0),
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Material(
                                                color: Colors.black,
                                                elevation: 4.0,
                                                child: ConstrainedBox(
                                                  constraints:
                                                  const BoxConstraints(maxHeight: 200),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: options.length,
                                                    itemBuilder:
                                                        (BuildContext context, int index) {
                                                      final dynamic option =
                                                      options.elementAt(index);
                                                      return TextButton(
                                                        onPressed: () {
                                                          print("+++++++++++");
                                                          print(option.toString());
                                                          onSelected(option.toString());
                                                          setState(() {
                                                            for (int i = 0;
                                                            i < _pickUsers.length;
                                                            i++) {
                                                              if (_pickUsers[i] ==
                                                                  option.toString()) {
                                                                _tagselectedUsersImage
                                                                    .add(_pickImage[i]);
                                                              }
                                                            }
                                                            if (!_tagselectedUserslist
                                                                .contains(option.toString())) {
                                                              _tagselectedUserslist
                                                                  .add(option.toString());
                                                            }
                                                          });
                                                        },
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: SizedBox(
                                                            width: 300,
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                  vertical: 15.0),
                                                              child: Text(
                                                                '$option',
                                                                textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    fontFamily: 'Crimson',
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.white70),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        optionsBuilder: (TextEditingValue textEditingValue) {
                                          if (textEditingValue.text == '') {
                                            return const Iterable<String>.empty();
                                          }
                                          return _pickUsers.where((String option) {
                                            return option
                                                .contains(textEditingValue.text.toLowerCase());
                                          });
                                        },
                                        onSelected: (String selectedTag) {
                                          _controller!.addTag = selectedTag;
                                          for (int i = 0; i < _controller!.getTags!.length; i++) {
                                            for (int j = 0; j < tagUsers.length; j++) {
                                              if ((_controller!.getTags![i].toString() ==
                                                  tagUsers[j]["name"].toString())) {
                                                tagselectedUsers.add(tagUsers[j]);
                                                print("tagselectedUsers");
                                              }
                                            }
                                          }
                                        },
                                        fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
                                          return TextFieldTags(
                                            textEditingController: ttec,
                                            focusNode: tfn,
                                            textfieldTagsController: _controller,
                                            textSeparators: const ['\n ', ','],
                                            letterCase: LetterCase.normal,
                                            validator: (String tag) {
                                              if (_controller!.getTags!.contains(tag)) {
                                                return 'you already entered that';
                                              }
                                              return null;
                                            },
                                            inputfieldBuilder: (context, tec, fn, error,
                                                onChanged, onSubmitted) {
                                              return ((context, sc, tags, onTagDelete) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white70,
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  width: 300,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontFamily: 'Crimson',
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white70),
                                                      controller: tec,
                                                      focusNode: fn,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        helperStyle: TextStyle(
                                                            fontFamily: 'Crimson',
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.white70),
                                                        hintText: _controller!.hasTags
                                                            ? ''
                                                            : 'search for hints (user/company)...',
                                                        hintStyle: TextStyle(
                                                            fontFamily: 'Crimson',
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.white70),
                                                        errorText: error,
                                                        prefixIconConstraints: BoxConstraints(
                                                            maxWidth: _distanceToField! * 0.74),
                                                        prefixIcon: Container(
                                                          padding: EdgeInsets.only(
                                                              left: 15, right: 15),
                                                          decoration: BoxDecoration(
                                                            border: Border(
                                                                right: BorderSide(
                                                                  color: Colors.white70,
                                                                  width: 2.0,
                                                                )),
                                                          ),
                                                          child: Icon(
                                                            Icons.alternate_email_sharp,
                                                            color: Colors.white70,
                                                            size: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.05,
                                                          ),
                                                        ),
                                                      ),
                                                      onChanged: onChanged,
                                                      onSubmitted: onSubmitted,
                                                    ),
                                                  ),
                                                );
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: CustomScrollView(
                                      slivers: <Widget>[
                                        SliverList(
                                            delegate: SliverChildListDelegate([
                                              Padding(
                                                padding: EdgeInsets.all(10),
                                              ),
                                              _tags2,
                                            ])),
                                      ],
                                    ),
                                  ),
                                  /////////Usertags////////////////////////////////////
                                  SizedBox(height:10,),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Produced by",
                                      style: TextStyle(fontFamily: 'Crimson', color: Colors.white70,fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white70,
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
                                          color: Colors.white70,),
                                      items: artist.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,
                                              style: TextStyle(
                                                fontFamily: 'Crimson',
                                                color: Colors.white70,
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
                                  SizedBox(height:10,),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Written by",
                                      style: TextStyle(fontFamily: 'Crimson', color: Colors.white70,fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white70,
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
                                      value: writtenByDropdown,
                                      icon: const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.white70,),
                                      items: writtenBy.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,
                                              style: TextStyle(
                                                fontFamily: 'Crimson',
                                                color: Colors.white70,
                                              )),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          writtenByDropdown = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height:10,),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 50),
                                          child: TextButton(
                                            // color: Color(0xFFffab00),
                                            child: Text("Save",style:TextStyle(
                                                fontFamily: 'crimson', color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 16),),
                                            onPressed: (){
                                              var body = jsonEncode({"songSelected" : _fileName.toString(),"songTitle" : songTitle.text.toString()});
                                              Utilities.songDetails.add(body);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          child: TextButton(
                                            // color: Colors.red,
                                            child: Text("Cancel",style:TextStyle(
                                                fontFamily: 'crimson', color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                                            onPressed: (){
                                              _controller!.clearTags();
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
    );
  }

  Widget get _tags2 {
    //popup Menu
    final RenderObject? overlay =
    Overlay.of(context)?.context.findRenderObject();

    ItemTagsCombine combine = ItemTagsCombine.onlyText;

    switch (_itemCombine) {
      case 'onlyText':
        combine = ItemTagsCombine.onlyText;
        break;
      case 'onlyIcon':
        combine = ItemTagsCombine.onlyIcon;
        break;
      case 'onlyIcon':
        combine = ItemTagsCombine.onlyIcon;
        break;
      case 'onlyImage':
        combine = ItemTagsCombine.onlyImage;
        break;
      case 'imageOrIconOrText':
        combine = ItemTagsCombine.imageOrIconOrText;
        break;
      case 'withTextAfter':
        combine = ItemTagsCombine.withTextAfter;
        break;
      case 'withTextBefore':
        combine = ItemTagsCombine.withTextBefore;
        break;
    }

    return Tags(
      key: Key("2"),
      symmetry: _symmetry,
      columns: _column,
      horizontalScroll: _horizontalScroll,
      verticalDirection:
      _startDirection ? VerticalDirection.up : VerticalDirection.down,
      textDirection: _startDirection ? TextDirection.rtl : TextDirection.ltr,
      heightHorizontalScroll: 60 * (_fontSize / 14),
      itemCount: _tagselectedUserslist!.length,
      itemBuilder: (index) {
        final item = _tagselectedUserslist![index];

        return GestureDetector(
          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            image: ItemTagsImage(
                image: NetworkImage(_tagselectedUsersImage[index].toString())),
            title: item.toString(),
            pressEnabled: false,
            activeColor: Colors.green[400],
            combine: combine,
            removeButton: ItemTagsRemoveButton(
              backgroundColor: Colors.green[900],
              onRemoved: () {
                setState(() {
                  _tagselectedUserslist!.removeAt(index);
                  // _controller!.getTags!.remove(_list[index]);
                });
                return true;
              },
            ),
            textStyle: TextStyle(
              fontSize: _fontSize,
            ),
          ),
          onTapDown: (details) => _tapPosition = details.globalPosition,
          onLongPress: () {
            showMenu(
              //semanticLabel: item,
              items: <PopupMenuEntry>[
                PopupMenuItem(
                  child: Text(item.toString(),
                      style: TextStyle(color: Colors.blueGrey)),
                  enabled: false,
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.content_copy),
                      Text("Copy text"),
                    ],
                  ),
                ),
              ],
              context: context,
              position: RelativeRect.fromLTRB(65.0, 40.0, 0.0, 0.0),
            ).then((value) {
              if (value == 1)
                Clipboard.setData(ClipboardData(text: item.toString()));
            });
          },
        );
      },
    );
  }

  getTaggedusers() async {
    ApiService.getcall("app-artists-list").then((success) async {
      final body = json.decode(success);
      print("response====================================");
      print(body);
      setState(() {
        tagUsers = body["artist_list"] as List;
        for (int i = 0; i < tagUsers.length; i++) {
          _pickUsers.add(tagUsers[i]['name'].toString());
          _pickImage.add(tagUsers[i]['image'].toString());
        }
      });
    });
  }


  void _pickFiles() async {
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
      _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
    print(_paths![0].path);
    print("file path is+++++++++++++");
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

}
