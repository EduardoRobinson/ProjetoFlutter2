import '../models/heroes.dart';

class HeroesRepository{
 static List <Heroes> lista = [
  Heroes(imagem: "images/hulk.jpg", 
  nome: "Bruce Banner",
   nomeHeroi: "Hulk",
    poderes: "Super Força",
     origem: "Radiação Gama", 
     criador: "Stan Lee",
      anoCriacao: "1962"),
  Heroes(imagem: "images/batman.jpg",
   nome: "Bruce Wayne",
    nomeHeroi: "Batman", poderes: "Especialista em combate,estrategista",
     origem: "Liga das sombras",
      criador: "Bill Finger", 
      anoCriacao: "1939"),
  Heroes(imagem: "images/superman.jpg",
   nome: "Clark Kent",
    nomeHeroi: "SuperMan", 
    poderes: "Super Força, raios laser, resistencia a balas",
     origem: "Kryptoniano", 
     criador: "Jerry Siegel", 
     anoCriacao: "1939"),
 ];
}