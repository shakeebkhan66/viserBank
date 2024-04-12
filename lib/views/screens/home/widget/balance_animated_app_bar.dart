import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceAnimationContainer extends StatefulWidget {
  const BalanceAnimationContainer({
    Key? key,
    required this.amount,
    required this.curSymbol,
  }) : super(key: key);

  final String amount;
  final String curSymbol;

  @override
  State<BalanceAnimationContainer> createState() =>
      _BalanceAnimationContainerState();
}

class _BalanceAnimationContainerState extends State<BalanceAnimationContainer> {
  bool _isBalanceShown = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleBalanceVisibility,
      child: Container(
        width: 200,
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.greenAccent.shade100,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Bank icon at the start
            const Positioned(
              left: 8,
              child: Icon(Icons.account_balance, color: Colors.black),
            ),
            // Balance text or hidden text
            Visibility(
              visible: _isBalanceShown,
              replacement: const Padding(
                padding: EdgeInsets.only(top: 7),
                child: Text(
                  '******',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              child: AnimatedOpacity(
                opacity: _isBalanceShown ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: FittedBox(
                  child: Text(
                    '${widget.curSymbol} ${widget.amount}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Eye icon to toggle visibility
            Positioned(
              right: 8,
              child: Icon(
                _isBalanceShown ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleBalanceVisibility() {
    setState(() {
      _isBalanceShown = !_isBalanceShown;
    });
  }
}
