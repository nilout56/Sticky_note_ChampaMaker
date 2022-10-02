import 'package:flutter/material.dart';
import 'package:gdg_brainstorm/page/home_page.dart';
import 'package:gdg_brainstorm/page/state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_)=>Todo(),
child:  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
  )
  )
  );
  
}

