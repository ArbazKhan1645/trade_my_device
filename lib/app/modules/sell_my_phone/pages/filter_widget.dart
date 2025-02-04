import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/modules/sell_my_phone/controllers/sell_my_phone_controller.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellMyPhoneController>(
        init: SellMyPhoneController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Brand Filter Section
              const Text(
                'Brand',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              ...controller.brandOptions.keys.map((brand) {
                return CheckboxListTile(
                  value: controller.brandOptions[brand],
                  title: Text(brand),
                  activeColor: Colors.pink,
                  onChanged: (value) =>
                      controller.toggleSelection('Brand', brand),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),

              SizedBox(height: 20),
              const Text(
                'Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              ...controller.typesOptions.keys.map((type) {
                return CheckboxListTile(
                  value: controller.typesOptions[type],
                  title: Text(type),
                  activeColor: Colors.pink,
                  onChanged: (value) =>
                      controller.toggleSelection('Type', type),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),
            ],
          );
        });
  }
}
