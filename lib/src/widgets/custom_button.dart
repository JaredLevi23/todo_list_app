import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final Color? backgroundColor;
  final String label;
  final Function()? onPressed;

  const CustomButton({ Key? key, this.backgroundColor, required this.label, this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular( 15 )
      ),
      height: 60,
      color: backgroundColor ?? Colors.indigo,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text( label , style: const  TextStyle( fontSize: 19 ))
    );
  }
}