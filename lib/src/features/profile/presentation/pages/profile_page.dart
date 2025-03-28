import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Perfil"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar e nome do usuário
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/profile.jpg'), // Substitua pela imagem real
            ),
            SizedBox(height: 10),
            Text(
              "Rubika Menon",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "maze@gmail.com",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Estatísticas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatCard("12 Doações", Icons.favorite, Colors.red),
                SizedBox(width: 10),
                _buildStatCard("1 Campanha", Icons.campaign, Colors.blue),
              ],
            ),

            SizedBox(height: 20),

            // Seção de Atividade
            _buildSectionTitle("Atividade"),
            _buildListTile(Icons.volunteer_activism, "Minhas doações", context,
                "/minhas-doacoes"),
            _buildListTile(Icons.campaign, "Minhas campanhas", context,
                "/minhas-campanhas"),
            _buildListTile(Icons.history, "Histórico de eventos", context,
                "/historico-eventos"),
            _buildListTile(Icons.bookmark, "Salvos", context, "/salvos"),

            SizedBox(height: 20),

            // Configurações de Conta
            _buildSectionTitle("Configurações da Conta"),
            _buildListTile(
                Icons.edit, "Editar perfil", context, "/editar-perfil"),
            _buildListTile(Icons.lock, "Senha", context, "/senha"),
            _buildListTile(Icons.security, "Segurança", context, "/seguranca"),

            SizedBox(height: 20),

            // Seção Bancária
            _buildSectionTitle("Banco"),
            _buildListTile(Icons.account_balance, "Editar conta bancária",
                context, "/editar-banco"),
            _buildListTileWithIcon(
                Icons.credit_card,
                "Adicionar detalhes fiscais",
                Icons.info_outline,
                context,
                "/adicionar-fiscais"),

            SizedBox(height: 20),

            // Preferências
            _buildSectionTitle("Preferências"),
            _buildListTile(Icons.dark_mode, "Tema", context, "/tema"),
            _buildListTile(
                Icons.language, "Idioma (Português)", context, "/idioma"),
            _buildListTile(
                Icons.notifications, "Notificações", context, "/notificacoes"),

            SizedBox(height: 20),

            // Suporte
            _buildSectionTitle("Ajuda & Suporte"),
            _buildListTile(Icons.article, "Termos, Políticas e Licenças",
                context, "/termos"),
            _buildListTile(
                Icons.help_outline, "Perguntas frequentes", context, "/faq"),

            SizedBox(height: 20),

            // Login e Conta ONG
            _buildSectionTitle("Login"),
            ListTile(
              leading: Icon(Icons.group_add, color: Colors.green),
              title: Text("Criar conta ONG",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  "Você pode alternar entre conta pessoal e conta comunitária a qualquer momento"),
              onTap: () {
                Navigator.pushNamed(context, "/criar-ong");
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Sair",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushNamed(context, "/logout");
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget para exibir estatísticas (ex: Doações, Campanhas)
  Widget _buildStatCard(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Título da seção
  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Lista de opções com navegação
  Widget _buildListTile(
      IconData icon, String title, BuildContext context, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  // Lista de opções com ícone extra (ex: Adicionar detalhes fiscais)
  Widget _buildListTileWithIcon(IconData icon, String title, IconData extraIcon,
      BuildContext context, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(extraIcon, size: 16),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
