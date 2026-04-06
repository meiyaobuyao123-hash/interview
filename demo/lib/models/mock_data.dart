class MockData {
  static const double totalBalance = 12580.50;
  static const double usdtBalance = 8200.00;
  static const double btcBalance = 2380.50;
  static const double ethBalance = 1200.00;
  static const double solBalance = 800.00;
  static const double cardBalance = 3500.00;
  static const double earnBalance = 4200.00;
  static const double todayPnl = 47.30;
  static const double earnApy = 6.8;

  static const List<Map<String, dynamic>> recentTransactions = [
    {'type': 'receive', 'title': '收到汇款', 'subtitle': '来自 张伟（中国）', 'amount': '+\$500.00', 'time': '今天 14:30', 'icon': 'arrow_downward'},
    {'type': 'card', 'title': 'U卡消费', 'subtitle': 'Grab Food · 曼谷', 'amount': '-\$12.50', 'time': '今天 12:15', 'icon': 'credit_card'},
    {'type': 'earn', 'title': '理财收益', 'subtitle': 'USDT活期 · APY 6.8%', 'amount': '+\$1.40', 'time': '今天 08:00', 'icon': 'trending_up'},
    {'type': 'send', 'title': '转账', 'subtitle': '转给 Maria · GCash', 'amount': '-\$200.00', 'time': '昨天 16:45', 'icon': 'arrow_upward'},
    {'type': 'merchant', 'title': '商户收款', 'subtitle': '客户 Chen · 午餐', 'amount': '+\$85.00', 'time': '昨天 13:20', 'icon': 'store'},
  ];

  static const List<Map<String, dynamic>> assets = [
    {'name': 'USDT', 'fullName': 'Tether', 'balance': '8,200.00', 'value': '\$8,200.00', 'change': '+0.01%', 'color': 0xFF26A17B},
    {'name': 'BTC', 'fullName': 'Bitcoin', 'balance': '0.0234', 'value': '\$2,380.50', 'change': '+2.3%', 'color': 0xFFF7931A},
    {'name': 'ETH', 'fullName': 'Ethereum', 'balance': '0.342', 'value': '\$1,200.00', 'change': '-1.2%', 'color': 0xFF627EEA},
    {'name': 'SOL', 'fullName': 'Solana', 'balance': '4.52', 'value': '\$800.00', 'change': '+5.1%', 'color': 0xFF9945FF},
  ];

  static const List<Map<String, dynamic>> earnProducts = [
    {'name': 'USDT 活期', 'apy': '6.8%', 'minAmount': '\$1', 'type': '稳定区', 'deposited': '\$3,000', 'earning': '\$1.40/天', 'color': 0xFF34C759},
    {'name': 'USDT 30天定期', 'apy': '8.5%', 'minAmount': '\$100', 'type': '稳定区', 'deposited': '\$0', 'earning': '-', 'color': 0xFF0A84FF},
    {'name': 'BTC 定投计划', 'apy': '浮动', 'minAmount': '\$10', 'type': '成长区', 'deposited': '\$500', 'earning': '+\$23.50', 'color': 0xFFF7931A},
    {'name': 'ETH 定投计划', 'apy': '浮动', 'minAmount': '\$10', 'type': '成长区', 'deposited': '\$200', 'earning': '-\$8.20', 'color': 0xFF627EEA},
    {'name': 'SOL 质押', 'apy': '7.2%', 'minAmount': '\$50', 'type': '成长区', 'deposited': '\$500', 'earning': '\$0.98/天', 'color': 0xFF9945FF},
  ];

  static const List<Map<String, dynamic>> merchantTransactions = [
    {'customer': '客户 Chen', 'type': '午餐', 'amount': '\$85.00', 'currency': 'USDT', 'time': '13:20'},
    {'customer': '客户 Wang', 'type': '晚餐', 'amount': '฿2,500', 'currency': 'THB', 'time': '19:45'},
    {'customer': '客户 Li', 'type': '外卖', 'amount': '\$42.00', 'currency': 'USDT', 'time': '12:10'},
    {'customer': '游客 Tanaka', 'type': '午餐', 'amount': '\$38.00', 'currency': 'USDT', 'time': '12:50'},
    {'customer': '微信收款', 'type': '午餐', 'amount': '¥380', 'currency': 'CNY', 'time': '13:05'},
  ];

  static const List<Map<String, dynamic>> employees = [
    {'name': 'Maria Santos', 'role': '服务员', 'salary': '₱8,500', 'status': '已发放'},
    {'name': 'Somchai K.', 'role': '厨师', 'salary': '฿12,000', 'status': '已发放'},
    {'name': 'Nguyen Thi', 'role': '清洁', 'salary': '₫5,000,000', 'status': '待发放'},
    {'name': 'Lin Wei', 'role': '收银', 'salary': '฿10,000', 'status': '待发放'},
  ];

  static const Map<String, dynamic> aiDailyReport = {
    'date': '2026年4月6日',
    'totalReceived': '\$3,200',
    'totalSpent': '\$1,100',
    'netInflow': '\$2,100',
    'fxRate': 'USDT/THB 35.82',
    'fxPercentile': 78,
    'suggestion': '当前USDT/THB处于30天82分位，偏贵，建议明天换汇。',
    'earningSuggestion': '您有\$8,500闲置USDT，放入活期理财月赚约\$42。',
  };

  static const List<Map<String, dynamic>> fxRates = [
    {'pair': 'USDT/THB', 'rate': '35.82', 'percentile': 78, 'trend': '+0.8%', 'suggestion': '偏贵，建议等1-2天'},
    {'pair': 'USDT/PHP', 'rate': '56.23', 'percentile': 45, 'trend': '-0.3%', 'suggestion': '适中，可以换'},
    {'pair': 'USDT/VND', 'rate': '25,380', 'percentile': 32, 'trend': '-1.2%', 'suggestion': '较优，建议现在换'},
    {'pair': 'USDT/CNY', 'rate': '7.24', 'percentile': 55, 'trend': '+0.1%', 'suggestion': '适中'},
    {'pair': 'USDT/MYR', 'rate': '4.42', 'percentile': 65, 'trend': '+0.5%', 'suggestion': '略高'},
  ];
}
