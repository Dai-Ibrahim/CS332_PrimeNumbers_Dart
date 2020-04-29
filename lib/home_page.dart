import 'package:flutter/material.dart';
class MyTextInput extends StatefulWidget {
  @override
  State createState() => new MyTextInputState();
}
class MyTextInputState extends State<MyTextInput> {
  var num1 = 0, num2 = 0, sum = 0, elapsed ;
  String str;
  final TextEditingController t1 = new TextEditingController(text: "0");
  final TextEditingController t2 = new TextEditingController(text: "0");
  Iterable<int> primesMap() {
    Iterable<int> oddprms() sync* {
      yield(3); yield(5); // need at least 2 for initialization
      final Map<int, int> bpmap = {9: 6};
      final Iterator<int> bps = oddprms().iterator;
      bps.moveNext(); bps.moveNext(); // skip past 3 to 5
      int bp = bps.current;
      int n = bp;
      int q = bp * bp;
      while (true) {
        n += 2;
        while (n >= q || bpmap.containsKey(n)) {
          if (n >= q) {
            final int inc = bp << 1;
            bpmap[bp * bp + inc] = inc;
            bps.moveNext(); bp = bps.current; q = bp * bp;
          } else {
            final int inc = bpmap.remove(n);
            int next = n + inc;
            while (bpmap.containsKey(next)) {
              next += inc;
            }
            bpmap[next] = inc;
          }
          n += 2;
        }
        yield(n);
      }
    }
    return [2].followedBy(oddprms());
  }

  void getPrimes() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      //sum = num1 + num2;

      str = " ";
      primesMap().skipWhile((p)=>p<num1).takeWhile((p)=>p<num2)
          .forEach((p)=>str += "$p ");
      //print(str + " ");
      final start = DateTime.now().millisecondsSinceEpoch;
      final answer = primesMap().takeWhile((p)=>p<2000000).reduce((a,p)=>a+p);
      elapsed = DateTime.now().millisecondsSinceEpoch - start;
      print("tiem:");
      print( elapsed);
    });


  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Primes"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(40.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              " time elapsed: $elapsed",
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
            new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: "lower limit"),
              controller: t1,
            ),
            new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(hintText: "upper limit"),
              controller: t2,
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new MaterialButton(
                  child: new Text("prime!"),
                  color: Colors.greenAccent,
                  onPressed: getPrimes,
                ),
              ],
            ),

            new Text(
              "$str",
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}




