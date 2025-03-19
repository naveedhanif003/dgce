import 'First.dart';
import 'Second.dart';
import 'Third.dart';
import 'Fourth.dart';

/// first : {"title":"Register your DGCE Account Today","description":["Tap to create your free account in seconds.","Securely access digital gold trading on the go.","Join thousands already building their wealth."]}
/// second : {"title":"Buy Gold Instantly","description":["Purchase digital gold with just a few taps.","Real-time pricing and secure transactions, always.","Diversify your portfolio, right from your phone."]}
/// third : {"title":"Sell Gold with Ease","description":["Quickly liquidate your gold when you need to.","Get the best market rates, directly in the app.","Fast, secure payouts to your linked account."]}
/// fourth : {"title":"Daily Profit Potential","description":["Monitor market trends and seize opportunities.","Track your earnings with clear, intuitive charts.","Experience the convenience of growing your wealth daily."]}

class OnBoardingText {
  OnBoardingText({
      this.first, 
      this.second, 
      this.third, 
      this.fourth,});

  OnBoardingText.fromJson(dynamic json) {
    first = json['first'] != null ? First.fromJson(json['first']) : null;
    second = json['second'] != null ? Second.fromJson(json['second']) : null;
    third = json['third'] != null ? Third.fromJson(json['third']) : null;
    fourth = json['fourth'] != null ? Fourth.fromJson(json['fourth']) : null;
  }
  First? first;
  Second? second;
  Third? third;
  Fourth? fourth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (first != null) {
      map['first'] = first?.toJson();
    }
    if (second != null) {
      map['second'] = second?.toJson();
    }
    if (third != null) {
      map['third'] = third?.toJson();
    }
    if (fourth != null) {
      map['fourth'] = fourth?.toJson();
    }
    return map;
  }

}