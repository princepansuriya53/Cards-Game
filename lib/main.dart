// ignore_for_file: depend_on_referenced_packages, camel_case_types
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "Cards Game", home: homepage());
  }
}

class homepage extends StatefulWidget {
  final int size;
  const homepage({Key? key, this.size = 6}) : super(key: key);
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int level = 6;

  List<bool> cardFlips = [];

  List<String> data = [];

  List<GlobalKey<FlipCardState>> cardStatesKeys = [];

  int previusindex = -1;

  bool flip = false;

  @override
  void initState() {
    for (var i = 0; i < widget.size; i++) {
      cardStatesKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }

    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }

    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }

    super.initState();
    data.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Welcome To Card Memory Game',
            style: Theme.of(context).textTheme.titleMedium),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Cards Game',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.red),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return FlipCard(
                    key: cardStatesKeys[index],
                    flipOnTouch: cardFlips[index],
                    onFlip: () {
                      if (!flip) {
                        flip = true;
                        previusindex = index;
                      } else {
                        flip = false;
                        if (previusindex != index) {
                          if (data[previusindex] != data[index]) {
                            cardStatesKeys[previusindex]
                                .currentState
                                ?.toggleCard();
                            previusindex = index;
                          } else {
                            cardFlips[previusindex] = false;
                            cardFlips[index] = false;
                            if (cardFlips
                                .every((element) => element == false)) {
                              showresult();
                            }
                          }
                        }
                      }
                    },
                    front: Container(
                      margin: const EdgeInsets.all(4),
                      child: Image.asset('Assets/images/bWqus.jpg',
                          fit: BoxFit.cover, filterQuality: FilterQuality.high),
                    ),
                    back: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      margin: const EdgeInsets.all(4),
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text(data[index],
                              selectionColor: Colors.red,
                              style: Theme.of(context).textTheme.displayMedium),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showresult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Won!!', style: Theme.of(context).textTheme.displayMedium),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => homepage(size: level)),
                  (route) => false);
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
    level *= 2;
  }
}
