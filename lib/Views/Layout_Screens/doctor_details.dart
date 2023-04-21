import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {
  final String name;
  final String image;
  final String education;
  final String speciality;
  final int rating;
    const DoctorDetails({
      Key? key, required this.name,
      required this.image,
      required this.education,
      required this.speciality,
      required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:   Text(name,style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,),),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            height: 250,
            width: width,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Image.network(image,fit: BoxFit.fill,),
          ),
          const SizedBox(height: 8,),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: width/2.7,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('rating : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                      Text('$rating.0'),

                    ],
                  )
                  ,
                ),
                Container(
                  width: width/2.2,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20)
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('education : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                      Text(education.toString()),

                    ],
                  )
                  ,
                ),
                Container(
                  width: width/1.6,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20)
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8,top: 8,bottom: 8),
                        child: Text('speciality : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ),

                      Text(speciality.toString() ,style: const TextStyle(fontSize: 16),),

                    ],
                  )
                  ,
                ),
              ],
            ),
          ),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child:  Text("Doctor's Bio",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blueAccent ),),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20)
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text("$name is a skilled and experienced $speciality with a focus on minimally invasive techniques."
                        " He has done $education and completed his residency at Johns Hopkins Hospital. "
                        "$name is known for his exceptional patient care, attention to detail, and commitment to providing personalized "
                        "treatment plans. He is a member of several professional organizations, including the  College of $speciality "
                        "and the Society of $speciality."
                        " $name expertise and dedication have earned him a reputation as a top $speciality in his field.",
                    style: const TextStyle(fontSize: 15.5,letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
