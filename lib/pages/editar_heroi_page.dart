import 'package:flutter/material.dart';
import '../models/heroes.dart';
import '../controllers/heroes_controller.dart';
import '../pages/editar_heroi_detalhes_page.dart';
import 'dart:io';

class EditarHeroiPage extends StatefulWidget {
  EditarHeroiPage({Key? key}) : super(key: key);

  @override
  _EditarHeroiPage createState() => _EditarHeroiPage();
}

class _EditarHeroiPage extends State<EditarHeroiPage> {
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

  editarHeroi(Heroes heroi, String index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                EditarHeroiDetalhesPage(heroe: heroi, index: index)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Herois'),
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
                  onTap: () => editarHeroi(
                      listaHerois[index], listaHerois[index].nomeHeroi),
                );
              },
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, __) => Divider(),
              itemCount: listaHerois.length,
            ),
    );
  }
}
