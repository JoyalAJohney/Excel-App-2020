import 'package:excelapp/Models/event_details.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/backgroundImage.dart';
import 'package:excelapp/UI/Screens/EventPage/Widgets/eventDescription.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:excelapp/UI/Components/LikeButton/likeButton.dart';

class MoreDetails extends StatefulWidget {
  final EventDetails eventDetails;
  MoreDetails({Key key, @required this.eventDetails}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MoreDetailsState(eventDetails);
  }
}

class MoreDetailsState extends State<MoreDetails> {
  EventDetails eventDetails;
  MoreDetailsState(this.eventDetails);
  //Stores the current active tab in more details
  String activeTab = 'About';

  //All paddings made as multiples of _minpadding
  double _minpadding = 5.0;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: <Widget>[
      // Background Image
      getBackgroundImage(eventDetails, [
        Color.fromRGBO(0, 0, 0, 1),
        Color.fromRGBO(23, 18, 41, 0.8),
        // primaryColor,
        Color.fromRGBO(0, 0, 0, .6)
      ]),

      Container(
          child: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: _minpadding * 7, top: deviceHeight * 0.15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Event Name Details
                  Expanded(
                    child: Hero(
                      tag: 'EventName',
                      child: Text(eventDetails.name,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: pfontFamily,
                              height: 1.0,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ),

                  //Like Button
                  Hero(
                    tag: 'LikeButton',

                    //Code to make the button under a Material widget during animation which otherwise throws error
                    flightShuttleBuilder: (BuildContext flightContext,
                            Animation<double> animation,
                            HeroFlightDirection flightDirection,
                            BuildContext fromHeroContext,
                            BuildContext toHeroContext) =>
                        Material(
                            type: MaterialType.transparency,
                            child: toHeroContext.widget),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: LikeButton(false),
                    ),
                  ),
                ],
              )),

          //EventDetails
          getEventDetails(eventDetails, _minpadding),

          SizedBox(height: _minpadding * 2),

          // More details card
          Container(
            height: deviceHeight * .65,
            padding: EdgeInsets.only(top: _minpadding),
            child: Hero(
              tag: 'Card',
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 4,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(60),
                      child: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        bottom: TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: primaryColor,
                          labelColor: primaryColor,
                          labelStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          tabs: [
                            Tab(
                              text: 'About',
                            ),
                            Tab(
                              text: 'Format',
                            ),
                            Tab(
                              text: 'Rules',
                            ),
                            Tab(
                              text: 'Contacts',
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.white,
                      child: TabBarView(
                        children: [
                          details(eventDetails.about),
                          details(eventDetails.format),
                          details(eventDetails.rules),
                          contactDetails(eventDetails.contacts)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    ]));
  }

  Widget details(txt) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Text(
          txt.toString(),
          style: TextStyle(color: primaryColor),
        ),
      ),
    );
  }

  Widget contactDetails(List<dynamic> details) {
    List<Widget> finDetails = [];
    for (int i = 0; i < details.length; i++) {
      finDetails.add(SizedBox(height: 10));
      finDetails.add(
        contactDetailRow(Icons.person, details[i]['name']),
      );
      finDetails.add(
        contactDetailRow(Icons.blur_on, details[i]['responsibility']),
      );
      finDetails.add(
        contactDetailRow(Icons.phone, details[i]['phone_number']),
      );
      finDetails.add(
        contactDetailRow(Icons.email, details[i]['email']),
      );
      finDetails.add(SizedBox(height: 30));
    }
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: finDetails,
          )),
    );
  }

  Widget contactDetailRow(var icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          icon,
          size: 15.0,
          color: primaryColor,
        ),
        Container(padding: EdgeInsets.only(right: _minpadding * 2)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: primaryColor,
              fontSize: 16.0,
              decoration: TextDecoration.none,
              fontFamily: 'Quicksand-Light',
            ),
          ),
        )
      ],
    );
  }
}