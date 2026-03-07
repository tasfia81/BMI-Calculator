// import 'package:flutter/material.dart';
//
// class BmiScreen extends StatefulWidget {
//   const BmiScreen({super.key, required title});
//
//   @override
//   State<BmiScreen> createState() => _BmiScreenState();
// }
//
// class _BmiScreenState extends State<BmiScreen> {
//
//   double height = 170.00;
//   double weight = 65.00;
//
//   double get bmi{
//     double heightInMeter=height/100;
//     return weight/(heightInMeter*heightInMeter);
//   }
//
//   String get category{
//     double currentBmi = bmi;
//     if(currentBmi<18.5) return "Underweight";
//     if(currentBmi<24.9) return "Normal";
//     if(currentBmi<29.9) return "Overweight";
//     return "Obesity";
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BMI CALCULATOR'),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Height : ${height.toInt()} cm"),
//           Slider(value: height, min: 100,max: 220, divisions: 20,label: "${height.toInt()} cm", onChanged: (value){
//             setState(() {
//               height = value;
//             });
//           }),
//           Text("Weight : ${weight.toInt()} kg"),
//           Slider(value: weight, min: 30,max: 150, divisions: 120,label: "${weight.toInt()} kg", onChanged: (value){
//             setState(() {
//               weight = value;
//             });
//           }),
//           SizedBox(height: 40,),
//           Text("Your BMI is : ${bmi.toStringAsFixed(1)}",
//             style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20,),
//           Text("Category : ${category}",style: TextStyle(
//             fontSize: 22,color: Colors.blueGrey
//           ),),
//         ],
//       ),
//
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isCm = true;

  double heightCm = 170;
  double heightFeet = 5;
  double heightInch = 7;
  double weight = 65;

  double get heightInMeter {
    if (isCm) {
      return heightCm / 100;
    } else {
      double totalInch = (heightFeet * 12) + heightInch;
      return totalInch * 0.0254;
    }
  }

  double get bmi => weight / (heightInMeter * heightInMeter);

  String get category {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal";
    if (bmi < 29.9) return "Overweight";
    return "Obesity";
  }

  Color get categoryColor {
    if (bmi < 18.5) return Colors.purple;
    if (bmi < 24.9) return Colors.pink;
    if (bmi < 29.9) return Colors.deepOrange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:  Color(0xFFF4F6FA),
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("BMI Calculator",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Toggle Card -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("CM"),
                    Switch(
                      value: isCm,
                      activeColor: Colors.indigo,
                      onChanged: (value) {
                        setState(() {
                          isCm = value;
                        });
                      },
                    ),
                     Text("Feet"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Height Card -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Text(
                      "Height",
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    if (isCm) ...[
                      Text("${heightCm.toInt()} cm",
                          style: TextStyle(fontSize: 16.sp)),
                      Slider(
                        value: heightCm,
                        min: 100,
                        max: 220,
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            heightCm = value;
                          });
                        },
                      ),
                    ] else ...[
                      Text(
                        "${heightFeet.toInt()} ft ${heightInch.toInt()} inch",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Slider(
                        value: heightFeet,
                        min: 3,
                        max: 7,
                        divisions: 4,
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            heightFeet = value;
                          });
                        },
                      ),
                      Slider(
                        value: heightInch,
                        min: 0,
                        max: 11,
                        divisions: 11,
                        activeColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            heightInch = value;
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            ///=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Weight Card =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                      Text(
                      "Weight",
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Text("${weight.toInt()} kg",
                        style: TextStyle(fontSize: 16.sp)),
                    Slider(
                      value: weight,
                      min: 30,
                      max: 150,
                      activeColor: Colors.indigo,
                      onChanged: (value) {
                        setState(() {
                          weight = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

             SizedBox(height: 20.h),

            ///-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Result Card -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
            Card(
              elevation: 6,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding:  EdgeInsets.all(20.w),
                child: Column(
                  children: [
                      Text(
                      "Your BMI",
                      style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      bmi.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: categoryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


