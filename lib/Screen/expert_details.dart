import 'package:flutter/material.dart';

class ExpertDetails extends StatelessWidget {
  const ExpertDetails({Key? key, required this.expertName}) : super(key: key);

  final String expertName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expertName),
        backgroundColor: Colors.purple.withOpacity(0.8),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.message_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white70, shape: BoxShape.circle),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(50),
                    child: Image.asset(
                        'images/i.png',
                        fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: Icon(Icons.location_on_outlined,color: Colors.purple,)
                ),
                enabled: false,
                controller: TextEditingController(text: 'afif,damascus,syria'),
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: Icon(Icons.phone,color: Colors.purple,)
                ),
                enabled: false,
                controller: TextEditingController(text: '+963987416589'),
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Skills',
                  labelStyle: const TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                maxLines: 4,
                enabled: false,
                controller: TextEditingController(text: "can play football"),
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'availability :',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.purple,
                      ),
                      label: const Text(
                        '9:35 am',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                  const Text('to',style: TextStyle(color: Colors.black54,),),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.purple,
                      ),
                      label: const Text(
                        '1:35 pm',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Rating :',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 15,),
                  Icon(Icons.star,color: Colors.yellow,size: 20,),
                  SizedBox(width: 7,),
                  Text('4.5 / 5',style: TextStyle(fontWeight: FontWeight.w700),)
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                  children: [
                    const Text(
                      'Constructions :',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Column(
                      children: const [
                        Text('Medical Construction',style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),),
                        SizedBox(height: 10,),
                        Text('Financial Construction',style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),),
                        SizedBox(height: 10,),
                        Text('Medical Construction',style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.timer_rounded,color: Colors.white,),
        backgroundColor: Colors.purple,
        onPressed: (){},
      ),
    );
  }
}
