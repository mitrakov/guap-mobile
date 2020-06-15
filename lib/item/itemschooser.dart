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
  String currentValue;

  ItemsChooserState(this.category, this.callback);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: GlobalItemStore.get(category), // it's ok to run future here because it's cached
      builder: (context2, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton(
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
            }
          );
        }
        if (snapshot.hasError)
          return Text("${snapshot.error}");
        return CircularProgressIndicator();
      }
    );
  }
}
