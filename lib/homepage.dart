import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  final dio = Dio();
  final name = TextEditingController();
  String countryResult = '';

  Future<void> getCountry(String name) async {
    final response = await dio.get('https://api.nationalize.io/?name=$name');
    final data = response.data;
    
    if (data['country'].isNotEmpty) {
      final country = data['country'][0]['country_id']; 
      setState(() {
        countryResult = 'Страна: $country';
      });
    } else {
      setState(() {
        countryResult = 'Страна не найдена';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Testing an API'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Введите ваше имя:'),
                    controller: name,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    getCountry(name.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(countryResult),
          ],
        ),
      ),
    );
  }
}
