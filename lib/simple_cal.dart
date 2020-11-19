import 'package:calculator/Scientific_cal.dart';
import 'package:calculator/main.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  @override
  CalView createState() => CalView();
}

class CalView extends State<CalculatorView>{

  var deci = new List(100);
  String output = "0";
  String temp1 = "0";
  String temp2 = "";
  String result = "";
  String inp = "";
  String operator1 = "";
  String operator2 = "";
  String history = "";
  int isDeci = 0;
  int notDeci;

  buttonPressed(String text) {

    if (text == 'AC') {
      temp1 = "0";
      temp2 = "";
      operator1 = "";
      history = "";
    } else if (text == 'C') {
      history = history.substring(0, history.length-1);

      if(temp2 == ""){
        if(operator1 == ""){
          temp1 = temp1.substring(0,temp1.length-1);
        }else{
          operator1 = operator1.substring(0,operator1.length-1);
        }
      } else{
        temp2 = temp2.substring(0,temp2.length-1);
      }
    } else if (text == '0' || text == '1' || text == '2' || text == '3' || text == '4' ||
        text == '5' ||
        text == '6' || text == '7' || text == '8' || text == '9' ||
        text == '.') {

      if(temp1 == "0" && operator1 != ""){
        temp2 = text;
      }else if (temp1 == "0") {
        temp1 = text;
      } else if (operator1 == "") {
        temp1 += text;
      } else
        temp2 += text;

    } else if (text == '+' || text == '-' || text == 'X' || text == '/' ||
        text == '%') {
      if (temp1 == "0") {
        history += temp1;
      }

      if (temp2 == "") {
        if (text == '+') {
          operator1 = "+";
        } else if (text == '-') {
          operator1 = "-";
        } else if (text == 'X') {
          operator1 = "*";
        } else if (text == '/') {
          operator1 = "/";
        } else if (text == '%') {
          operator1 = "%";
        }
      } else {
        if (text == '+') {
          operator2 = "+";
        } else if (text == '-') {
          operator2 = "-";
        } else if (text == 'X') {
          operator2 = "*";
        } else if (text == '/') {
          operator2 = "/";
        }
      }
    } else if (text == "=") {
      setState(() {
        if(temp1.contains(".")) {
          deci = temp1.split("");
          for (int i = deci.indexOf(".") + 1; i < deci.length; i++) {
            if (deci[i] != "0") {
              isDeci = 1;
              break;
            }
          }
        }

        if (isDeci == 0) {
          isDeci = temp1.indexOf(".");
          output = "= " + temp1.toString().substring(0,isDeci);
        } else {
          output = "= " + temp1;
        }

        isDeci = 0;
      });
    }

    if (operator1 == '%' && temp1 != "") {
      result = (double.parse(temp1) / 100).toString();
      temp1 = result;
      operator1 = "";
    } else if (temp1 != "" && operator1 != "" && temp2 != "") {
      if (operator1 == "+")
        result = (double.parse(temp1) + double.parse(temp2)).toString();
      else if (operator1 == "-")
        result = (double.parse(temp1) - double.parse(temp2)).toString();
      else if (operator1 == "*")
        result = (double.parse(temp1) * double.parse(temp2)).toStringAsFixed(2);
      else if (operator1 == "/")
        result = (double.parse(temp1) / double.parse(temp2)).toStringAsFixed(2);

      temp1 = result;
      temp2 = "";
      operator1 = "";
    }


    if (text != '=') {
      setState(() {
        if (text != "AC" && text != "C" && text != "SC" && text != "=") {
          history += text;
        }

        output = temp1;
      });
    }
  }

  Widget CalculatorButton(String buttonText, int size){

    return Expanded(
        child: MaterialButton(
          padding: EdgeInsets.all(10.0),
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'Karla',
              fontSize: size.toDouble(),
              color: Color.fromRGBO(179, 179, 179, 1),
            ),
          ),
          onPressed: () {
            buttonPressed(buttonText);
          },
        )
    );
  }


  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(81, 82, 81, 1),
          title: Text('Calculator', style: TextStyle(
            color: Color.fromRGBO(179, 179, 179, 1),
            fontFamily: 'Karla',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),),
        ),
        backgroundColor: Colors.black87,

        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(),
                Text(
                  history,
                  style: TextStyle(
                    fontFamily: 'Karla',
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                    color: Color.fromRGBO(99, 99, 99, 1),
                  ),
                ),
                Text(
                  output,
                  style: TextStyle(
                    fontFamily: 'Karla',
                    fontSize: 70,
                    fontWeight: FontWeight.w200,
                    color: Color.fromRGBO(179, 179, 179, 1),
                  ),
                ),
                SizedBox(height: 30),

                Container(
                  padding: EdgeInsets.only(right: 30.0),
                  height:1.0,
                  width:330.0,
                  color:Color.fromRGBO(89, 89, 89, 1),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('AC',30),
                      CalculatorButton('C',30),
                      CalculatorButton('%',30),
                      CalculatorButton('/',30),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('7',30),
                      CalculatorButton('8',30),
                      CalculatorButton('9',30),
                      CalculatorButton('X',30),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('4',30),
                      CalculatorButton('5',30),
                      CalculatorButton('6',30),
                      CalculatorButton('+',35),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('1',30),
                      CalculatorButton('2',30),
                      CalculatorButton('3',30),
                      CalculatorButton('-',40),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/scientificCal');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.autorenew,
                              color: Color.fromRGBO(179, 179, 179, 1),
                              size: 30,
                            )
                          ],
                        ),
                      ),
                      CalculatorButton('0',30),
                      CalculatorButton('.',30),
                      CalculatorButton('=',40),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

              ],
            ),
          ),

        )

    );
  }
}
