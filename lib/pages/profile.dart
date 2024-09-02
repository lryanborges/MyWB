import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/widgets/bottomNavBar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdBG,
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
      body: Column(
        children: [
          const SizedBox(height: 30,),
          const Center(
            child: CircleAvatar(radius: 70, backgroundImage: AssetImage('assets/images/pfp_6.jpg'),),
          ),
          const SizedBox(height: 16,),
          const Text('User 069', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tdFontColor),),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoContainer('Peso', '96kg',screenWidth),
              _buildInfoContainer('Altura', '1.77m',screenWidth),
              _buildInfoContainer('Horas de sono', '7.2h',screenWidth)
            ],
          ),
          const SizedBox(height: 24,),
          _buildImageContainer('Suas estatisticas', 'images/graph.png',screenWidth, screenHeight),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _buildInfoContainer(String label, String value, double screenWidth) {
    final RegExp regExp = RegExp(r'(\d+\.?\d*)'); // Expressão regular para número
    final Match? match = regExp.firstMatch(value);

    String number = match != null ? match.group(0) ?? '' : '';
    String unit = value.replaceFirst(number, '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(fontSize: screenWidth * 0.045, color: tdFontColor),),
        SizedBox(height: screenWidth * 0.02),
        Container(
          width: screenWidth * 0.25,
          height: screenWidth * 0.25,
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            color: tdContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: number,
                    style: TextStyle(fontSize: number.length < 3 ? screenWidth * 0.09 : screenWidth * 0.08, fontWeight: FontWeight.bold, color: tdFontColor),
                  ),
                  TextSpan(
                    text: unit,
                    style: TextStyle(fontSize: screenWidth * 0.045, color: tdFontColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(String label, String imagePath, double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(fontSize: screenWidth * 0.045, color: tdFontColor),),
        SizedBox(height: screenHeight * 0.02),
        Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.25,
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
