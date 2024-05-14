import 'package:flutter/material.dart';
import '../models/heroes.dart';
import 'dart:io';
import '../controllers/heroes_controller.dart';

class DeletaHeroiPage extends StatefulWidget {
  DeletaHeroiPage({Key? key}) : super(key: key);

  @override
  _DeletaHeroiPage createState() => _DeletaHeroiPage();
}

class _DeletaHeroiPage extends State<DeletaHeroiPage> {
  HeroesController controller = HeroesController();
  late List<Heroes> listaHerois;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getAll();
  }

  Future<void> getAll() async {
    listaHerois = await HeroesController().selectAll();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deletarHeroi(String index) async {
    bool sucesso = await controller.delete(index.toString());
    if (sucesso) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Heroi deletado com sucesso!!!')));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deletar Heroi')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: (listaHerois[index].imagem.contains('images/'))
                      ? Image.asset(listaHerois[index].imagem)
                      : Image.file(File(listaHerois[index].imagem)),
                  title: Text(listaHerois[index].nomeHeroi),
                  trailing: Text(listaHerois[index].nome),
                  onLongPress: () => deletarHeroi(listaHerois[index].nomeHeroi),
                );
              },
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, __) => Divider(),
              itemCount: listaHerois.length),
    );
  }
}
