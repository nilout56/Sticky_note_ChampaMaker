import 'package:flutter/material.dart';
import 'package:gdg_brainstorm/page/state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  final int index;
  final ctrl = TextEditingController();
  EditPage(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ctrl.text = context.read<Todo>().tasks[index];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            cursorColor: Colors.red,
            
            
            controller: ctrl,
              autofocus: true,
              //obscureText: true, ປິດບໍ່ໃຫ້ເຫັນລະຫັດ
                   
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 20),
                  borderRadius: BorderRadius.circular(5),
                ),
    
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<Todo>().edit(index, ctrl.text);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                    ),
                    child: Text("ແກ້ໄຂ", style: GoogleFonts.notoSansLao()),
                  ),
               
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<Todo>().delete(index);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text("ລົບ", style: GoogleFonts.notoSansLao()),
                    ),
                  ),
                ],
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
