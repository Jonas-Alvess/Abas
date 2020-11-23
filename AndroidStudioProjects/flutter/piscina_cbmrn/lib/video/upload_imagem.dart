import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../Resenha.dart';


class UploadImagem extends StatefulWidget {
  @override
  _UploadImagemState createState() => _UploadImagemState();
}

class _UploadImagemState extends State<UploadImagem> {
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
    var url = "http://jcatechnology.com.br/piscina/upload.php";
    //var url = "http://192.168.1.141/piscina/bombeiro.php";

    // 8° passo: Converter a imagem para base64
    String baseImage = base64.encode(_image.readAsBytesSync());

    var response = await http.post(url, body: {
      "nome": nome.text,
      "email": email.text,
      "image": baseImage,
      "tipo": "imagem"
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
        msg: "Preencha os campos corretamente",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        fontSize: 20.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Post realizado com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        fontSize: 20.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Resenha(),
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
                    'Postar Treino',
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
                  child: Text('Postar',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {

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