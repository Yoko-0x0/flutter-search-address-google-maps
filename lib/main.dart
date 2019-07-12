import 'package:flutter/material.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';

import 'GooglePlacesAutocomplete.dart';
import 'address.model.dart';

void main() {
  runApp(new MaterialApp(
    home: MyApp(),
  ));
}

var apiKey = "AIzaSyDA-nOGycobLHBukkhkhTuDjjxv38Nz_MI";

class MyApp extends StatefulWidget {
  final TextEditingController textEditingController =
      new TextEditingController(text: "");

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var result = "result:";

  @override
  Widget build(BuildContext context) {
    showSearch() async {
      var pop = await showGooglePlacesAutocomplete(
          apiKey: apiKey,
          context: context,
          textFieldReferenceController: widget.textEditingController);
      if (pop != null) {
        var obj = new Address();
        obj.address = pop.structuredFormatting.mainText;
        obj.addressComplement = pop.structuredFormatting.secondaryText;

        setState(() {
          result = "address: ${obj.address} - addressComplement:  ${obj.addressComplement} ";
          print(result);
        });
      }
    }

    return new Scaffold(
        appBar: AppBar(
          title: Text("app"),
          actions: <Widget>[
            MaterialButton(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: showSearch)
          ],
        ),
        body: Text(result));
  }

  Future<Prediction> showGooglePlacesAutocomplete(
      {@required BuildContext context,
      @required String apiKey,
      final TextField textFieldReference,
      final TextEditingController textFieldReferenceController,
      String hint = "Buscar",
      num offset,
      Location location,
      num radius,
      String language,
      List<String> types,
      List<Component> components,
      bool strictbounds,
      ValueChanged<PlacesAutocompleteResponse> onError}) {
    final builder = (BuildContext ctx) => new GooglePlacesAutocomplete(
          apiKey: apiKey,
          textEditingController: textFieldReferenceController,
          language: language,
          components: components,
          types: types,
          location: location,
          radius: radius,
          strictbounds: strictbounds,
          offset: offset,
          hint: hint,
          onError: onError,
        );

    return showDialog(context: context, builder: builder);
  }
}
