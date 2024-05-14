import 'package:flutter/material.dart';
import '../models/heroes.dart';
import '../controllers/heroes_controller.dart';

class EditarHeroiDetalhesPage extends StatefulWidget {
  final Heroes heroe;
  final String index;

  EditarHeroiDetalhesPage({Key? key, required this.heroe, required this.index})
      : super(key: key);

  @override
  _EditarHeroiDetalhesPageState createState() =>
      _EditarHeroiDetalhesPageState();
}

class _EditarHeroiDetalhesPageState extends State<EditarHeroiDetalhesPage> {
  Future<void> editarHeroi(String index) async {
    HeroesController controller = HeroesController();
    bool sucesso = await controller.edit(
        index.toString(),
        _nomeController.text,
        _nomeHeroiController.text,
        _poderesController.text,
        _anoCriacaoController.text,
        _criadorController.text,
        _origem);
    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Heroi editado com sucesso!!!')));
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _nomeHeroiController = TextEditingController();
  final _poderesController = TextEditingController();
  final _anoCriacaoController = TextEditingController();
  final _criadorController = TextEditingController();
  String _origem = '';

  final List<String> kOptions = [
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
    'Viajante do Tempo',
    'Radiação Gama'
  ];

  int? _origemSelectedIndex;

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.heroe.nome;
    _nomeHeroiController.text = widget.heroe.nomeHeroi;
    _poderesController.text = widget.heroe.poderes;
    _anoCriacaoController.text = widget.heroe.anoCriacao.toString();
    _criadorController.text = widget.heroe.criador;
    _origem = widget.heroe.origem;

    // Verifica se o valor inicial de _origem está presente nos itens
    if (kOptions.contains(_origem)) {
      _origemSelectedIndex = kOptions.indexOf(_origem);
    } else {
      _origemSelectedIndex = 0;
      _origem = kOptions[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar herói'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nomeHeroiController,
                    decoration: InputDecoration(labelText: 'Nome do herói'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome do herói';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                      controller: _poderesController,
                      decoration: InputDecoration(labelText: 'Poderes'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira os poderes';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _anoCriacaoController,
                      decoration: InputDecoration(labelText: 'Ano de criação'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o ano de criação';
                        }
                        return null;
                      }),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Natureza:', style: TextStyle()),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: DropdownButtonFormField<String>(
                      value: _origemSelectedIndex == null
                          ? null
                          : kOptions[_origemSelectedIndex!],
                      items: kOptions.map((String value) {
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
                          _origemSelectedIndex = kOptions.indexOf(newValue!);
                          _origem = newValue;
                        });
                      },
                    ),
                  ),
                  TextFormField(
                      controller: _criadorController,
                      decoration: InputDecoration(labelText: 'Criador'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do criador';
                        }
                        return null;
                      }),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        editarHeroi(widget.index);
                      }
                    },
                    child: Text('Salvar'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
