import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrato Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ContatoModel contato = ContatoModel();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adcionar Contato'),
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 10,
              children: <Widget>[
                TextFormField(
                  validator: nomeValidator(),
                  onChanged: updateNome,
                  decoration: InputDecoration(labelText: "Nome"),
                  maxLength: 100,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: updateTelefone,
                  decoration: InputDecoration(labelText: "Celular"),
                ),
                TextFormField(
                  validator: emailValidator(),
                  onChanged: updateEmail,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  onChanged: updateCPF,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "CPF"),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          print(contato);
                        }
                      },
                      child: Text('Salvar')),
                )
              ],
            ),
          ),
        ));
  }

  void updateNome(nome) => contato.nome = nome;
  void updateTelefone(telefone) => contato.telefone = telefone;
  void updateEmail(email) => contato.email = email;
  void updateCPF(cpf) => contato.cpf = cpf;

  TextFieldValidator emailValidator() {
    return EmailValidator(errorText: "e-mail invalido");
  }

  FieldValidator nomeValidator() {
    return MultiValidator([
      RequiredValidator(errorText: "Campo Obrigatorio"),
      MinLengthValidator(4, errorText: 'Tamanho minimo 4 caracteres')
    ]);
  }
}

class ContatoModel {
  late String nome;
  late String email;
  late String cpf;
  late String telefone;
  late ContatoType tipo;
}

enum ContatoType { CELULAR, TRABALHO, FAVORITO, CASA }
