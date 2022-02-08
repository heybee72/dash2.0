
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SearchScreen extends StatefulWidget {
   
   static const routeName = '/search-screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // StoreApi storeApi = StoreApi();
  TextEditingController _searchTextController = TextEditingController();
  FocusNode _blankFocusNode = FocusNode();
  bool showError = false;
  bool loading = true;
  bool init = true;
  String _errorMessage = '';
  // SearchModel search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 32.0, bottom: 21.0),
                child: Text(
                  "Search",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 60.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Constants.background_color_2,
                  borderRadius: BorderRadius.circular(8.0)),
              child: TextField(
                controller: _searchTextController,
                cursorColor: Constants.secondary_color,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.search,
                      size: 20.0,
                      color: Constants.grey_color,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      showError = false;
                      setState(() {
                        loading = true;
                      });
                    

                      setState(() {
                        loading = false;
                        // showError = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        height: 15,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Constants.secondary_color,
                        ),
                        child: ImageIcon(AssetImage('assets/search_light.png'),
                            size: 20.0, color: Constants.background_color_2),
                      ),
                    ),
                  ),
                  hintText: "",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.secondary_color),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: init
                  ? Container(
                      child: Center(
                        child: Text(
                          'Search For Item Or Strore',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : loading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          child: showError
                              ? Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error,
                                        size: 50,
                                        color: Colors.grey[400],
                                      ),
                                      Text(_errorMessage),
                                    ],
                                  ),
                                )
                              : Container(),
                          // ListView.builder(
                          //     shrinkWrap: true,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     // itemCount: search.data.length,
                          //     itemBuilder: (context, index) {
                          //       Size size = MediaQuery.of(context).size;

                          //       return StoreItemII(
                          //         size: size,
                          //         // store: search.data[index],
                          //       );
                          //     },
                          //   ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
