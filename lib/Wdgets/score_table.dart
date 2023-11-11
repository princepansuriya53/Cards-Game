import 'package:flutter/material.dart';

Widget scoreBord(
  String tittle,
  String info,
) {
  return Expanded(
    child: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          children: [
            Text(
              tittle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(info,
                style:
                    const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
          ],
        )),
  );
}
