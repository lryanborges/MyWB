import 'package:flutter/material.dart';
import 'package:my_wb/constants/colors.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdBG,
        title: const Text('Perfil', style: TextStyle(color: tdFontColor, fontSize: 18),),
        centerTitle: true,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: tdWhite,
            child: Icon(Icons.edit),
          ),
          onPressed: () {
            // Colocar alguma coisa depois
          },
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: tdRed,
              child: Icon(Icons.logout, color: Colors.white), // Ícone de logout
            ),
            onPressed: () {
              // Colocar alguma coisa depois
            },
          ),
        ],
      ),
      body: Container(
        color: tdBG,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16,),
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/pfp_6.jpg'),
              ),
              const SizedBox(height: 30,),
              const Text('User 069', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tdFontColor),),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoContainer('Peso', '96kg'),
                  _buildInfoContainer('Altura', '1.77m'),
                  _buildInfoContainer('Horas de sono', '7.2h')
                ],
              ),
              SizedBox(height: 24,),
              _buildImageContainer('Suas estatisticas', 'images/graph.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String label, String value) {
    final RegExp regExp = RegExp(r'(\d+\.?\d*)'); // Expressão regular para número
    final Match? match = regExp.firstMatch(value);

    String number = match != null ? match.group(0) ?? '' : '';
    String unit = value.replaceFirst(number, '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(fontSize: 18, color: tdFontColor),),
        SizedBox(height: 8,),
        Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: tdContainer,
            borderRadius: BorderRadius.circular(10)
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: tdFontColor),
                ),
                TextSpan(
                  text: unit,
                  style: TextStyle(fontSize: 16, color: tdFontColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(String label, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(fontSize: 18, color: tdFontColor),),
        SizedBox(height: 8,),
        Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: tdContainer,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.none,
            ),
          ),
        ),
      ],
    );
  }
}