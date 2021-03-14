import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:map/utils/data.dart';
import 'package:map/utils/constant.dart';
import 'package:map/utils/filter.dart';
import 'package:map/screens/options.dart';
class crimeRate extends StatefulWidget {
  const crimeRate({Key key, this.drugs, this.molestation, this.other, this.murder, this.robbery}) : super(key: key);

  @override
  _crimeRateState createState() => new _crimeRateState();
  final int drugs;
  final int molestation;
  final int other;
  final int murder;
  final int robbery;
}

class _crimeRateState extends State<crimeRate> {
  // GoogleMapController mapController;

  String searchAddr;
  MapController controller = new MapController();



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(title: new Text('MapBox')),
      // drawer: NavDrawer(),
        body: Container(
            child: Stack(
              children: [
                new FlutterMap(
                  mapController: controller,
                  options: new MapOptions(
                      center: new LatLng(27.175002, 78.0421170902921), minZoom: 17.0),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                        "https://api.mapbox.com/styles/v1/sneha1010/ckm0kpd047vbu17s5vfv05hix/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic25laGExMDEwIiwiYSI6ImNrbTBoNmtyZzFuemEyb282NDJvNGVsNm8ifQ.ibv4D50An1QGJbZjXXK9YQ",
                        additionalOptions: {
                          'accessToken':
                          'pk.eyJ1Ijoic25laGExMDEwIiwiYSI6ImNrbTBoNmtyZzFuemEyb282NDJvNGVsNm8ifQ.ibv4D50An1QGJbZjXXK9YQ',
                          'id': 'mapbox.mapbox-streets-v7'
                        }),
                  ],
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyHomepage();
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 8.0),
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: blackshadow,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xff3E4958),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Crime Rate',
                            style:
//                          GoogleFonts.roboto(
//                              textStyle:
                            TextStyle(
                              color: Color(0xff3E4958),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,

//                              )
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return NavDrawer();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 90.0,
                    right: 15.0,
                    left: 15.0,
                    child: Container(
                      height: 47.52,
                      width: 320.64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(62.0),
                        color: Colors.white,
                        boxShadow: blackshadow,
                      ),
                      child: TextField(
                          decoration: InputDecoration(
                              hintText: 'search for a place',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 50.0, top: 15.0),
                              prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Color(0xff1152FD),
                                  ),
                                  onPressed: () {},
                                  iconSize: 30.0)),
                          onChanged: (val) {
                            setState(() {
                              searchAddr = val;
                            });
                          }),
                    )),
                Positioned(
                  bottom: 0,
                  right: 5.0,
                  left: 5.0,
                  child: Container(
                    // alignment: bas,
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: blackshadow,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(30.0),
                          topRight: const Radius.circular(30.0),
                        )),
                    child: Center(
                      child: Stack(
                        children: [HomePage(drugs: widget.drugs,molestation: widget.molestation,other: widget.other,murder: widget.other,robbery: widget.robbery,)],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
