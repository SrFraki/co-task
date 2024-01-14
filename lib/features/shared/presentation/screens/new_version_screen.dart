import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewVersionScreen extends StatelessWidget {
   
  const NewVersionScreen({Key? key, required this.link}) : super(key: key);

  final String link;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Spacer(flex: 2,),

            Text(
              'NUEVA VERSION DISPONIBLE',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.grey.shade500
              ),
              textAlign: TextAlign.center,
            ),

            if(link != '')
              const Spacer(flex: 1,),
            
            if(link != '')
              TextButton(
                onPressed: (){
                  launchUrl(Uri.parse(link));
                }, 
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'DESCARGAR',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20
                    ),
                  ),
                )
              ),

            const Spacer(flex: 2,)
          ],
        ),
      ),
    );
  }
}