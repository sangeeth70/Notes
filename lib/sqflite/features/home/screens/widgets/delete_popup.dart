import 'package:flutter/material.dart';

class DeletePopup extends StatelessWidget {
  final VoidCallback onYesTap;
  final VoidCallback onNoTap;
  const DeletePopup({super.key, required this.onYesTap, required this.onNoTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width/10),
      margin: EdgeInsets.symmetric(horizontal: 42,vertical: size.height/3),
      decoration: BoxDecoration(
        color: const Color(0xff141414),
        borderRadius: BorderRadius.circular(18)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Are you sure you want to delete?",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: onYesTap,
                child: Container(
                  alignment: Alignment.center,
                  width:100,
                  height: 40,
                  child: const Text('Yes',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  decoration: BoxDecoration(
                    border:Border.all(width: 1,color: const Color(0xff3C3C3C)),
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
              ),
              GestureDetector(
                onTap: onNoTap,
                child: Container(
                  alignment: Alignment.center,
                  width:100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xff323232),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Text('No',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
