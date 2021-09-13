import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String paymentValue = "card";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22.0)),
          ),
          padding: EdgeInsets.symmetric(
            vertical: getProportionteScreenHeight(8.0),
            horizontal: getProportionScreenWidth(16.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Radio(
                    activeColor: kPrimaryColor,
                    value: "card",
                    groupValue: paymentValue,
                    onChanged: (String? e) {
                      setState(() {
                        paymentValue = e!;
                      });
                    },
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionScreenWidth(4.0)),
                          leading: Container(
                            alignment: Alignment.center,
                            height: getProportionteScreenHeight(42.0),
                            width: getProportionScreenWidth(42.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Color(0xFFF47B0A),
                            ),
                            child: Image.asset(
                              "assets/icons/bi_credit-card-2-front-fill.png",
                              height: getProportionteScreenHeight(20.0),
                              width: getProportionScreenWidth(20.0),
                            ),
                          ),
                          title: Text("Card"),
                        ),
                        Divider(color: Colors.black.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: getProportionScreenWidth(16.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Radio(
                    activeColor: kPrimaryColor,
                    value: "Mobile",
                    groupValue: paymentValue,
                    onChanged: (String? e) {
                      setState(() {
                        paymentValue = e!;
                      });
                    },
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionScreenWidth(4.0)),
                          leading: Container(
                            alignment: Alignment.center,
                            height: getProportionteScreenHeight(42.0),
                            width: getProportionScreenWidth(42.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Color(0xFFEB4796),
                            ),
                            child: Image.asset(
                              "assets/icons/dashicons_bank.png",
                              height: getProportionteScreenHeight(20.0),
                              width: getProportionScreenWidth(20.0),
                            ),
                          ),
                          title: Text("Mobile Money (MTN,VODA)"),
                        ),
                        Divider(color: Colors.black.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(22.0)),
          ),
          padding: EdgeInsets.only(
            bottom: getProportionteScreenHeight(20.0),
            left: getProportionScreenWidth(16.0),
            right: getProportionScreenWidth(16.0)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Radio(
                    activeColor: kPrimaryColor,
                    value: "Pay",
                    groupValue: paymentValue,
                    onChanged: (String? e) {
                      setState(() {
                        paymentValue = e!;
                      });
                    },
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionScreenWidth(4.0)),
                      leading: Container(
                        alignment: Alignment.center,
                        height: getProportionteScreenHeight(42.0),
                        width: getProportionScreenWidth(42.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Color(0xFF0038FF),
                        ),
                        child: Image.asset(
                          "assets/icons/cib_paypal.png",
                          height: getProportionteScreenHeight(20.0),
                          width: getProportionScreenWidth(20.0),
                        ),
                      ),
                      title: Text("Pay on Delivery"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
