
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void dialogAlert() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(elevation: 50.6,
          title: Text("error"),

          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  var _color = Colors.white;

  String answer = "0";

  String tempAnswer = "0";
  double n1 = 0.0;
  double n2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      tempAnswer = "0";
      n1 = 0.0;
      n2 = 0.0;
      operand = "";
      setState(() {
        _color = Colors.white;
      });
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X") {
      n1 = double.parse(answer);

      operand = buttonText;

      tempAnswer = "0";
    } else if (buttonText == ".") {
      if (tempAnswer.contains(".")) {
        // print("Already conatains a decimals");
        dialogAlert();
      } else {
        tempAnswer = tempAnswer + buttonText;
      }
    }
    else if (buttonText == "=") {
      n2 = double.parse(answer);

      if (operand == "+") {
        tempAnswer = (n1 + n2).toString();
      }
      if (operand == "-") {
        tempAnswer = (n1 - n2).toString();
      }
      if (operand == "X") {
        tempAnswer = (n1 * n2).toString();
      }
      if (operand == "/") {
        tempAnswer = (n1 / n2).toString();
      }

      n1 = 0.0;
      n2 = 0.0;
      operand = "";
      setState(() {
        _color = Colors.green;
      });
    }
    else {
      tempAnswer = tempAnswer + buttonText;
    }

    print(tempAnswer);

    setState(() {
      answer = double.parse(tempAnswer).toStringAsFixed(2);
    });
  }

  Widget Button(String buttonText) {
    return Expanded(
      child: FlatButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        padding: EdgeInsets.all(25.0),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        onPressed: (){ buttonPressed(buttonText);
        setState(() {
          if(_color==Colors.green){
            _color=Colors.white;
          };
        });

        },
      ),
    );
  }

  Widget operandButton(String buttonText) {
    return Expanded(
      child: FlatButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        padding: EdgeInsets.all(25.0),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        onPressed: (){ buttonPressed(buttonText);



        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedContainer(
        //height: 10 ,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 150),
        color:_color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Row(children: [
                Button("7"),
                Button("8"),
                Button("9"),
                Button("/")
              ]),
              Row(children: [
                Button("4"),
                Button("5"),
                Button("6"),
                Button("X")
              ]),
              Row(children: [
                Button("1"),
                Button("2"),
                Button("3"),
                Button("-")
              ]),
              Row(children: [
                Button("."),
                Button("0"),
                Button("00"),
                Button("+")
              ]),
              Row(children: [
                Button("CLEAR"),
                operandButton("="),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
