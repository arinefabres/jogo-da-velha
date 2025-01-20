import 'package:flutter/material.dart';

void main() => runApp(JogoDaVelhaApp());

class JogoDaVelhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JogoDaVelha(),
    );
  }
}

class JogoDaVelha extends StatefulWidget {
  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> board = List.filled(9, "");
  String currentPlayer = "X";
  String winner = "";

  void resetGame() {
    setState(() {
      board = List.filled(9, "");
      currentPlayer = "X";
      winner = "";
    });
  }

  void makeMove(int index) {
    if (board[index] == "" && winner == "") {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner(currentPlayer)) {
          winner = "$currentPlayer venceu!";
        } else if (!board.contains("")) {
          winner = "Empate!";
        }
        currentPlayer = currentPlayer == "X" ? "O" : "X";
      });
    }
  }

  bool checkWinner(String player) {
    List<List<int>> winConditions = [
      [0, 1, 2], // Linha 1
      [3, 4, 5], // Linha 2
      [6, 7, 8], // Linha 3
      [0, 3, 6], // Coluna 1
      [1, 4, 7], // Coluna 2
      [2, 5, 8], // Coluna 3
      [0, 4, 8], // Diagonal principal
      [2, 4, 6], // Diagonal secundária
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] == player &&
          board[condition[1]] == player &&
          board[condition[2]] == player) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jogo da Velha")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => makeMove(index),
              child: Container(
                margin: EdgeInsets.all(4.0),
                color: Colors.blue[100],
                child: Center(
                  child: Text(
                    board[index],
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            itemCount: 9,
            shrinkWrap: true,
          ),
          SizedBox(height: 20),
          Text(
            winner.isNotEmpty ? winner : "Vez do jogador: $currentPlayer",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetGame,
            child: Text("Reiniciar"),
          ),
        ],
      ),
    );
  }
}
