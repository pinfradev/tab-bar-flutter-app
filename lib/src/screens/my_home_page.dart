import 'package:flutter/material.dart';
import 'package:proyecto_curso_dart/src/api/api.dart';
import 'package:proyecto_curso_dart/src/models/photos.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final API api = API();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Photos>>(
        future: api.getPhotos(),
        builder: (BuildContext context, AsyncSnapshot<List<Photos>> snapshot) {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(snapshot.data[index].thumbnailUrl),
                        ),
                        title: Text(snapshot.data[index].id.toString()),
                        subtitle: Text("descripcion ${snapshot.data[index].id}"),
                      ),
                    );
                }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }

  Widget customContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Text("platzi".toUpperCase()),
      decoration: BoxDecoration(
          color: Colors.purple,
          border: Border.all(
            color: Colors.teal,
            width: 5.0,
          )
      ),
      transform: Matrix4.rotationZ(0.05),
      constraints: BoxConstraints(maxWidth: 100.0),
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  @override
  final Text text;
  final double width;
  final double height;
  final List<Color> gradientColors;
  final Alignment initialPosition;
  final Alignment finalPosition;
  final Function function;
  final Icon leadingIcon;
  final Icon finalIcon;

  const CustomGradientButton({
    Key key,
    @required this.text,
    @required this.width,
    @required this.height,
    @required this.gradientColors,
    @required this.initialPosition,
    @required this.finalPosition,
    @required this.function,
    this.leadingIcon,
    this.finalIcon}) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
           topRight: Radius.circular(height/2)
          ),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: initialPosition,
              end: finalPosition,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, -2),
                  blurRadius: height * 0.1,
                  spreadRadius: 1
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            leadingIcon ?? Container(), // si es null muestra un container vacio o sea nada
            text,
            finalIcon ?? Offstage()
          ],
        ),
      )
    );


  }

  
}
