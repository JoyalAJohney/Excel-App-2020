import 'package:excelapp/UI/Screens/EventLists/eventsList.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryCard extends StatelessWidget {
  final Map<String, String> category;
  CategoryCard(this.category);

  final titleStyle = TextStyle(
    color: Colors.white,
    fontFamily: pfontFamily,
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );
  final contentStyle = TextStyle(
    color: Colors.white,
    fontFamily: sfontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Image
          Container(
            child: CachedNetworkImage(
              imageUrl: category['imageUrl'],
              fit: BoxFit.cover,
            ),
          ),
          // Gradient
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [primaryColor, primaryColor],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          // Details
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title
                Text(
                  category['name'],
                  style: titleStyle,
                ),
                SizedBox(height: 5),
                Text(
                  category['info'],
                  style: contentStyle,
                ),
                SizedBox(height: 10),
                OutlineButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventsList(category['name']),
                      ),
                    );
                  },
                  child:
                      Text('View', style: TextStyle(fontFamily: pfontFamily)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
