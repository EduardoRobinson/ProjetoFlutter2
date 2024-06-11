import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConsultaHeroiPageAPI extends StatefulWidget {
  ConsultaHeroiPageAPI({Key? key}) : super(key: key);

  @override
  _ConsultaHeroiPageAPIState createState() => _ConsultaHeroiPageAPIState();
}

final _form = GlobalKey<FormState>();
final _apikey = TextEditingController();

class _ConsultaHeroiPageAPIState extends State<ConsultaHeroiPageAPI> {
  List<String> heroisAPI = [
    "Spider-Man (Peter Parker) - 1009610",
    "Iron Man (Tony Stark) - 1009368",
    "Captain America (Steve Rogers) - 1009220",
    "Thor - 1009664",
    "Hulk (Bruce Banner) - 1009351",
    "Black Widow (Natasha Romanoff) - 1009189",
    "Hawkeye (Clint Barton) - 1009338",
    "Doctor Strange (Stephen Strange) - 1009282",
    "Black Panther (T'Challa) - 1009187",
    "Scarlet Witch (Wanda Maximoff) - 1009562",
    "Vision - 1009697",
    "Ant-Man (Scott Lang) - 1010801",
    "Wasp (Janet Van Dyne) - 1009707",
    "Star-Lord (Peter Quill) - 1010733",
    "Gamora - 1010763",
    "Rocket Raccoon - 1010744",
    "Groot - 1010743",
    "Drax the Destroyer - 1010735",
    "Thanos - 1009652",
    "Loki - 1009407",
    "Nick Fury - 1009471",
    "Falcon (Sam Wilson) - 1009297",
    "War Machine (James Rhodes) - 1009324",
    "Winter Soldier (Bucky Barnes) - 1010740",
    "Deadpool (Wade Wilson) - 1009268",
    "Wolverine (Logan) - 1009718",
    "Storm (Ororo Munroe) - 1009629",
    "Jean Grey - 1009327",
    "Cyclops (Scott Summers) - 1009257",
    "Magneto (Max Eisenhardt) - 1009417"
  ];

  Future<void> consultarAPI(String apikey) async {
    String url =
        'http://gateway.marvel.com/v1/public/characters/$apikey?apikey=b9732a0cc83d8e597a2aa31e2aab47ed&ts=1718051557.132379&hash=84a64982e27f43f54de01ff910f89f84';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<String> heroiData = [
          "Nome: ${data['data']['results'][0]['name']}",
          "Descrição: ${data['data']['results'][0]['description']}",
          "ID: ${data['data']['results'][0]['id']}"
        ];

        List<Map<String, dynamic>> comics = List<Map<String, dynamic>>.from(
          data['data']['results'][0]['comics']['items'],
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HeroDetailPage(
              heroiData: heroiData,
              comics: comics,
            ),
          ),
        );
      } else {
        print('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Herois via API'),
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
                        controller: _apikey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ID heroi',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, insira o id de algum heroi';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          consultarAPI(_apikey.text);
                        }
                      },
                      child: Text('Consultar'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: heroisAPI.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(heroisAPI[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  final List<String> heroiData;
  final List<Map<String, dynamic>> comics;

  HeroDetailPage({required this.heroiData, required this.comics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Herói'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heroiData[0],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                heroiData[1],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'HQs Principais:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...comics.map((comic) {
                return Card(
                  child: ListTile(
                    title: Text(comic['name']),
                    subtitle: Text(comic['resourceURI'] ?? 'Sem descrição'),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
