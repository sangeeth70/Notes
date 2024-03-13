import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoteTile extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;
  final String title;
  final String note;
  const NoteTile({super.key, required this.onTap, required this.title, required this.note,required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border:Border.all(width: 1,color: const Color(0xff737373)),
            color: const Color(0xff202020),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title,style: const TextStyle(fontSize: 20,color: Colors.white),overflow: TextOverflow.ellipsis,)),
                  // const Icon(Icons.delete_outline_outlined,color: Colors.white,size: 16,)
                  GestureDetector(
                  onTap: onDeleteTap
                  ,child: Container(padding: const EdgeInsets.only(bottom: 12,left: 12,top: 6),color: const Color(0xff202020),child: SvgPicture.asset('assets/icons/delete.svg',height: 16,))),
                  // IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.white,size: 16,)),
                ],
              ),
              const SizedBox(height: 16,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(note,
                style: const TextStyle(fontSize: 14,color: Color(0xff737373),fontFamily: 'Mukta',overflow: TextOverflow.ellipsis,),maxLines: 7,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
