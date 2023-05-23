import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../Apiservice/restApi.dart';
import '../../helpers/Utilities.dart';
import '../../widgets/AppBar.dart';
import '../../widgets/drawer.dart';

class PictureUploadForm extends StatefulWidget {
  const PictureUploadForm({
    Key? key,
  }) : super(key: key);

  @override
  _PictureUploadFormState createState() => _PictureUploadFormState();
}

class _PictureUploadFormState extends State<PictureUploadForm> {
  List<XFile>? _imageFileList;
  String? _retrieveDataError;
  dynamic _pickImageError;
  String path = " ";
  String uploadPath = " ";
  bool isList_visible = false;
  List urlList = [];
  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  TextEditingController description = TextEditingController();
  TextEditingController iFrame = TextEditingController();
  TextEditingController videoUrl = TextEditingController();
  TextEditingController userOrcompany = TextEditingController();
  bool isImage = false;
  List tagUsers = [];
  List tagselectedUsers = [];
  List _tagselectedUserslist = [];
  List _tagselectedUsersImage = [];
  bool _horizontalScroll = false;
  double _fontSize = 16;
  String _itemCombine = 'withTextAfter';
  bool _symmetry = false;
  bool _startDirection = false;
  int _column = 0;
  List<String> _pickUsers = [];
  List<String> _pickImage = [];
  TextfieldTagsController? _controller;
  double? _distanceToField;

  @override
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
                /////////////heading/////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                    ),
                    Container(
                      child: Text(
                        'Share A Picture On Bulletin',
                        style: TextStyle(
                            fontFamily: 'crimson',
                            color: Color(0xFFffab00),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 60),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        tooltip: "back",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          'assets/images/return-icon.jpg',color: Color(0xFFffab00),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                //////////////image//////////////////

                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Image*",
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
                                  child: _imageFileList == null
                                      ? Text("No file choosen",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontFamily: 'Crimson',
                                              fontSize: 16,
                                              color: Colors.white))
                                      : AutoSizeText(path,
                                          maxLines: 2,
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Crimson',
                                              fontSize: 16,
                                              color: Colors.white)))
                            ],
                          ),
                          onTap: () async {
                            final pickedFileList = await _picker.pickMultiImage(
                              imageQuality: 100,
                            );
                            setState(() {
                              _imageFileList = pickedFileList;
                              uploadPath = _imageFileList![0].path;
                              print(_imageFileList![0].path);
                              // var str = uploadPath;
                              // var parts = str.split('/');
                              // var prefix = parts[parts.length-1].trim();
                              path = _imageFileList![0].path.substring(63);
                              print(path);
                            });
                            isImage = true;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                 Visibility(
                  visible: isImage,
                  child: Container(
                    padding: EdgeInsets.only(left: 50,right: 50,),
                    height: MediaQuery.of(context).size.height*0.5,
                    width:  MediaQuery.of(context).size.width,
                    child: Card(
                      color: Colors.transparent,
                      child: FutureBuilder<void>(
                        future: retrieveLostData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Container(
                                margin: EdgeInsets.only(top: 50),
                                child: const Text(
                                  'You have not yet picked an image.',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            case ConnectionState.done:
                              return _handlePreview();
                            default:
                              if (snapshot.hasError) {
                                return Text(
                                  'Pick image/video error: ${snapshot.error}}',
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                return const Text(
                                  'You have not yet picked an image.',
                                  textAlign: TextAlign.center,
                                );
                              }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //////////////Description//////////////////

                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Description",
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
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white70,
                        fontSize: 18),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20, top: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ), /////Auto complete////
                SizedBox(
                  height: 20,
                ),

                //////////////Users(or)Company Auto complete//////////////////

                /////////Usertags///////////////////////////////////
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Users(or)Company",
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        color: Colors.white,
                        fontSize: 20),
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
                              color: Colors.black87,
                              elevation: 4.0,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 200),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final dynamic option = options.elementAt(index);
                                    return TextButton(
                                      onPressed: () {
                                        print("+++++++++++");
                                        print(option.toString());
                                        onSelected(option.toString());
                                        setState(() {
                                          for(int i=0;i<_pickUsers.length;i++){
                                            if(_pickUsers[i] == option.toString()){
                                              _tagselectedUsersImage.add(_pickImage[i]);
                                            }
                                          }
                                          if (!_tagselectedUserslist.contains(option.toString())) {
                                            _tagselectedUserslist.add(option.toString());
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
                          return option.contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selectedTag) {
                        _controller!.addTag = selectedTag;
                        for(int i=0;i< _controller!.getTags!.length;i++){
                          for(int j=0;j< tagUsers.length;j++){
                            if((_controller!.getTags![i].toString() == tagUsers[j]["name"].toString()) ){
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
                          inputfieldBuilder:
                              (context, tec, fn, error, onChanged, onSubmitted) {
                            return ((context, sc, tags, onTagDelete) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFffab00).withOpacity(0.4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: 300,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                      hintText: _controller!.hasTags ? '' : 'search for hints (user/company)...',
                                      hintStyle: TextStyle(
                                          fontFamily: 'Crimson',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70),
                                      errorText: error,
                                      prefixIconConstraints: BoxConstraints(
                                          maxWidth: _distanceToField! * 0.74),
                                      prefixIcon: Container(
                                        padding: EdgeInsets.only(left: 15, right: 15),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                color: Color(0xFFffab00).withOpacity(0.4),
                                                width: 2.0,
                                              )),
                                        ),
                                        child: Icon(
                                          Icons.alternate_email_sharp,
                                          color: Color(0xFFffab00),
                                          size: MediaQuery.of(context).size.width * 0.05,
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

                ///////////Url//////////////////////

                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 70),
                  child: Text(
                    "Url",
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
                  child: TextFormField(
                    style: TextStyle(
                        fontFamily: 'Crimson',
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
                    controller: videoUrl,
                    onChanged: ((String url) {
                      setState(() {
                        url = url;
                      });
                    }),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'example.com',
                      hintStyle: TextStyle(
                          fontFamily: 'Crimson',
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                      prefixIcon: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                            color: Color(0xFFffab00).withOpacity(0.4),
                            width: 2.0,
                          )),
                        ),
                        child: Icon(
                          Icons.link_sharp,
                          color: Color(0xFFffab00),
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                            color: Color(0xFFffab00).withOpacity(0.4),
                            width: 2.0,
                          )),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              if(videoUrl.text.length > 0) {
                                isList_visible = true;
                                urlList.add(videoUrl.text.toString());
                              }else{
                                Utilities.showAlert(context, "Empty text cannot be taken");
                              }
                              videoUrl.clear();
                            });
                          },
                          child: Icon(
                            Icons.send,
                            color: Color(0xFFffab00),
                            size: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: isList_visible,
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: urlList.length,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(padding: EdgeInsets.only(left: 50,right: 50),
                            child: SizedBox(
                              height: 50,
                              child: Card(
                                color: Colors.black.withOpacity(0.8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width:260,
                                      child: Text(urlList[index].toString(),style: TextStyle(
                                          fontFamily: 'crimson',
                                          color: Color(0xFFffab00),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),),
                                    ),
                                    GestureDetector(
                                      onTap:(){
                                        print("ontapped");
                                        setState(() {
                                          urlList.remove(urlList[index]);
                                          if(urlList.length == 0){
                                            isList_visible = false;
                                          }
                                        });
                                      },
                                      child:Icon(
                                        Icons.clear,
                                        color: Color(0xFFffab00),
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),);
                        }
                    ),
                  ),
                ),
                ////////////Buttons////////////////
                SizedBox(
                  height: 20,
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
                            makeApiupload();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
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

  Offset? _tapPosition;

  Widget get _tags2 {
    //popup Menu
    final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();

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
                  child: Text(item.toString(), style: TextStyle(color: Colors.blueGrey)),
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
            )
                .then((value) {
              if (value == 1) Clipboard.setData(ClipboardData(text: item.toString()));
            });
          },
        );
      },
    );
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
                    ? Image.network(
                        _imageFileList![index].path,
                        fit: BoxFit.fill,
                      )
                    : Image.file(File(_imageFileList![index].path),
                        fit: BoxFit.contain,width: 500,height: 500,),
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
  makeApiupload() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List taggedUsers = [];

    // convert each item to a string by using JSON encoding
    final jsonList = tagselectedUsers.map((item) => jsonEncode(item)).toList();

    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();

    // convert each item back to the original form using JSON decoding
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();

    // print(result);
    for(int i=0;i<result.length;i++){
      taggedUsers.add(result[i]['tag_link']);
      print(tagselectedUsers[i]['tag_link']);
    }
    print(uploadPath);
    ApiService.uploadImage("app-add-bulletin-image",prefs.getString('userid'),prefs.getString('companyid'),description.text.toString(),uploadPath,taggedUsers).then((success) async {
      final body = json.decode(success);
      print(body);
    });
  }

  getTaggedusers() async {
    ApiService.getcall("app-tag-users-companys")
        .then((success) async {
      final body =
      json.decode(success);
      print("response====================================");
      print(body["tag_people_list"]);
      setState(() {
        tagUsers = body["tag_people_list"] as List;
        for(int i=0;i<tagUsers.length;i++){
          _pickUsers.add(tagUsers[i]['name'].toString());
          _pickImage.add(tagUsers[i]['image'].toString());
        }
      });
    });
  }
}
