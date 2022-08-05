import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bytebank/components/container.dart';

import '../models/name.dart';

class NameContext extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}

class NameView extends StatelessWidget {
  final TextEditingController _namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _namecontroller.text = context.read<NameCubit>().state;

    // BlocBuilder<NameCubit, String>()

    return Scaffold(
      appBar: AppBar(title: const Text("Change name")),
      body: Column(
        children: [
          TextField(
            controller: _namecontroller,
            decoration: const InputDecoration(labelText: "Desired name"),
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                child: Text("Change"),
                onPressed: () {
                  final name = _namecontroller.text;
                  context.read<NameCubit>().change(name);
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
