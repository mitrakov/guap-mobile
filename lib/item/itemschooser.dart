import 'package:flutter/material.dart';
import 'package:guap_mobile/item/global.dart';

class ItemsChooser extends StatefulWidget {
  final String category;
  final ValueChanged<String> callback;
  const ItemsChooser(this.category, this.callback, {Key key}) : super(key: key);
  State<StatefulWidget> createState() => ItemsChooserState(category, callback);
}

class ItemsChooserState extends State<ItemsChooser> {
  final String category;
  final ValueChanged<String> callback;
  Future<List<String>> future;
  String currentValue;

  ItemsChooserState(this.category, this.callback);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: future,
      builder: (context2, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton( // TODO check stateless widget with Controller
            value: currentValue,
            hint: Text("Choose the value"),
            icon: Icon(Icons.keyboard_arrow_down),
            items: snapshot.data.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            elevation: 16,
            onChanged: (String newValue) {
              setState(() {
                callback(newValue);
                currentValue = newValue;
              });
            },
          );
        }
        if (snapshot.hasError)
          return Text("${snapshot.error}");
        return CircularProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    future = GlobalItemStore.get(category); // TODO move Future into a widget
  }
}
