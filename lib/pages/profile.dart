import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/widgets/bottom_navbar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
            Get.toNamed('/profile_details');
          },
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: tdRed,
              child: Icon(Icons.logout, color: Colors.white), // Ícone de logout
            ),
            onPressed: () {
              // TODO deslogar
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Column(
            children: [
              const SizedBox(height: 30,),
              const Center(
                child: CircleAvatar(radius: 70, backgroundImage: AssetImage('assets/images/pfp_6.jpg'),),
              ),
              const SizedBox(height: 16,),
              const Text('User 069', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tdFontColor),),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoContainer('Peso', '96kg',screenWidth, 'weight'),
                  _buildInfoContainer('Altura', '177cm',screenWidth, 'height'),
                  _buildInfoContainer('Sono', '7.2h',screenWidth, 'average-sleep')
                ],
              ),
              const SizedBox(height: 24,),
              _buildImageContainer('Suas estatisticas', 'assets/images/graph.png',screenWidth, screenHeight, 'statistics'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildInfoContainer(String label, String value, double screenWidth, String svgName) {
    final RegExp regExp = RegExp(r'(\d+\.?\d*)'); // Expressão regular para número
    final Match? match = regExp.firstMatch(value);

    String number = match != null ? match.group(0) ?? '' : '';
    String unit = value.replaceFirst(number, '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 35,
          child:Row(
            mainAxisSize: MainAxisSize.min, // pra manter o row compacto c o conteudo
            children: [
              SvgPicture.asset(
                'assets/icons/$svgName.svg',
                width: 32,
                height: 32,
                color: tdWhite,
              ),
              const SizedBox(width: 4.0),
              Flexible(
                child: Text(label, style: TextStyle(fontSize: screenWidth * 0.045, color: tdFontColor, height: 1.0)),
              ),
            ],
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Container(
          width: screenWidth * 0.25,
          height: screenWidth * 0.25,
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            color: tdContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Flexible(
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
        ),
      ],
    );
  }

  Widget _buildImageContainer(String label, String imagePath, double screenWidth, double screenHeight, String svgName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const SizedBox(width: 25.0),
            SvgPicture.asset(
              'assets/icons/${svgName}.svg',
              width: 32,
              height: 32,
              color: tdWhite,
            ),
            const SizedBox(width: 4.0),
            Text(label, style: TextStyle(fontSize: screenWidth * 0.045, color: tdFontColor)),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.25,
          decoration: BoxDecoration(
            color: tdContainer,
            borderRadius: BorderRadius.circular(4),
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
