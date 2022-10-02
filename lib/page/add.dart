import 'package:flutter/material.dart';
import 'package:gdg_brainstorm/page/home_page.dart';
import 'package:gdg_brainstorm/page/state.dart';
import 'package:provider/provider.dart';
class AddPage extends StatelessWidget {
  final ctrl = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              validator: (value) {
                  if (value != null && value.trim().length < 3) {
                    return 'This field requires a minimum of 3 characters';
                  }

                  return null;
                },
              controller: ctrl,
              autofocus: true,
              //obscureText: true, ປິດບໍ່ໃຫ້ເຫັນລະຫັດ
                   
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 20),
                  borderRadius: BorderRadius.circular(5),
                ),
    hintText: 'ເພີ່ມຂໍ້ຄວາມຕາມທີ່ທ່ານຕ້ອງການ',
    
              ),
            ),
          ),
       

          ElevatedButton(onPressed: (){
            
              context.read<Todo>().add(ctrl.text);
              Navigator.pop(context);
            }, child: Text("ເພີ່ມ"),
            style: ElevatedButton.styleFrom(
              primary: Colors.green
            )
    
            ),
          
        ],
      ),
    );
  }
}