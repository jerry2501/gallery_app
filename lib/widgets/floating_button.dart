import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ActionButton extends StatelessWidget {
  final Function pickImage;

  const ActionButton({Key key,@required this.pickImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      child: Icon(Icons.add),
      overlayColor: Theme.of(context).accentColor,
      overlayOpacity: 0.2,
      curve: Curves.easeIn,
      closeManually: false,
      children: [
        SpeedDialChild(
          child: Icon(Icons.image),
          label: "Pick from Device/Drive",
          backgroundColor: Theme.of(context).accentColor,
          onTap: (){
            pickImage('gallery');
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.camera),
          label: "Pick from Camera",
          backgroundColor: Theme.of(context).accentColor,
          onTap: (){
            pickImage('camera');
          },
        )
      ],
    );
  }
}
