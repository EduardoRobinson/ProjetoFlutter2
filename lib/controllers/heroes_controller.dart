import '../models/heroes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeroesController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> save(Heroes heroi, String id) async {
    try {
      await _firestore.collection('herois').doc(heroi.nomeHeroi).set({
        'nome': heroi.nome,
        'heroi': heroi.nomeHeroi,
        'ano criacao': heroi.anoCriacao,
        'criador': heroi.criador,
        'poderes': heroi.poderes,
        'origem': heroi.origem,
        'imagem': heroi.imagem
      });
      return true;
    } catch (e) {
      print("Erro ao salvar herói: $e");
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await _firestore.collection('herois').doc(id).delete();
      return true;
    } catch (e) {
      print("Erro ao deletar herói: $e");
      return false;
    }
  }

  Future<List<Heroes>> selectAll() async {
    List<Heroes> herois = [];
    try {
      final heroisDB = await _firestore.collection('herois').get();
      heroisDB.docs.forEach((doc) {
        herois.add(Heroes(
          nome: doc['nome'],
          nomeHeroi: doc['heroi'],
          anoCriacao: doc['ano criacao'],
          criador: doc['criador'],
          poderes: doc['poderes'],
          origem: doc['origem'],
          imagem: doc['imagem'],
        ));
      });
    } catch (e) {
      print("Erro ao selecionar todos os heróis: $e");
    }
    return herois;
  }

  Future<bool> edit(String id, String nome, String nomeHeroi, String poderes,
      String anoCriacao, String criador, String origem) async {
    try {
      await _firestore.collection('herois').doc(id).update({
        'nome': nome,
        'heroi': nomeHeroi,
        'ano criacao': anoCriacao,
        'criador': criador,
        'poderes': poderes,
        'origem': origem,
      });
      return true;
    } catch (e) {
      print("Erro ao editar herói: $e");
      return false;
    }
  }
}
