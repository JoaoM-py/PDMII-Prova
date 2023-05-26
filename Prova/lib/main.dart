import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// classe que inicia o aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // define Material Design
    return MaterialApp(
      title: 'Sample Input',
      home: Forms(), // inicia página principal
    );
  }
}

// Classe que instância classe responsável por gerenciar estados
class Forms extends StatefulWidget {
  @override
  FormsState createState() => FormsState();
}

// classe que contém os widgets
class FormsState extends State<Forms> {
  // é necessário um controller para interagir com
  // wigdget de entrada de dados
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

  bool _IsValid = false;
  bool _IsVerificated = false;

  Color textColor = Colors.black; // default color
  Color textColorWarning = Colors.grey; // default color
  Color borderColor = Colors.grey;

  String _result = "";
  bool envio = false;

  // cancelar
  void _cancelar() {
    _email.text = "";
    String email = _email.text;
    // define resposta
    setState(() {
      _result = email;
    });

    _senha.text = "";
    String senha = _senha.text;
    // define resposta
    setState(() {
      _result = senha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // barra do aplicativo
        title: const Text('Shoe Store'),
      ),
      body: Align(
        // corpo do aplicativo
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const SizedBox(
                height: 16.0), // um retângulo contendo widget de entrada
            SizedBox(
                // label para primeiro número
                width: 300,
                child: TextField(
                  controller: _email, // associa controle ao widget
                  keyboardType: TextInputType.text, // tipo de entrada
                  decoration: InputDecoration(
                    // customização
                    hintText: 'Entre com user', //hint
                    prefixIcon:
                        const Icon(Icons.account_circle_outlined), //icon
                    enabledBorder: OutlineInputBorder(
                      //borda ao redor da entrada
                      borderSide: BorderSide(color: borderColor), //cor da borda
                    ), //quando receber o foco, altera cor da borda
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  onChanged: (_) => setState(() {
                    _IsValid = _email.text.isNotEmpty &&
                        _senha.text.isNotEmpty &&
                        _email.text == 'teste' &&
                        _senha.text == '123';
                  }),
                )),
            const SizedBox(height: 16.0),

            SizedBox(
                // label para primeiro número
                width: 300,
                child: TextField(
                  controller: _senha, // associa controle ao widget
                  keyboardType: TextInputType.text, // tipo de entrada
                  decoration: InputDecoration(
                    // customização
                    hintText: 'Entre com senha', //hint
                    prefixIcon:
                        const Icon(Icons.account_circle_outlined), //icon
                    enabledBorder: OutlineInputBorder(
                      //borda ao redor da entrada
                      borderSide: BorderSide(color: borderColor), //cor da borda
                    ), //quando receber o foco, altera cor da borda
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),

                  onChanged: (_) => setState(() {
                    _IsValid = _email.text.isNotEmpty &&
                        _senha.text.isNotEmpty &&
                        _email.text == 'teste' &&
                        _senha.text == '123';
                  }),
                )),
            const SizedBox(height: 16.0),
            // if ternário que controla exibição da resposta.
            // senão foi enviado, então apresenta botões
            // enviar e cancelar
            !envio
                ? SizedBox(
                    // botões
                    width: 300,
                    // Row determina que os widgets serão acrescentados
                    // lado a lado
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _IsValid
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecondPage()),
                                  );
                                }
                              : null,
                          child: const Text('Enviar'),
                        ),
                        ElevatedButton(
                          onPressed: _cancelar, // executa _cancelar
                          child: const Text('Cancelar'),
                        ),
                      ],
                    ))
                : const SizedBox.shrink(), // espaço vazio
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  List<String> _selectItens = [];

  Map<String, bool> first = {
    'Flutter': false,
    'React Native': false,
    'Ionic': false,
    'Kotlin': false,
    'Java': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox Sample'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Quais tecnologias mobile você conhece?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              )),
          Column(
            children: _buildCheckboxes(),
          ),
        ]),
      ),
    );
  }

  List<Widget> _buildCheckboxes() {
    List<Widget> firstCheckboxes = [];
    // percorre todos os itens armazendos na estrutura
    // Map (chave, valor), obtendo os valores
    first.forEach((String key, bool value) {
      firstCheckboxes.add(
        // adiciona um item ao checkbox
        CheckboxListTile(
          title: Text(key), //adiciona título
          value: value, // define valor
          // implementa evento onChage para gerenciar
          // valor do checkbox
          onChanged: (newValue) {
            //recebe valor atual
            setState(() {
              //altera o estado da variável
              newValue != null
                  ? //se diferente de null
                  //alterna valor entre verdadeiro e falso
                  first[key] == true
                      ? first[key] = false
                      : first[key] = true
                  : first[key] = false;
            });
          },
        ),
      );
    });

    // adiciona ao final do checkBox, botão
    firstCheckboxes.add(
      ElevatedButton(
        // se pressionado executar método
        onPressed: () {
          _showFirstSelected();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmPage(itensSelected: _selectItens)),
          ); // mostra selecionados
        },
        child: const Text('Enviar'),
      ),
    );
    return firstCheckboxes;
  }

  void _showFirstSelected() {
    // mostra itens selecionados
    List<String> selected = []; // lista de strings
    _selectItens = selected;
    // percorre coleção que contém o itens selecionados
    first.forEach((String key, bool value) {
      if (value) {
        // se valor válido
        selected.add(key); // adiciona na lista de strings
      }
    });
  }
}

class ConfirmPage extends StatelessWidget {
  final List<String> itensSelected;

  const ConfirmPage({Key? key, required this.itensSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação do pedido'),
      ),
      body: Align(
          alignment: Alignment.center,
          child: Container(
            width: 600,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                // display parametres received
                Text(itensSelected.toString(),
                    style:
                        const TextStyle(fontSize: 24.0, color: Colors.green)),
              ],
            ),
          )),
    );
  }
}
