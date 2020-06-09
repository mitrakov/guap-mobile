import 'package:flutter/material.dart';
import 'package:guap_mobile/item/global.dart';

class ItemsChooser extends StatefulWidget {
  final String category;
  const ItemsChooser(this.category, {Key key}) : super(key: key);
  State<StatefulWidget> createState() => ItemsChooserState(category);
}

class ItemsChooserState extends State<ItemsChooser> {
  final String category;
  Future<List<String>> future;
  String currentValue;

  ItemsChooserState(this.category);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: future,
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
    future = GlobalItemStore.get(category);
  }
}
