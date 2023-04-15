library analytics;

import 'dart:math';

class Analytics {
  List<List<dynamic>> csvDataList;

  Analytics(this.csvDataList);

  Future<List<Map<String, dynamic>>> getStockList() async {
    final tickerList = csvDataList[0].sublist(2);
    final quoteList = csvDataList.sublist(1);
    List<Map<String, dynamic>> stockList = [];
    for (String ticker in tickerList) {
      Map<String, dynamic> stock = {};
      stock['ticker'] = ticker.substring(4);
      Map<String, double> quotesHistory = {};
      for (List<dynamic> quote in quoteList) {
        final date = quote[1].toString();
        final dateParsed =
            '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}';
        quotesHistory[dateParsed] = quote[tickerList.indexOf(ticker) + 2];
      }
      stock['quotesHistory'] = quotesHistory;
      stockList.add(stock);
    }
    return stockList;
  }

  Future<Map<String, dynamic>> getStock(String ticker) async {
    Map<String, dynamic> stock = {};
    final tickerList = csvDataList[0].sublist(2);
    final quoteList = csvDataList.sublist(1);
    Map<String, double> quotesHistory = {};
    for (List<dynamic> quote in quoteList) {
      final date = quote[1].toString();
      final dateParsed =
          '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}';
      quotesHistory[dateParsed] = quote[tickerList.indexOf('US1.$ticker') + 2];
    }
    stock['ticker'] = ticker;
    stock['quotesHistory'] = quotesHistory;
    return stock;
  }

  List<double> getRisk(List<Map<String, dynamic>> stocks) {
    List<List<double>> mat = [];
    for (Map<String, dynamic> stock in stocks) {
      final Map<String, double> quotesHistory = stock['quotesHistory'];
      final quotes = quotesHistory.values.toList();
      mat.add(quotes);
    }
    mat = _transformLogReturn(_transpose(mat));

    List<double> weight = [];
    int n = mat[0].length;
    for (int i = 0; i < n; i++) {
      weight.add(1 / n);
    }
    List<double> res = List.filled(n + 1, 0);
    List<double> mu = List.filled(n, 0);
    double quantile = -1.6448536269514729;

    for (int i = 0; i < n; i++) {
      mu[i] = _mean(_getColumn(mat, i));
      res[i + 1] =
          -mu[i] - sqrt(_variance(_getColumn(mat, i), mu[i])) * quantile;
    }

    List<List<double>> covMat = _covMatrix(mat, mu);
    double weightXmu = 0;
    double m2 = 0;

    for (int i = 0; i < n; i++) {
      double corrMatXweight = 0;
      weightXmu += weight[i] * mu[i];
      for (int j = 0; j < n; j++) {
        corrMatXweight += covMat[i][j] * weight[j];
      }
      m2 += weight[i] * corrMatXweight;
    }

    res[0] = -weightXmu - sqrt(m2) * quantile;
    return res;
  }

  List<double> cutRiskAssets(List<double> weight, List<double> riskData,
      double minRisk, double maxRisk) {
    final n = weight.length;
    List<double> newWeight = List.filled(n, 0);
    double deletedWeights = 0;
    double weightNorm = 0;
    int lowRiskCnt = 0;

    for (int i = 0; i < n; i++) {
      if (riskData[i + 1] < maxRisk) {
        newWeight[i] = weight[i];
        weightNorm += newWeight[i];
        if (riskData[i + 1] < minRisk) {
          lowRiskCnt += 1;
        }
      } else {
        deletedWeights += weight[i];
      }
    }

    if (lowRiskCnt > 0) {
      for (int i = 0; i < n; i++) {
        if (riskData[i + 1] < minRisk) {
          newWeight[i] += deletedWeights / lowRiskCnt;
        }
      }
    } else {
      if (weightNorm > 0) {
        for (int i = 0; i < n; i++) {
          newWeight[i] = newWeight[i] / weightNorm;
        }
      } else {
        newWeight = List.filled(n, 0);
      }
    }

    return newWeight;
  }
}

extension AnalyticsMathExtension on Analytics {
  List<List<double>> _transpose(List<List<double>> data) {
    int rows = data.length;
    int cols = data[0].length;
    List<List<double>> res = List.generate(cols, (i) => List.filled(rows, 0));
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        res[j][i] = data[i][j];
      }
    }
    return res;
  }

  List<List<double>> _transformLogReturn(List<List<double>> data) {
    int n = data[0].length;
    int countRows = data.length;
    List<List<double>> res = List.generate(n, (i) => List.filled(countRows, 0));
    for (int k = 0; k < n; k++) {
      List<double> z1 = _getColumn(data, k);
      List<double> z2 = z1.sublist(0, countRows - 1);
      z2.insert(0, z1[0]);
      List<double> ret = [];
      for (int i = 0; i < countRows; i++) {
        ret.add(log(z1[i] / z2[i]));
      }
      res[k] = ret;
    }
    return _transpose(res);
  }

  double _mean(List<double> arr) {
    int n = arr.length;
    double res = 0;
    for (int i = 0; i < n; i++) {
      res += arr[i];
    }
    return res / n;
  }

  double _variance(List<double> arr, double avg) {
    int n = arr.length;
    double res = 0;
    for (int i = 0; i < n; i++) {
      res += pow((arr[i] - avg), 2);
    }
    return res / (n - 1);
  }

  double _covariance(
      List<double> arr1, List<double> arr2, double avg1, double avg2) {
    int n = arr1.length;
    double cov = 0;
    for (int i = 0; i < n; i++) {
      cov += (arr1[i] - avg1) * (arr2[i] - avg2);
    }
    return cov / (n - 1);
  }

  List<double> _getColumn(List<List<double>> matrix, int index) {
    List<double> column = [];
    for (int i = 0; i < matrix.length; i++) {
      column.add(matrix[i][index]);
    }
    return column;
  }

  List<List<double>> _covMatrix(List<List<double>> mat, List<double> mu) {
    int n = mat[0].length;
    List<List<double>> res = List.generate(n, (_) => List.filled(n, 0));
    for (int i = 0; i < n; i++) {
      for (int j = i; j < n; j++) {
        res[i][j] =
            _covariance(_getColumn(mat, i), _getColumn(mat, j), mu[i], mu[j]);
      }
    }
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < i; j++) {
        res[i][j] = res[j][i];
      }
    }
    return res;
  }
}
