import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  List<String> cryptoListPrice = [
    '?',
    '?',
    '?',
  ];

  String selectedCurrency = currenciesList.first;
  String price = "?";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createCryptoListPrice();
  }

  void getBTC(coin) async{
      var btcData = await CoinData().getCoinData(coin,selectedCurrency);
      setState(() {
        price = btcData['rate'].toStringAsFixed(0);
      });
  }

  void createCryptoListPrice() async{
    for(int i = 0; i < cryptoList.length; i++){
      setCoinData(i);
    }
  }

  void setCoinData(index) async{
    var btcData = await CoinData().getCoinData(cryptoList[index],selectedCurrency);
    price = btcData['rate'].toStringAsFixed(0);
    setState(() {
      cryptoListPrice[index] = price;
    });
  }

  List<Padding> getCard(){
    List<Padding> items = [];
    for(int i = 0; i < cryptoList.length; i++){
      items.add(Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${cryptoList[i]} = ${cryptoListPrice[i]} ${selectedCurrency}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCard()
            ,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }



  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem> items =
    currenciesList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        createCryptoListPrice();
      },
      items: items,
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> items = currenciesList.map<Text>((String value) {
      return Text(value);
    }).toList();
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        createCryptoListPrice();
      },
      children: items,
    );
  }

}

