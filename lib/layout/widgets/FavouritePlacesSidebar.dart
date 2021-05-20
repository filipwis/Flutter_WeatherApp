import 'package:flutter/material.dart';
import 'package:flutter_weather_app/layout/screens/HomeScreen.dart';

class FavouritePalceSidebar extends StatefulWidget {
  final Function changeSidebarState;
  FavouritePalceSidebar(this.changeSidebarState);
  @override
  _FavouritePalceSidebarState createState() => _FavouritePalceSidebarState();
}

class _FavouritePalceSidebarState extends State<FavouritePalceSidebar> {
  var favouritePlaces = ['Zakopane', 'Kraków', 'Sopot'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: 260,
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    widget.changeSidebarState();
                  },
                  icon: Icon(Icons.close_outlined),
                  iconSize: 35.0,
                )),
            SizedBox(
              height: 35,
            ),
            Text(
              'Ulubione miejsca',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 300,
              height: 250,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: favouritePlaces.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: IconButton(
                        onPressed: () =>
                            {setState(() => favouritePlaces.removeAt(index))},
                        icon: Image.asset('assets/heart-red.png'),
                      ),
                      title: Text(favouritePlaces[index]),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
