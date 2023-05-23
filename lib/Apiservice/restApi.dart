import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class URLS {
  static const String BASE_URL = 'https://thecxoleague.com/imp';
}

class Headers {
  static const Map<String, String> headers = {
    "Content-type": "application/x-www-form-urlencoded",
    "Authorization": "b8416f2680eb194d61b33f9909f94b9d"
  };
}

class ApiService {
  static Future<String> getUserPlaylists(Map<String, dynamic> body) async {
    try {
      final Uri path = Uri.parse('${URLS.BASE_URL}/app-login');

      final response = await post(
        path,
        headers: {
          'Authorization': 'b8416f2680eb194d61b33f9909f94b9d',
          'Accept': 'application/json'
        },
        body: body
      );
      // if (response.statusCode == 200) {
        // final result = jsonDecode(response.body);
        // final List playlists = result['items'] as List;
      print(response.body);
        return response.body;
      // }
    } catch (e) {
      // print('Error: $e');
    }
    return "";
  }

  static Future<String> postcall(String url,Map<String, dynamic> body) async {
    try {
      final Uri path = Uri.parse('${URLS.BASE_URL}/'+url+'');
      print(path.toString());
      final response = await post(
          path,
          headers: {
            'Authorization': 'b8416f2680eb194d61b33f9909f94b9d',
            'Accept': 'application/json'
          },
          body: body
      );
      // if (response.statusCode == 200) {
      // final result = jsonDecode(response.body);
      // final List playlists = result['items'] as List;
      print(path.toString());
      print(response.body);
      return response.body;
      // }
    } catch (e) {
      // print('Error: $e');
    }
    return "";
  }

static Future<String> getcall(String url) async {
    try {
      final Uri path = Uri.parse('${URLS.BASE_URL}/'+url+'');

      final response = await post(
          path,
          headers: {
            'Authorization': 'b8416f2680eb194d61b33f9909f94b9d',
            'Accept': 'application/json'
          },
      );
      // if (response.statusCode == 200) {
      // final result = jsonDecode(response.body);
      // final List playlists = result['items'] as List;
      print(path.toString());
      print(response.body);
      return response.body;
      // }
    } catch (e) {
      // print('Error: $e');
    }
    return "";
  }


static Future<String> uploadImage(String url,String userId,String companyId,String descreption,String filePath,List taggedUsers) async {
  var postUri = Uri.parse('${URLS.BASE_URL}/'+url+'');

  http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

  Map<String, String> headers = {
  "Content-Transfer-Encoding": "multipart/form-data",
};
  http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'bulletinImage', filePath);

  request.files.add(multipartFile);
  request.headers.addAll(headers);
  request.fields["userId"] = userId;
  request.fields["companyId"] = companyId;
  request.fields["description"] = descreption;
  request.fields["tagedPeople"] = taggedUsers.toString();

  http.StreamedResponse response = await request.send();

  print(response.statusCode);
  return response.toString();
  }
static Future<String> uploadMp3(String url,String userId,String storage,String song_title,String filePath,List song_featured_artists,String song_produced_by,String song_written_by,) async {
  var postUri = Uri.parse('${URLS.BASE_URL}/'+url+'');

  http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

  Map<String, String> headers = {
  "Content-Transfer-Encoding": "multipart/form-data",
  "Content-Type":"application/x-www-form-urlencoded",
};
  http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'song_track', filePath);

  request.files.add(multipartFile);
  request.headers.addAll(headers);
  request.fields["userId"] = userId;
  request.fields["storage"] = storage;
  request.fields["song_title"] = song_title;
  request.fields["song_featured_artists"] = song_featured_artists.toString();
  request.fields["song_produced_by"] = song_produced_by;
  request.fields["song_written_by"] = song_written_by;

  http.StreamedResponse response = await request.send();

  print(response.statusCode);
  return response.toString();
  }

static Future<String> uploadComapnyLogo(String url,String usedId,String companyId,String filePath) async {
  var postUri = Uri.parse('${URLS.BASE_URL}/'+url+'');
print(postUri);
  http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

  http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'logoImage', filePath);

  request.files.add(multipartFile);
  request.fields["userId"] = usedId;
  request.fields["companyId"] = companyId;

  http.StreamedResponse response = await request.send();


  print(response.statusCode);
  return response.toString();
  }

static Future<String> uploadComapnyCoverLogo(String url,String usedId,String companyId,String filePath) async {
  var postUri = Uri.parse('${URLS.BASE_URL}/'+url+'');
print(postUri);
  http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

  http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'coverImage', filePath);

  request.files.add(multipartFile);
  request.fields["userId"] = usedId;
  request.fields["companyId"] = companyId;

  http.StreamedResponse response = await request.send();


  print(response.statusCode);
  return response.toString();
  }


}
