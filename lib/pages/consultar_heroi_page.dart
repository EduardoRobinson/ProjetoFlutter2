import 'package:flutter/material.dart';
import '../models/heroes.dart';
import 'mostrar_detalhes_heroi.dart';
import 'dart:io';
import '../controllers/heroes_controller.dart';

class ConsultaHeroiPage extends StatefulWidget {
  ConsultaHeroiPage({Key? key}) : super(key: key);

  @override
  _ConsultaHeroiPageState createState() => _ConsultaHeroiPageState();
}

class _ConsultaHeroiPageState extends State<ConsultaHeroiPage> {
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
    }); // Atualize o estado para reconstruir a UI com a lista atualizada
  }

  mostrarDetalhes(Heroes heroe) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MostrarDetalhesHeroiPage(heroe: heroe)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Herois'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
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
                  onTap: () => mostrarDetalhes(listaHerois[index]),
                );
              },
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, __) => Divider(),
              itemCount: listaHerois.length,
            ),
    );
  }
}
