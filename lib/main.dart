import 'package:flutter/material.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AppConversion(),
    );
  }
}

class AppConversion extends StatefulWidget {
  const AppConversion({super.key});

  @override
  State<AppConversion> createState() => _AppConversionState();
}

class _AppConversionState extends State<AppConversion> {
  late double toconvert;
  late double result;
  late bool FtoC;
  @override
  void initState() {
    super.initState();
    toconvert = 0.0;
    result = 0.0;
    FtoC = true;
  }

  Widget build(BuildContext context) {
    TextField input = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          toconvert = double.parse(str);
        } catch (e) {
          toconvert = 0.0;
        }
      },
      decoration: InputDecoration(
        labelText:
            "Input a Value in ${FtoC == false ? "Fahrenheit" : "Celsius"}",
      ),
    );
    Container tempSwitch = Container(
      child: Column(
        children: [
          const Text("Choose Fahrenheit or Celsius"),
          Row(
            children: [
              const Text('F'),
              Radio<bool>(
                groupValue: FtoC,
                value: false,
                onChanged: (v){
                  setState(() {
                    FtoC = !FtoC;
                  });
                },
              ),
              const Text('C'),
              Radio<bool>(
                groupValue: FtoC,
                value: true,
                onChanged: (v){
                  setState(() {
                    FtoC = !FtoC;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
    Container button = Container(
      child: ElevatedButton(
        child: const Text("Calculate"),
        onPressed: (){
          setState(() {
            FtoC == false
                ? result = (toconvert - 32 ) * ( 5/9 )
                : result = (toconvert * 9/5) + 32;
          });
          AlertDialog dialog = AlertDialog(
            content: FtoC == false
            ? Text("${toconvert.toStringAsFixed(3)} F : ${result.toStringAsFixed(3)} C")
            : Text("${toconvert.toStringAsFixed(3)} C : ${result.toStringAsFixed(3)} F"),
          );
          showDialog(context: context, builder: (BuildContext){
            return dialog;
          });
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convert App"),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        elevation: 20.0,
        shadowColor: Colors.orange,
        centerTitle: true,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40,),
            input,
            const SizedBox(height: 20,),
            tempSwitch,
            const SizedBox(height: 20,),
            button,
          ],
        ),
      ),
    );
  }
}
