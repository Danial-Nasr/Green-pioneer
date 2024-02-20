import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'containerbutton.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int _type = 1;
  void _handleRadio(Object? e) => setState(() {
    _type = e as int;
  });

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Method"),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF246549),
        elevation: 0,
        leading: const BackButton(color: Colors.black26),
        actions: [
          PopupMenuButton(
            color: Colors.black26,
              itemBuilder: (context) => [
                const PopupMenuItem(child: null,)
          ])
        ] ,
      ),
      body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                "Choosing Payment",
                  textAlign: TextAlign.left,
                  style:  TextStyle(
                     color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )
              ),
              const SizedBox(height: 20),
              Container(
                  width: size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent, width: 20),
                  )
              ),
              const SizedBox(height: 20),
              const Text(
                "Add Payment Method",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF246549),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: size.width,
                height: 60,
                decoration: BoxDecoration(
                  border: _type == 1
                      ? Border.all(width: 1, color: Colors.black)
                      : Border.all(width: 0.3, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black12

                ),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/visa.png',
                    
                      height: 50,
                    ),
                    Text(
                        "**** **** **** 1234",
                        style: _type == 1
                            ? const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF246549))
                            : const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)
                    ),
                    Radio(
                        value: 1,
                        groupValue: _type,
                        onChanged: _handleRadio,
                        activeColor: const Color(0xFF246549),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: size.width,
                height: 60,
                decoration: BoxDecoration(
                    border: _type == 2
                        ? Border.all(width: 1, color: Colors.black)
                        : Border.all(width: 0.3, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black12

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/paypal.png',

                      height: 50,
                    ),
                    Text(
                        "alpa321@testmail.com",
                        style: _type == 2
                            ? const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF246549))
                            : const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)
                    ),
                    Radio(
                      value: 2,
                      groupValue: _type,
                      onChanged: _handleRadio,
                      activeColor: const Color(0xFF246549),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: size.width,
                height: 60,
                decoration: BoxDecoration(
                    border: _type == 3
                        ? Border.all(width: 1, color: Colors.black)
                        : Border.all(width: 0.3, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black12

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/ecash.png',

                      height: 50,
                    ),
                    Text(
                        "**** **** **** 1234",
                        style: _type == 3
                            ? const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF246549))
                            : const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)
                    ),
                    Radio(
                      value: 3,
                      groupValue: _type,
                      onChanged: _handleRadio,
                      activeColor: const Color(0xFF246549),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Total: ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    "\$22.00",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "See Details >",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
                ),
              ),
            ],
          ),
              const SizedBox(height: 60),
          InkWell(
            onTap: (){},
            child: ContainerButtonModel(
              itext: "Payment",
              containerWidth: size.width,
              bgColor: const Color(0xFF246549),
            ),
          )
         ]
        ),
    ),
    ));
  }
}
