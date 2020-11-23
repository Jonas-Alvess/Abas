import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';
import 'login_outros.dart';

class CadastrarOutros extends StatefulWidget {
  @override
  _CadastrarOutrosState createState() => _CadastrarOutrosState();
}

class _CadastrarOutrosState extends State<CadastrarOutros> {
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController rg = TextEditingController();
  TextEditingController telefone = TextEditingController();
  TextEditingController endereco = TextEditingController();
  TextEditingController profissao = TextEditingController();
  TextEditingController nascimento = TextEditingController();
  TextEditingController senha = TextEditingController();

  File _image;
  final picker = ImagePicker();
  String caminhoDaFoto = '';

  Future register() async {
    var url = "http://jcatechnology.com.br/piscina/outros.php";
    //var url = "http://192.168.1.141/piscina/outros.php";

    String baseImage = base64.encode(_image.readAsBytesSync());
    print(baseImage);

    var response = await http.post(url, body: {
      "nome": nome.text,
      "email": email.text,
      "rg": rg.text,
      "telefone": telefone.text,
      "endereco": endereco.text,
      "profissao": profissao.text,
      "nascimento": nascimento.text,
      "senha": senha.text,
      "level": "member",
      "tipo": "outros",
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
      //backgroundColor: Colors.red[800],
        appBar: AppBar(
          title: Text(
            'CBMRN',
            style:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[100]),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Card(
              //color: Colors.red[800],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Cadastrar Usuário',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      controller: nome,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      controller: email,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'RG',
                        prefixIcon: Icon(Icons.perm_identity),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      controller: rg,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      controller: telefone,
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: '(##)#####-####',
                        )
                      ],
                     /* validator: (value) {
                        if (value.length != 13) {
                          return 'Telefone invalido';
                        }
                      },*/
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Endereço',
                        prefixIcon: Icon(Icons.home),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      controller: endereco,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Profissão',
                        prefixIcon: Icon(Icons.work),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      controller: profissao,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Data de Nascimento',
                        hintText: 'dd/MM/yyyy',
                        prefixIcon: Icon(Icons.date_range),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp(r'\d+|-|/')),
                        DateInputFormatter(),
                      ],
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      controller: nascimento,
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
                  _image != null ? Image.file(_image) : Container(),
                  RaisedButton(
                      child: Text('escolher imagem'),
                      onPressed: () async {

                        final arquivoEscolhido = await picker.getImage(
                          source: ImageSource.gallery,
                        );

                        if (arquivoEscolhido != null) {
                          setState(() {
                            // gera um File com o caminho da imagem selecionada
                            _image = File(arquivoEscolhido.path);
                          });
                        }
                        print(_image);
                      }),
                  MaterialButton(
                    color: Colors.blue,
                    child: Text('Cadastrar',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    onPressed: () {
                      register();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  validar(value) {
    if (value.isEmpty) return 'campo obrigatorio';
  }
}