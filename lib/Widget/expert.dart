import 'package:cons_app/Screen/expert_details.dart';
import 'package:flutter/material.dart';

class Expert extends StatelessWidget {
  const Expert({Key? key, required this.name, required this.imgPath, required this.id}) : super(key: key);

  final String name;
  final String imgPath;
  final int id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: const Color.fromARGB(100, 0, 0, 65),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(30),
                  child: Image.asset(
                      'images/i.png',
                      fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15,),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ExpertDetails(expertName: name, id: id,))),
    );
  }
}
