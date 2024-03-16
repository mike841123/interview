import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> suits = ['♠', '♣', '♥', '♦'];
const List<String> ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'];


class PokerPage extends StatefulWidget {
  const PokerPage({super.key});

  @override
  _PokerPageState createState() => _PokerPageState();
}

class _PokerPageState extends State<PokerPage> {
  List<List<String>> players = [[], [], [], []]; // 手牌

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("發牌"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  players = dealCards();
                });
              },
              child: const Text("發牌"),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < players.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Player ${i + 1}: ${players[i].join(", ")}'),
              ),
          ],
        ),
      ),
    );
  }

  /// 發牌
  List<List<String>> dealCards() {
    List<String> deck = []; // 牌
    for (String suit in suits) {
      for (String rank in ranks) {
        deck.add('$rank$suit'); // 將花色與數字加入
      }
    }
    deck.shuffle(); // 打亂陣列 模擬洗牌

    List<List<String>> players = [[], [], [], []];
    for (int i = 0; i < 13; i++) {
      for (int j = 0; j < 4; j++) {
        players[j].add(deck.removeLast()); // 從deck中移除最後一張牌並返回它的值 這樣就不會拿到重複的牌
      }
    }
    return players;
  }
}
