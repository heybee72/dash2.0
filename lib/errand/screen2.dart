import 'package:flutter/material.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Vendors',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
                child: TextField(
                  controller: _searchTextController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.search,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.cancel_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    hintText: "Type here",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  leading: Image.asset(
                    'assets/errand/v1.png',
                    height: 50,
                    width: 50,
                  ),
                  title: Text(
                    'Arewa Pharmaceuticals',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Color(0xff7F53BF)),
                  ),
                  subtitle: Text('Pharmacies'),
                ),
              ),
              Card(
                elevation: 0,
                child: ListTile(
                  leading: Image.asset(
                    'assets/errand/v1.png',
                    height: 50,
                    width: 50,
                  ),
                  title: Text(
                    'Tantalizer',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Color(0xffF12525)),
                  ),
                  subtitle: Text('Fast food'),
                ),
              ),

              Card(
                elevation: 0,
                child: ListTile(
                  leading: Image.asset(
                    'assets/errand/v1.png',
                    height: 50,
                    width: 50,
                  ),
                  title: Text(
                    'Shoppy',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Color(0xff46AEF8)),
                  ),
                  subtitle: Text('Fast food'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
