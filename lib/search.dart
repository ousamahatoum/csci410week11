import 'package:flutter/material.dart';
import 'product.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controllerID = TextEditingController();
  String _text = '';

  @override
  void dispose() {
    _controllerID.dispose();
    super.dispose();
  }

  void update(String text) {
    setState(() {
      _text = text;
    });
  }

  void getProduct() {
    try {
      int pid = int.parse(_controllerID.text);
      searchProduct(update, pid);
    }
    catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('wrong arguments')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        centerTitle: true,
      ),
      body: Center(child: Column(children: [
        const SizedBox(height: 10),
        SizedBox(width: 200, child: TextField(controller: _controllerID, keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter ID'))),
       const SizedBox(height: 10),
        ElevatedButton(onPressed: getProduct,
            child: const Text('Find', style: TextStyle(fontSize: 18))),
        const SizedBox(height: 10),
        Center(child: SizedBox(width: 200, child: Flexible(child: Text(_text,
            style: const TextStyle(fontSize: 18))))),
      ],

      ),

      ),
    );
  }
}
