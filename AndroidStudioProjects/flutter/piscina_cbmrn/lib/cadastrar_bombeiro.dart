import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';


class CadastrarBombeiro extends StatefulWidget {
  @override
  _CadastrarBombeiroState createState() => _CadastrarBombeiroState();
}

class _CadastrarBombeiroState extends State<CadastrarBombeiro> {
  TextEditingController nome = TextEditingController();
  TextEditingController matricula = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController value = TextEditingController();

  final keyForm = GlobalKey<FormState>();

  // 1° passo: criar as variaveis
  final imagePicker = ImagePicker();
  File _image;

  Future register() async {
    var url = "http://jcatechnology.com.br/piscina/outros.php";
    //var url = "http://192.168.1.141/piscina/bombeiro.php";

    // 8° passo: Converter a imagem para base64
    String baseImage = base64.encode(_image.readAsBytesSync());

    var response = await http.post(url, body: {
      "nome": nome.text,
      "matricula": matricula.text,
      "email": email.text,
      "senha": senha.text,
      "value": value.text,
      "level": "member",
      "tipo": "bombeiro",
      "image": baseImage
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
        msg: "Usuário já existe",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        fontSize: 20.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Cadastro realizado com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        fontSize: 20.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'CBMRN',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: keyForm,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Cadastrar Bombeiro',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      //hintText: 'Nome',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: nome,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Matrícula',
                      hintText: 'xxx.xxx-x',
                      prefixIcon: Icon(Icons.perm_identity),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: matricula,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '###.###-##',
                      )
                    ],
                    validator: (value) {
                      if (value.length != 10) {
                        return 'tamanho invalido';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      //hintText: 'xxx.xxx-x',
                      prefixIcon: Icon(Icons.perm_identity),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: senha,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: timeDilation != 1.0,
                        onChanged: (bool value) {
                          setState(() {
                            timeDilation = value ? 2.0 : 1.0;
                          });
                        }),
                    Text("Li e aceito os "),
                    InkWell(
                        child: Text(
                          "termos de uso!",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blueAccent),
                        ),
                        onTap: () =>
                            launch('http://imagescloud.com.br/pp.pdf')),
                  ],
                ),
                // 7° passo: mostrar a imagem selecionada
                _image != null ? Image.file(_image) : Container(),
                // 2° passo: adicionar o botão para chamar a galeria
                RaisedButton(
                  child: Text('escolher imagem'),
                  onPressed: () async {
                    // 3° passo: chamar a galeria do celular
                    // 4° passo: salvar a imagem escolhida
                    final imagemEscolhida = await imagePicker.getImage(
                      source: ImageSource.gallery,
                    );

                    // 5° passo: validar se alguma imagem foi escolhida
                    // e atualizar a variavel que guarda o arquivo
                    if (imagemEscolhida != null) {
                      setState(() {
                        // 6° passo: Criar o arquivo da imageme scolhida
                        _image = File(imagemEscolhida.path);
                      });
                    }
                  },
                ),
                MaterialButton(
                  color: Colors.blue,
                  child: Text('Cadastrar',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    if (keyForm.currentState.validate()) {
                      if (timeDilation == 1.0) {
                        register();
                      }
                      // avisa que é obrigatório o termo
                    }
                  },
                ),
              ],
            ),
          ),
          //  ),
          //),
        ));
  }

  validar(value) {
    if (value.isEmpty) return 'campo obrigatorio';
  }
}
