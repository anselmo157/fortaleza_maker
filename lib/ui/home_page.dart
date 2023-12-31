import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fortaleza_maker/data/controller.dart';
import 'package:fortaleza_maker/ui/widgets/custom_textformfield.dart';
import 'package:fortaleza_maker/ui/widgets/value_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Controller controller;
  TextEditingController responseController = TextEditingController();
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void initState() {
    controller = Controller();
    controller.checkPermissions();

    bluetoothManager.startScan(timeout: const Duration(seconds: 4));
    bluetoothManager.scanResults.listen((event) {
      for(int i = 0; i < event.length; i ++){
        print(event[i].name);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/fortaleza_maker_logo.svg'),
                Container(
                  width: size.width * 0.8,
                  margin: const EdgeInsets.only(top: 24.0),
                  child: CustomTextFormField(controller: responseController),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      ValueItem(type: 'P', controller: controller),
                      const Divider(
                        thickness: 1.0,
                        color: Color(0xFFA7A9AC),
                      ),
                      ValueItem(type: 'I', controller: controller),
                      const Divider(
                        thickness: 1.0,
                        color: Color(0xFFA7A9AC),
                      ),
                      ValueItem(type: 'D', controller: controller),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.0,
                  color: Color(0xFFA7A9AC),
                ),
                Text(
                  'VELOCIDADE MAX: ${controller.velocity}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Stencil',
                    color: Color(0xFFA7A9AC),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.85,
                  child: Slider(
                    min: 0.0,
                    max: 1.5,
                    divisions: 30,
                    activeColor: const Color(0xFFF5D22E),
                    thumbColor: const Color(0xFFF5D22E),
                    label: controller.velocity.toString(),
                    value: controller.velocity,
                    onChanged: (double value) => setState(() {
                      String valueSend = value.toStringAsFixed(2);
                      controller.changeVelocity(double.parse(valueSend));
                    }),
                    onChangeEnd: (double value) {},
                  ),
                ),
                Container(
                  width: size.width * 0.75,
                  margin: const EdgeInsets.only(top: 24.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF5D22E),
                    ),
                    child: const Text(
                      'INICIAR',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: 'Stencil',
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            top: 32.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5D22E),
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.bluetooth,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
