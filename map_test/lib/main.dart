import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
   @override
   State<StatefulWidget> createState() => MyAppState();
}
class MyAppState extends State<MyApp> {

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  //Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
      super.initState();
      setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/destination_map_marker.png");
  }



  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(37.3797536, -122.1017334);
    GoogleMapController mapController;
    String buscarDireccion;
    
    // these are the minimum required values to set 
    // the camera position 
    CameraPosition initialLocation = CameraPosition(
        zoom: 16,
        bearing: 30,
        target: pinPosition
    );

    barraBusqueda() {
      print(buscarDireccion);
      Geolocator().placemarkFromAddress(buscarDireccion).then((result) {

              print("El resultado es es:  $result");

              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target:
                      LatLng(result[0].position.latitude, result[0].position.longitude),
                  zoom: 10.0)));
      });
      
      //print('JAIME LOMBANA '  +  buscarDireccion);
      

    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            markers: _markers,
            initialCameraPosition: initialLocation,
            onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(Utils.mapStyles);
                //_controller.complete(controller);
                setState(() {
                  mapController = controller; 
                  _markers.add(
                      Marker(
                        markerId: MarkerId("JAime"),
                        position: pinPosition,
                        icon: pinLocationIcon
                      )
                  );
                });
            }),
            Positioned(
              top: 80.0, 
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white
                ),
                child: TextField(
                  onChanged: (text) {
                      print("First text field: $text");
                      buscarDireccion = text;
                  },
                  decoration: InputDecoration(
                    hintText: "Ingrese Direccion a Buscar",
                    border: InputBorder.none, 
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: barraBusqueda,
                        iconSize: 30.0,
                      ),
                    )
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}