import 'package:flutter/material.dart';
import 'package:responsi/model/api_data_source.dart';
import 'package:responsi/model/job_model.dart';
import 'package:responsi/view/bookmark.dart';
import 'package:responsi/view/detail.dart';
import 'package:responsi/view/login.dart';
import 'package:responsi/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String username = "";
  late SharedPreferences pref;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BookmarkPage(),
    ProfilePage(),
  ];

  void setPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("user")!;
    });
  }

  @override
  void initState() {
    super.initState();
    setPref();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //hancur session
            pref.remove("username");
            pref.remove("password");
            pref.remove("newUser");
            //sementara
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          },
          icon: Icon(Icons.logout_sharp),
        ),
        backgroundColor: Colors.green,
        title: Text('Jobs Data', style: TextStyle(color: Colors.white)),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadJobs(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            JobData jobData = JobData.fromJson(snapshot.data);
            return ListView.builder(
              itemCount: jobData.jobs?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final job = jobData.jobs?[index];
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                                detail: jobData.jobs![index],
                              ))),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Placeholder for image
                            Container(
                                child: Image.network(
                              job?.companyLogo ?? '',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            )),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job?.jobTitle ?? 'No Job Title',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    job?.jobType?[0] ?? 'No Job Type',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${job?.companyName ?? 'No Company'}, ${job?.jobGeo ?? 'No Country'}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${job?.annualSalaryMin ?? 'N/A'} - ${job?.annualSalaryMax ?? 'N/A'}",
                                    style: TextStyle(color: Colors.grey),
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
              },
            );
          }
          return Center(
            child: Text("No Data Available"),
          );
        },
      ),
    );
  }
}

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Bookmark Screen"),
    );
  }
}
