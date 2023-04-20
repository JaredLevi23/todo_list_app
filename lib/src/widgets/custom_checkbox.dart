import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {

  final bool value;
  final Function( bool? )? onChanged;

  const CustomCheckbox({ Key? key, required this.value, this.onChanged }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only( bottom: 15 ),
      // decoration: BoxDecoration(
      //   border: Border.all( width: 1, color: Colors.grey ),
      //   borderRadius: BorderRadius.circular( 15 )
      // ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),

          const SizedBox(
            width: 10,
          ),

          const Text( 
            'Mark as done',
            style: TextStyle(
              fontSize: 17
            ),
          )
        ],
      )
    );
  }
}