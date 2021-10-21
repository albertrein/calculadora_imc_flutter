import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class Pessoa{
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  int? _genero = 0;
  double peso = 0.0;
  double altura = 0.0;
  int genero = 0;
  double imc = 0.0;

  String _calculoFeminino(String mensagem){
    if (imc < 19.1)
      mensagem += "Abaixo do peso";
    else if (imc < 25.8)
      mensagem += "Peso ideal";
    else if (imc < 27.3)
      mensagem += "Levemente acima do peso";
    else if (imc < 35.0)
      mensagem += "Obesidade Grau I";
    else if (imc < 40.0)
      mensagem += "Obesidade Grau II";
    else
      mensagem += "Obesidade Grau IIII";

    return mensagem;
  }
  String _calculoMasculino(String mensagem){
    if (imc < 18.6)
      mensagem += "Abaixo do peso";
    else if (imc < 25.0)
      mensagem += "Peso ideal";
    else if (imc < 30.0)
      mensagem += "Levemente acima do peso";
    else if (imc < 35.0)
      mensagem += "Obesidade Grau I";
    else if (imc < 40.0)
      mensagem += "Obesidade Grau II";
    else
      mensagem += "Obesidade Grau IIII";

    return mensagem;
  }

  String calcularIMC(){
    peso = double.parse(pesoController.text);
    altura = (double.parse(alturaController.text))/100;
    imc = peso/(altura*altura);
    String mensagem = "IMC ${imc.toStringAsPrecision(2)}\n";
    if(genero == 0){
      return _calculoMasculino(mensagem);
    }
    return _calculoFeminino(mensagem);
  }    
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _mensagem= "Por favor informe seus dados";
  Pessoa pessoa = Pessoa();
  double imc = 0.0;
  final double peso = 0.0;
  final double altura = 0.0;
  

  void _reset(){
    pessoa.pesoController.text="";
    pessoa.alturaController.text="";
    setState(() {
      _mensagem="Por favor informe seus dados";
      _formKey= GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState(() {
        _mensagem = pessoa.calcularIMC();        
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC!"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions:[
          IconButton(onPressed: _reset, icon:Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 100, color: Colors.blue,),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso em quilos",
                        labelStyle: TextStyle(color: Colors.lightBlueAccent)),
                    textAlign: TextAlign.center,
                    style: TextStyle (color: Colors.blue, fontSize: 24),
                    controller: pessoa.pesoController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Informe o seu peso!";
                      }
                    }
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Sua altura em CM",
                        labelStyle: TextStyle(color: Colors.lightBlueAccent)),
                    textAlign: TextAlign.center,
                    style: TextStyle (color: Colors.blue, fontSize: 24),
                    controller: pessoa.alturaController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Informe sua altura!";
                      }
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Row(
                    children:[
                      Text('Maculino'),
                      Radio(
                        value: 0,
                        groupValue: pessoa._genero,
                        onChanged: (int ? value){
                          setState(() {
                            pessoa._genero = value;                            
                          });
                        },
                      ),
                      Text('Feminino'),
                      Radio(
                        value: 1,
                        groupValue: pessoa._genero,
                        onChanged: (int ? value){
                          setState(() {
                            pessoa._genero = value;                            
                          });
                        },
                      ),
                    ]
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 40,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){                          
                          _calcular();
                        }
                      },
                      child: Text("Calcular"),
                    ),
                  ),
                ),
                Text(_mensagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                )
              ],
            )
        ),
      ),
    );
  }

}
