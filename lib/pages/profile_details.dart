import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_wb/constants/colors.dart';
import 'package:my_wb/controllers/profile_controller.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: tdBG,
      appBar: AppBar(
        backgroundColor: tdBG,
        centerTitle: true,
        title: const Text(
          'Dados do Usuário',
          style: TextStyle(
            color: tdFontColor,
            fontSize: 18
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),

            // Foto de Perfil
            Stack(
              alignment: Alignment.center,
              children: [
                // Imagem de perfil
                Obx(() => CircleAvatar(
                  radius: 60,
                  backgroundImage: controller.selectedImage.value != null
                    ? FileImage(controller.selectedImage.value!)
                    : const NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRurO8kRj216kjoFZVmlyf2v2eak-uUfukQKQ&s'
                    ) as ImageProvider,
                )),
                // Botão para mudar imagem de perfil
                Positioned(
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: tdBG,
                      size: 30,
                    ),
                    onPressed: () async {
                      await controller.selecionarImagem();
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10,),
            // Nome do Usuário  
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: controller.isEditing.value
                  ? TextField(
                    style: const TextStyle(color: tdFontColor),
                    decoration: InputDecoration(
                      hintText: 'Insira seu nome',
                      hintStyle: const TextStyle(color: tdFontColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onSubmitted: (value) {
                      if(value.isNotEmpty) {
                        controller.nameController.text = value;
                        controller.toggleEditing();
                      }
                    },
                  )
                  : Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 35,),
                        Text(
                          controller.nameController.text.isEmpty ? 'Insira um nome' : controller.nameController.text,
                          style: const TextStyle(fontSize: 18, color: tdFontColor),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            controller.toggleEditing();
                          },
                        ),
                      ],
                    ),
                  ),
              );
            }),
            // Informações de Peso, Altura e Sono
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: textFieldWithIcon(
                          infoController: controller.weightController,
                          hintText: 'Peso (kg)',
                          svgName: 'weight'
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: textFieldWithIcon(
                          infoController: controller.heightController,
                          hintText: 'Altura (m)',
                          svgName: 'height'
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textFieldWithIcon(
                      infoController: controller.sleepController,
                      hintText: 'Sono (h)',
                      svgName: 'average-sleep'
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            // Lista de opções
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'MyWB Persona',
                          style: TextStyle(
                            fontSize: 16,
                            color: tdFontColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Obx(() {
                          return Column(
                            children: [
                              buildRadioList(
                                title: 'Amigável',
                                value: 'amigavel',
                                groupValue: controller.selectedPersona.value,
                                onChanged: (value) => controller.selectedPersona.value = value!,
                              ),
                              buildRadioList(
                                title: 'Profissional',
                                value: 'profissional',
                                groupValue: controller.selectedPersona.value,
                                onChanged: (value) => controller.selectedPersona.value = value!,
                              ),
                              buildRadioList(
                                title: 'Motivacional',
                                value: 'motivacional',
                                groupValue: controller.selectedPersona.value,
                                onChanged: (value) => controller.selectedPersona.value = value!,
                              ),
                              buildRadioList(
                                title: 'Atencioso',
                                value: 'atencioso',
                                groupValue: controller.selectedPersona.value,
                                onChanged: (value) => controller.selectedPersona.value = value!,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Objetivos',
                          style: TextStyle(
                            fontSize: 16,
                            color: tdFontColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Obx(() {
                          return Column(
                            children: [
                              buildRadioList(
                                title: 'Perder peso',
                                value: 'perder_peso',
                                groupValue: controller.selectedObjective.value,
                                onChanged: (value) => controller.selectedObjective.value = value!,
                              ),
                              buildRadioList(
                                title: 'Ganhar massa',
                                value: 'ganhar_massa',
                                groupValue: controller.selectedObjective.value,
                                onChanged: (value) => controller.selectedObjective.value = value!,
                              ),
                              buildRadioList(
                                title: 'Dormir melhor',
                                value: 'dormir_melhor',
                                groupValue: controller.selectedObjective.value,
                                onChanged: (value) => controller.selectedObjective.value = value!,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            // Botões Cancelar e Salvar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdRed,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        ),
                      ),
                      onPressed: () {
                        // TODO Manter os dados anteriores após cancelar
                        Get.back();
                      },
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: tdFontColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdButton,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        ),
                      ),
                      onPressed: () async {
                        await controller.saveDatas();
                      },
                      child: const Text(
                        'Salvar',
                        style: TextStyle(color: tdFontColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldWithIcon({
    required TextEditingController infoController,
    required String hintText, 
    required String svgName
  }){
    return SizedBox(
      width: 180,
      height: 50, 
      child: Container(
        color: Colors.white, 
        child: Row(
          children: [
            Container(
              height: 50, 
              color: tdContainer, 
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                'assets/icons/$svgName.svg',
                width: 26,
                height: 26,
                color: tdWhite,
              ),
            ),
            Expanded(
              child: TextField(
                controller: infoController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: tdBG),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  filled: true,
                  fillColor: Colors.white, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioList({
    required String title,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged
  }){
    return RadioListTile<String>(
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, color: tdFontColor),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Colors.blue[300],
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}