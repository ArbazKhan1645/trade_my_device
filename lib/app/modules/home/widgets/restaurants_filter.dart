import 'package:flutter/material.dart';

class RestaurantFilterOptionsWidget extends StatefulWidget {
  const RestaurantFilterOptionsWidget({super.key});

  @override
  _RestaurantFilterOptionsWidgetState createState() =>
      _RestaurantFilterOptionsWidgetState();
}

class _RestaurantFilterOptionsWidgetState
    extends State<RestaurantFilterOptionsWidget> {
  bool openNow = false;
  bool newRestaurants = false;
  bool freeDelivery = false;
  bool hygieneRating = false;
  String minimumOrderAmount = 'Show all';
  int rating = 0;
  bool specialOffers = false;
  bool stampCards = false;
  bool halal = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 70),
            const Text('311 places',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildToggleOption('Open now', openNow,
                (value) => setState(() => openNow = value)),
            _buildToggleOption('New', newRestaurants,
                (value) => setState(() => newRestaurants = value)),
            _buildToggleOption('Free delivery', freeDelivery,
                (value) => setState(() => freeDelivery = value)),
            _buildToggleOption('Hygiene Rating 3+ / Pass', hygieneRating,
                (value) => setState(() => hygieneRating = value)),
            const SizedBox(height: 16),
            _buildSectionTitle('Minimum order amount', Icons.info_outline),
            _buildRadioOption('Show all (311)', 'Show all'),
            _buildRadioOption('£10.00 or less (285)', '£10.00 or less'),
            _buildRadioOption('£15.00 or less (303)', '£15.00 or less'),
            const SizedBox(height: 16),
            _buildSectionTitle('Rating', null),
            _buildRatingStars(),
            const SizedBox(height: 16),
            _buildSectionTitle('Offers and savings', Icons.info_outline),
            _buildCheckboxOption('Special offers (122)', specialOffers,
                (value) => setState(() => specialOffers = value!)),
            _buildCheckboxOption('StampCards (98)', stampCards,
                (value) => setState(() => stampCards = value!)),
            const SizedBox(height: 16),
            _buildSectionTitle('Dietary', null),
            _buildCheckboxOption(
                'Halal (44)', halal, (value) => setState(() => halal = value!)),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption(
      String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Switch(
          value: value,
          onChanged: onChanged,
          focusColor: const Color(0xFF00CCBC).withOpacity(0.20),
          activeTrackColor: const Color(0xFF00CCBC).withOpacity(0.20),
          trackColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.20)),
          activeColor: const Color(0xFF00CCBC),
          splashRadius: 1,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData? icon) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (icon != null) const SizedBox(width: 4),
        if (icon != null) Icon(icon, size: 16, color: Colors.orange),
      ],
    );
  }

  Widget _buildRadioOption(String title, String value) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: minimumOrderAmount,
      onChanged: (String? newValue) {
        setState(() {
          minimumOrderAmount = newValue!;
        });
      },
      activeColor: Colors.orange,
    );
  }

  Widget _buildRatingStars() {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.orange,
          ),
          onPressed: () {
            setState(() {
              rating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildCheckboxOption(
      String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.orange,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
