import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../dummy_data/dummy_data.dart'; 

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  DateTime? departureDate;
  int requestedSeats = 1;

  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    departureDate = DateTime.now();
    _dateController.text = DateFormat('yyyy-MM-dd').format(departureDate!);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        departureDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Departure Dropdown
          DropdownButtonFormField<Location>(
            value: departure,
            hint: const Text("Leaving from"),
            items: fakeLocations.map((loc) {
              return DropdownMenuItem<Location>(
                value: loc,
                child: Text(loc.name),
              );
            }).toList(),
            onChanged: (Location? value) {
              setState(() {
                departure = value;
              });
            },
          ),
          const SizedBox(height: 10),

          // Arrival Dropdown
          DropdownButtonFormField<Location>(
            value: arrival,
            hint: const Text("Going to"),
            items: fakeLocations.map((loc) {
              return DropdownMenuItem<Location>(
                value: loc,
                child: Text(loc.name),
              );
            }).toList(),
            onChanged: (Location? value) {
              setState(() {
                arrival = value;
              });
            },
          ),
          const SizedBox(height: 10),

          // Date Picker
          TextField(
            controller: _dateController,
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: const InputDecoration(labelText: 'Date'),
          ),
          const SizedBox(height: 10),

          // Passengers Counter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Passengers:'),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (requestedSeats > 1) requestedSeats--;
                      });
                    },
                  ),
                  Text('$requestedSeats'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        requestedSeats++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Search Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 27, 156, 199),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              // Handle search logic
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
