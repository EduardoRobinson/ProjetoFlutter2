import 'package:flutter/material.dart';
import '../controllers/heroes_controller.dart';
import '../models/heroes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdicionarHeroiPage extends StatefulWidget {
  AdicionarHeroiPage({Key? key}) : super(key: key);

  @override
  _AdicionarHeroiPage createState() => _AdicionarHeroiPage();
}

class _AdicionarHeroiPage extends State<AdicionarHeroiPage> {
  int idHeroi = 0;
  Future<void> criaHeroi() async {
    idHeroi++;
    String caminhoDoArquivo = _imagem?.path ?? '';
    Heroes heroi = Heroes(
        imagem: caminhoDoArquivo,
        nome: _nome.text,
        nomeHeroi: _nomeHeroi.text,
        poderes: _poderes.text,
        origem: _origem ?? '',
        criador: _criador.text,
        anoCriacao: _anocriacao.text);
    HeroesController controller = HeroesController();
    bool sucesso = await controller.save(heroi, idHeroi.toString());
    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Heroi adicionado com sucesso!!!')));
    }
  }

  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _nomeHeroi = TextEditingController();
  final _poderes = TextEditingController();
  final _anocriacao = TextEditingController();
  final _criador = TextEditingController();
  String? _origem;
  File? _imagem;

  Future<void> _escolherImagem() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagem = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar heroi'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: _form,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _nome,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Nome'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, insira o nome';
                            }
                            return null;
                          },
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _nomeHeroi,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome Heroi',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, insira o nome';
                            }
                            return null;
                          },
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      child: Text('Natureza:', style: TextStyle()),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButtonFormField<String>(
                            value: _origem,
                            items: [
                              'Kriptoniano',
                              'Mutante',
                              'Velocista',
                              'Alienígena',
                              'Androide',
                              'Ciborgue',
                              'Atlante',
                              'Amazona',
                              'Feiticeiro',
                              'Humano Aprimorado',
                              'Metamorfo',
                              'Demônio',
                              'Anjo',
                              'Elemental',
                              'Viajante do Tempo'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Por favor, escolha a origem dos poderes';
                              }
                              return null;
                            },
                            onChanged: (String? newValue) {
                              setState(() {
                                _origem = newValue ?? '';
                              });
                            })),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _poderes,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Poderes'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, insira os poderes';
                            }
                            return null;
                          },
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _anocriacao,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ano de criação'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, insira o ano de criação';
                            }
                            return null;
                          },
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _criador,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Criador',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, insira o nome do criador';
                            }
                            return null;
                          },
                        )),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: _escolherImagem,
                          child: Text('Escolher Imagem'),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_form.currentState != null &&
                      _form.currentState!.validate() &&
                      _imagem != null) {
                    _form.currentState!.save();
                    criaHeroi();
                  }
                },
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
