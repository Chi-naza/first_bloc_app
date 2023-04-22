import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextFieldsWithHooks extends HookWidget {
  const TextFieldsWithHooks({super.key});

  @override
  Widget build(BuildContext context) {
    // textEditing controller with hooks
    final tController = useTextEditingController();
    // making text observable with useState
    final text = useState('');
    // useEffect to handle sideEffects
    useEffect(() {
      tController.addListener(() { 
        text.value = tController.text;
      });
      return null;
    }, 
      [tController],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page")
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: tController,              
            ),
            Text('You have typed: ${text.value}'),
          ],
        ),
      ),
    );
  }
}