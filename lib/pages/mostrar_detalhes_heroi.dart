import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/heroes.dart';
import 'dart:io';

class MostrarDetalhesHeroiPage extends StatefulWidget{
final Heroes heroe;
MostrarDetalhesHeroiPage({Key?key,required this.heroe}):super(key:key);

@override
_MostrarDetalhesHeroiPage createState() => _MostrarDetalhesHeroiPage();


}

class _MostrarDetalhesHeroiPage extends State<MostrarDetalhesHeroiPage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.heroe.nomeHeroi),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center( // Adicionando o widget Center aqui
        child: Column( 
          children: [
            SizedBox(
              child: (widget.heroe.imagem.contains('images/')) ? Image.asset(widget.heroe.imagem):Image.file(File(widget.heroe.imagem)),
              width: 300,
              height: 300,
            ),
            Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children:[
            Text("Nome:",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.heroe.nome),
            Text("Heroi:",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.heroe.nomeHeroi),
            Text("Origem:",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.heroe.origem),
            Text("Poderes:",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.heroe.poderes),
            Text("Criador:",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.heroe.criador),
            Text("Ano de criação:",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.heroe.anoCriacao),
          ],
          )
          ],
        ),
      ),
    );
  }
}

