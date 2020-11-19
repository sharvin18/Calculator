import 'dart:math';
import 'package:flutter/material.dart';

class Scientific_calculator extends StatefulWidget {
  @override
  _Scientific_calculatorState createState() => _Scientific_calculatorState();
}

class _Scientific_calculatorState extends State<Scientific_calculator> {

  var deci = new List(100);
  String output = "0";
  String temp1 = "";
  String temp2 = "";
  String result = "";
  String inp = "";
  String operator1 = "";
  String operator2 = "";
  String history = "";
  int isDeci = 0;
  int notDeci;

  int factorial(int val) {
    if(val == 0){
      return val+1;
    }else{
      return val * factorial(val-1);
    }
  }

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

    } else if (text == '0'||text == '1' || text == '2' || text == '3' || text == '4' || text == '5' ||
        text == '6' || text == '7' || text == '8' || text == '9' || text == '.' || text == '\u03C0' || text == 'e') {

      if (temp1 == "0") {

        if(text == '\u03C0')
          temp1 = "3.14159265";
        else if(text == 'e')
          temp1 = "2.71828183";
        else
          temp1 = text;

      } else if (operator1 == "") {

        if(text == '\u03C0')
          temp1 = "3.14159265";
        else if(text == 'e')
          temp1 = "2.71828183";
        else
          temp1 += text;

      } else {
        if(text == '\u03C0')
          temp2 = "3.14159265";
        else if(text == 'e')
          temp2 = "2.71828183";
        else
          temp2 += text;
      }

    } else if (text == '+' || text == '-' || text == 'X' || text == '/' ||
        text == '%' || text == 'x^y') {
      if (temp1 == "0") {
        history = temp1 + text;
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
        } else if (text == 'x^y') {
          operator1 = "^";
        }
      }

    } else if(text == "X!" || text == "1/X" || text == "\u221Ax" || text == "sin" || text == "lg"){
      if (text == 'X!') {
        temp1 = factorial(int.parse(temp1)).toString();
      } else if(text == "1/X"){
        temp1 = (1/double.parse(temp1)).toStringAsFixed(2);
      } else if(text == "\u221Ax"){
        temp1 = (sqrt(double.parse(temp1))).toStringAsFixed(2);
      } else if(text == "sin"){
        temp1 = (sqrt(double.parse(temp1))).toStringAsFixed(2);
      }


    }else if (text == "=") {
      setState(() {
        if(temp1.contains(".")) {
          deci = temp1.split("");
          for (int i = deci.indexOf(".") + 1; i < deci.length; i++) {
            if (deci[i] != "0") {
              isDeci = 1;
              break;
            }
          }
        }else{
          isDeci = 1;
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
        result = (double.parse(temp1) + double.parse(temp2)).toStringAsFixed(2);
      else if (operator1 == "-")
        result = (double.parse(temp1) - double.parse(temp2)).toStringAsFixed(2);
      else if (operator1 == "*")
        result = (double.parse(temp1) * double.parse(temp2)).toStringAsFixed(2);
      else if (operator1 == "/")
        result = (double.parse(temp1) / double.parse(temp2)).toStringAsFixed(2);
      else if (operator1 == "^")
        result = (pow(double.parse(temp1), double.parse(temp2))).toStringAsFixed(2);

      temp1 = result;
      temp2 = "";
      operator1 = "";
    }


    if (text != '=') {
      setState(() {

        if(text == "X!"){
          history += "!";
        }else if(text == "1/X"){
          history += "^(-1)";
        }else if(text == "\u221Ax"){
          history += "\u221A";
        }else if(text == "x^y"){
          history += "^";
        }else if(text == "e"){
          history += "2.71828183";
        }else if(text == "\u03C0"){
          history += "3.14159265";
        }else if (text != "AC" && text != "C" && text != "SC" && text != "=") {
          history += text;
        }


        if(temp1 == "3.14159265")
          output = "\u03C0";
        else if(temp1 == "2.71828183")
          output = "e";
        else
          output = temp1;
      });
    }
  }

  Widget CalculatorButton(String buttonText, int size){

    return Expanded(
        child: MaterialButton(
          padding: EdgeInsets.all(5.0),
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
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('x^y',20),
                      CalculatorButton('sin',20),
                      CalculatorButton('lg',20),
                      CalculatorButton('(',20),
                      CalculatorButton(')',20),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('\u221Ax',20),
                      CalculatorButton('AC',20),
                      CalculatorButton('C',20),
                      CalculatorButton('%',20),
                      CalculatorButton('/',20),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('X!',20),
                      CalculatorButton('7',30),
                      CalculatorButton('8',30),
                      CalculatorButton('9',30),
                      CalculatorButton('X',20),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('1/X',20),
                      CalculatorButton('4',30),
                      CalculatorButton('5',30),
                      CalculatorButton('6',30),
                      CalculatorButton('+',25),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalculatorButton('\u03C0',20),
                      CalculatorButton('1',30),
                      CalculatorButton('2',30),
                      CalculatorButton('3',30),
                      CalculatorButton('-',40),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
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
                      CalculatorButton('e',30),
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
