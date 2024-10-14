import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/controllers/profile_controller.dart';
import 'package:my_wb/widgets/bottom_navbar.dart';
import 'package:my_wb/widgets/imc_chart.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController()); // control conexion
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    List<double> imcData = [
      controller.calcularIMC(70.0, 1.71),
      controller.calcularIMC(68.5, 1.71),
      controller.calcularIMC(78.3, 1.71)
    ];

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
              Get.toNamed('/login');
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
              Center(
                child: Obx(() => CircleAvatar(
                  radius: 70,
                  backgroundImage: controller.selectedImage.value != null
                    ? FileImage(controller.selectedImage.value!)
                    : const NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                    ) as ImageProvider,
                )),
              ),
              const SizedBox(height: 16,),
              Obx(() => Text(
                controller.userName.value,
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: tdFontColor
                ),
              )), 
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() => _buildInfoContainer('Peso', '${controller.userWeight.value}kg',screenWidth, 'weight')),
                  Obx(() => _buildInfoContainer('Altura', '${controller.userHeight.value}cm',screenWidth, 'height')),
                  Obx(() => _buildInfoContainer('Sono', '${controller.userSleep.value}h',screenWidth, 'average-sleep'))
                ],
              ),
              const SizedBox(height: 24,),
              _buildImageContainer('Suas estatisticas',screenWidth, screenHeight, imcData),
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
        child: Row(
          mainAxisSize: MainAxisSize.min, // pra manter o row compacto com o conteúdo
          children: [
            SvgPicture.asset(
              'assets/icons/$svgName.svg',
              width: 32,
              height: 32,
              color: tdWhite,
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: tdFontColor,
                  height: 1.0,
                ),
              ),
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
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: TextStyle(
                    fontSize: number.length < 3 ? screenWidth * 0.09 : screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: tdFontColor,
                  ),
                ),
                TextSpan(
                  text: unit,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: tdFontColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildImageContainer(String label, double screenWidth, double screenHeight, List<double> imcData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const SizedBox(width: 25.0),
            SvgPicture.asset(
              'assets/icons/statistics.svg',
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
          ),
          child: IMCChart(imcData: imcData),
        ),
      ],
    );
  }
}
