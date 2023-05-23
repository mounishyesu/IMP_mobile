import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search",
          style: TextStyle(
              fontFamily: 'Crimson',
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Container(
    decoration: new BoxDecoration(
    color: Colors.black87,
    image: DecorationImage(
    image: AssetImage(
    "assets/images/Services_BG.png",
    ),
    fit: BoxFit.fill)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child:  Container(
                height: 52,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFffab00),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFffab00),
                        width: 1.0,
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: 'Search....',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFffab00),
                      fontFamily: 'Crimson',
                      fontSize: 16
                    ),
                    suffixIcon: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: Color(0xFFffab00), width: 1)),
                      ),
                      child: Icon(
                        Icons.search,
                        color: Color(0xFFffab00),
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty || value.length < 3) {
                  //     return "Please enter valid Email";
                  //   }
                  //   return null;
                  // },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Text('Your Top Genres',style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  fontFamily: 'Crimson',
                  fontSize: 22,
              ),),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.black87,
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('POP',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontFamily: 'Crimson',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                    Card(
                      color: Colors.black87,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        height: 100,
                        width: 150,
                        child: Text('Hip Hop',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontFamily: 'Crimson',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.black87,
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Rap',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontFamily: 'Crimson',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                    Card(
                      color: Colors.black87,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        height: 100,
                        width: 150,
                        child: Text('Hip Hop',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontFamily: 'Crimson',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),
      ),
    );
  }
}
