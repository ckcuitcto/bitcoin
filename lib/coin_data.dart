import 'package:bitcoin_ticker/services/networking.dart';

const List<String> currenciesList = [
  'VND',
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];


const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '6D20914F-6C94-49A7-93D0-8597831463C8';

class CoinData {

  Future<dynamic> getCoinData(coin, usd) async {
      String url = '${coinAPIURL}/${coin}/${usd}';
      NetworkHelper networkHelper = NetworkHelper(url);
      var coinData = await networkHelper.getData();
      return coinData;
  }
}
