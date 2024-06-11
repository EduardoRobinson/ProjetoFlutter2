import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto/componentes/meu_snack_bar.dart';
import 'package:projeto/pages/consultar_heroi_page.dart';
import 'package:projeto/pages/deletar_heroi_page.dart';
import 'package:projeto/pages/adicionar_heroi_page.dart';
import 'package:projeto/pages/editar_heroi_page.dart';
import 'package:projeto/pages/consulta_via_api_page.dart';
import 'package:projeto/servicos/autenticacao_servico.dart';
import 'componentes/decoracao_campo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heroes Repository',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: RoteadorTela(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  consultarHeroi() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ConsultaHeroiPage()));
  }

  adicionarHeroi() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => AdicionarHeroiPage()));
  }

  deleteHeroi() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => DeletaHeroiPage()));
  }

  editarHeroi() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => EditarHeroiPage()));
  }

  consultaviaAPI() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ConsultaHeroiPageAPI()));
  }

  @override
  Widget build(BuildContext context) {
    AutenticacaoServico _authService = AutenticacaoServico();
    List<String> opcoes = [
      "Consultar Heroi",
      "Adicionar Heroi",
      "Editar Heroi",
      "Deletar Heroi",
      "Consultar Informações via API"
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("images/herois.jpg", width: 400, height: 300),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: opcoes.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    if (opcoes[index] == 'Consultar Heroi') {
                      consultarHeroi();
                    }
                    if (opcoes[index] == 'Adicionar Heroi') {
                      adicionarHeroi();
                    }
                    if (opcoes[index] == 'Editar Heroi') {
                      editarHeroi();
                    }
                    if (opcoes[index] == 'Deletar Heroi') {
                      deleteHeroi();
                    }
                    if (opcoes[index] == 'Consultar Informações via API') {
                      consultaviaAPI();
                    }
                  },
                  child: Text(opcoes[index]),
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _authService.deslogar();
              },
              child: Text("Deslogar")),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  AutenticacaoServico _authService = AutenticacaoServico();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmarSenhaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child:
                      Image.asset("images/herois.jpg", width: 400, height: 300),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: getAuthenticationInputDecoration("Email"),
                  validator: (String? value) {
                    if (value == null) {
                      return "O email não pode ser vazio";
                    }
                    if (value.length < 5) {
                      return "Email invalido";
                    }
                    if (!value.contains("@")) {
                      return "Email invalido";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _senhaController,
                  decoration: getAuthenticationInputDecoration("Senha"),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null) {
                      return "A senha não pode ser vazia";
                    }
                    if (value.length < 6) {
                      return "Digite uma senha maior que 6 digitos";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Visibility(
                    visible: !queroEntrar,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _confirmarSenhaController,
                          decoration: getAuthenticationInputDecoration(
                              "Confirme Senha"),
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null) {
                              return "A senha não pode ser vazia";
                            }
                            if (value.length < 6) {
                              return "Digite uma senha maior que 6 digitos";
                            }
                            if (value != _senhaController.text) {
                              return "Senha digitada esta diferente da anterior";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _nomeController,
                          decoration: getAuthenticationInputDecoration("Nome"),
                          validator: (String? value) {
                            if (value == null) {
                              return "O nome não pode ser vazio";
                            }
                            if (value.length < 6) {
                              return "Digite um nome maior que 6 digitos";
                            }
                            return null;
                          },
                        )
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      botaoClicado();
                    },
                    child: Text((queroEntrar) ? "Entrar" : "Cadastrar")),
                Divider(),
                TextButton(
                    onPressed: () {
                      setState(() {
                        queroEntrar = !queroEntrar;
                      });
                    },
                    child: Text((queroEntrar)
                        ? "Cadastrar"
                        : "Já tem uma conta? Entre"))
              ]),
            ),
          ),
        ));
  }

  botaoClicado() {
    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        _authService
            .logarUsuario(
                email: _emailController.text, senha: _senhaController.text)
            .then(
          (String? erro) {
            if (erro != null) {
              mostrarSnackBar(context: context, texto: erro);
            } else {}
          },
        );
      } else {
        _authService
            .cadastrarUsuario(
                nome: _nomeController.text,
                senha: _senhaController.text,
                email: _emailController.text)
            .then((String? erro) {
          if (erro != null) {
            mostrarSnackBar(context: context, texto: erro);
          } else {
            mostrarSnackBar(
                context: context, texto: "Cadastro realizado", isErro: false);
          }
        });
      }
    }
  }
}

class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyHomePage(title: 'Heroes Repository');
        } else {
          return LoginPage(title: 'Heroes Repository');
        }
      },
    );
  }
}
