import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:viewit_sorter/models/array_item.dart';

import 'widgets/array_item_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sorting Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

// Function for style to buttons
Widget styleElevatedButton({
  VoidCallback? onPressed,
  required Text child,
  Gradient? gradient,
  Color? color,
  double borderRadius = 0, // Change borderRadius to 0 for rectangular buttons
  EdgeInsets padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
}) {
  double buttonWidth = 240; // Set the fixed width here

  return SizedBox( // Wrap the ElevatedButton with SizedBox to set the width
    width: buttonWidth,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient ?? (color == null ? null : LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.yellowAccent, Colors.black],
          )),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          padding: padding,
          child: Center(child: child),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: (gradient == null && color != null) ? MaterialStateProperty.all(color) : null,
      ),
    ),
  );
}


class _MainWidgetState extends State<MainWidget> {
  List<ArrayItem> array = [];
  final controller = TextEditingController();

  int speed = 1000;
  int multiplier = 1;

  void speedSetter() {
    if (multiplier > 0) {
      setState(() {
        speed = 1000 ~/ multiplier;
      });
    } else {
      setState(() {
        multiplier = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     actions: [
        //   Center(
        //     child: Text(
        //       "$multiplier x Speed",
        //       style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        //     ),
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       multiplier--;
        //       speedSetter();
        //     },
        //     icon: const Icon(Icons.remove),
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       multiplier++;
        //       speedSetter();
        //     },
        //     icon: const Icon(Icons.add),
        //   ),
        // ]
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(0.2),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            controller.clear();
                          });
                        }),
                    border: const OutlineInputBorder(),
                    labelText: 'Enter comma or space separated numbers',
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),


                // // Options Format No 1 ---------------------
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: [
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize bubble sort
                //         await bubbleSort();
                //       }
                //           : null,
                //       child: const Text("Bubble Sort"),
                //     ),
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize insersion sort
                //         await insertionSort();
                //       }
                //           : null,
                //       child: const Text("Insersion Sort"),
                //     ),
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize selection sort
                //         await selectionSort();
                //       }
                //           : null,
                //       child: const Text("Selection Sort"),
                //     ),
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize selection sort
                //         await countSort();
                //       }
                //           : null,
                //       child: const Text("Count Sort"),
                //     ),
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize selection sort
                //         await bucketSort();
                //       }
                //           : null,
                //       child: const Text("Bucket Sort"),
                //     ),
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize selection sort
                //         await quickSort();
                //       }
                //           : null,
                //       child: const Text("Quick Sort"),
                //     ),
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize selection sort
                //         await radixSort();
                //       }
                //           : null,
                //       child: const Text("Radix Sort"),
                //     ),
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize selection sort
                //         await heapSort();
                //       }
                //           : null,
                //       child: const Text("Heap Sort"),
                //     ),
                //     styleElevatedButton(
                //       onPressed: controller.text.isNotEmpty || array.isNotEmpty
                //           ? () async {
                //         saveInputValuesToArray();
                //         // visualize selection sort
                //         await mergeSort();
                //       }
                //           : null,
                //       child: const Text("Merge Sort"),
                //     ),
                //   ],
                // ),


                // // Options Format No 2 ---------------------
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust as needed
                        children: [
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize bubble sort
                              await bubbleSort();
                            }
                                : null,
                            child: const Text("Bubble Sort"),  // 1
                          ),
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize selection sort
                              await selectionSort();
                            }
                                : null,
                            child: const Text("Selection Sort"),   // 2
                          ),
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize insertion sort
                              await insertionSort();
                            }
                                : null,
                            child: const Text("Insertion Sort"),  // 3
                          ),
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize quick sort
                              await quickSort();
                            }
                                : null,
                            child: const Text("Quick Sort"),  // 4
                          ),
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize merge sort
                              await mergeSort();
                            }
                                : null,
                            child: const Text("Merge Sort"), // 5
                          ),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust as needed
                        children: [
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize count sort
                              await countSort();
                            }
                                : null,
                            child: const Text("Count Sort"),   // 6
                          ),
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize radix sort
                              await radixSort();
                            }
                                : null,
                            child: const Text("Radix Sort"),  // 7
                          ),
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize bucket sort
                              await bucketSort();
                            }
                                : null,
                            child: const Text("Bucket Sort"),  // 8
                          ),
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize heap sort
                              await heapSort();
                            }
                                : null,
                            child: const Text("Heap Sort"),  // --> 9
                          ),
                          styleElevatedButton(
                            onPressed: controller.text.isNotEmpty || array.isNotEmpty
                                ? () async {
                              saveInputValuesToArray();
                              // visualize heap sort
                              await combSort();
                            }
                                : null,
                            child: const Text("Comb Sort"),  // --> 10
                          ),
                  
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // // /////   Style No 1 ----------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // get random array values between 0 - 1000
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          array = [];
                          controller.clear();
                          // number of items in array according to screen width
                          final numberOfItems = MediaQuery.of(context).size.width ~/ 32;
                          for (int i = 0; i < numberOfItems; i++) {
                            int randValue = Random().nextInt(1000);
                            array.add(
                              ArrayItem(value: randValue, color: Colors.blueGrey),
                            );
                            controller.text += "$randValue";
                            if (i != numberOfItems - 1) {
                              controller.text += ",";
                            }
                          }
                        });
                      },
                      // child: const Text("Randomize Array"),
                      child: Text(
                                "Randomize Array",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                    ),

                    SizedBox(width: 16), // Add some spacing between buttons

                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            multiplier--;
                            speedSetter();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        IconButton(
                          onPressed: () {
                            multiplier++;
                            speedSetter();
                          },
                          icon: const Icon(Icons.add),
                        ),
                        const SizedBox(width: 8), // Add some spacing between plus button and text
                        Text(
                          "$multiplier x Speed",
                          style: const TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),

                // // /////   Style No 2 ----------------------------------------------
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // ElevatedButton(
                //     //   onPressed: () {
                //     //     // Add your pause functionality here
                //     //   },
                //     //   child: Text("Pause"),
                //     // ),
                //     // SizedBox(width: 16), // Add some spacing between buttons
                //
                //     // get random array values between 0 - 1000
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.green,
                //       ),
                //       onPressed: () {
                //         setState(() {
                //           array = [];
                //           controller.clear();
                //           // number of items in array accotding to screen width
                //           final numberOfItems = MediaQuery.of(context).size.width ~/ 32;
                //           for (int i = 0; i < numberOfItems; i++) {
                //             int randValue = Random().nextInt(1000);
                //             array.add(
                //               ArrayItem(value: randValue, color: Colors.blueGrey),
                //             );
                //             controller.text += "$randValue";
                //             if (i != numberOfItems - 1) {
                //               controller.text += ",";
                //             }
                //           }
                //         });
                //       },
                //       child: Text(
                //         "Randomize Array",
                //         style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                //       ),
                //     ),
                //
                //     SizedBox(width: 16), // Add some spacing between buttons
                //     IconButton(
                //       onPressed: () {
                //         multiplier--;
                //         // speedSetter();
                //       },
                //       icon: const Icon(Icons.remove),
                //     ),
                //     IconButton(
                //       onPressed: () {
                //         multiplier++;
                //         // speedSetter();
                //       },
                //       icon: const Icon(Icons.add),
                //     ),
                //     const SizedBox(width: 8), // Add some spacing between plus button and text
                //     Text(
                //       "$multiplier x Speed",
                //       style: const TextStyle(color: Colors.black45, fontSize: 17, fontWeight: FontWeight.w700),
                //     ),
                //   ],
                // ),


                // // /////   Style No 3 ----------------------------------------------
                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         // Button to randomize array
                //         ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: Colors.green,
                //           ),
                //           onPressed: () {
                //             setState(() {
                //               array = [];
                //               controller.clear();
                //               // number of items in array according to screen width
                //               final numberOfItems = MediaQuery.of(context).size.width ~/ 32;
                //               for (int i = 0; i < numberOfItems; i++) {
                //                 int randValue = Random().nextInt(1000);
                //                 array.add(
                //                   ArrayItem(value: randValue, color: Colors.blueGrey),
                //                 );
                //                 controller.text += "$randValue";
                //                 if (i != numberOfItems - 1) {
                //                   controller.text += ",";
                //                 }
                //               }
                //             });
                //           },
                //           child: Text(
                //             "Randomize Array",
                //             style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                //           ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(height: 20), // Add spacing between the rows
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align controls to the ends
                //       children: [
                //         // Button to pause
                //         ElevatedButton(
                //           onPressed: () {
                //             // Add your pause functionality here
                //           },
                //           child: Text("Pause"),
                //         ),
                //         // Spacer to push the speed controls to the right
                //         Spacer(),
                //         // Minus button for speed
                //         IconButton(
                //           onPressed: () {
                //             multiplier--;
                //             speedSetter();
                //           },
                //           icon: Icon(Icons.remove),
                //         ),
                //         // Plus button for speed
                //         IconButton(
                //           onPressed: () {
                //             multiplier++;
                //             speedSetter();
                //           },
                //           icon: Icon(Icons.add),
                //         ),
                //         // Text showing the speed
                //         Text(
                //           "$multiplier x Speed",
                //           style: TextStyle(color: Colors.black45, fontSize: 17, fontWeight: FontWeight.w700),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),


                // // /////   Style No 4 ----------------------------------------------
                // Container(
                //   padding: EdgeInsets.all(16.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       // Button to randomize array
                //       ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.green,
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             array = [];
                //             controller.clear();
                //             // number of items in array according to screen width
                //             final numberOfItems = MediaQuery.of(context).size.width ~/ 32;
                //             for (int i = 0; i < numberOfItems; i++) {
                //               int randValue = Random().nextInt(1000);
                //               array.add(
                //                 ArrayItem(value: randValue, color: Colors.blueGrey),
                //               );
                //               controller.text += "$randValue";
                //               if (i != numberOfItems - 1) {
                //                 controller.text += ",";
                //               }
                //             }
                //           });
                //         },
                //         child: Text(
                //           "Randomize Array",
                //           style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                //         ),
                //       ),
                //       // Button to pause
                //       ElevatedButton(
                //         onPressed: () {
                //           // Add your pause functionality here
                //         },
                //         child: Text("Pause"),
                //       ),
                //       // Minus button for speed
                //       IconButton(
                //         onPressed: () {
                //           multiplier--;
                //         },
                //         icon: Icon(Icons.remove),
                //       ),
                //       // Plus button for speed
                //       IconButton(
                //         onPressed: () {
                //           multiplier++;
                //         },
                //         icon: Icon(Icons.add),
                //       ),
                //       // Text showing the speed
                //       Text(
                //         "$multiplier x Speed",
                //         style: TextStyle(color: Colors.black45, fontSize: 17, fontWeight: FontWeight.w700),
                //       ),
                //     ],
                //   ),
                // ),



                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.72,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // color: Colors.blueGrey.withOpacity(0.1),
                      color: Colors.yellow.withOpacity(0.1),
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                array.clear();
                              });
                            },
                            icon: const Icon(Icons.clear, color: Colors.red),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < array.length; i++)
                              ArrayItemWidget(
                                speed: speed,
                                heightByValue: array[i],
                                widthByArraySize: MediaQuery.of(context).size.width * 0.7 / array.length,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> bubbleSort() async {
    for (int i = 0; i < array.length; i++) {
      array[i].color = Colors.green;
      for (int j = 0; j < array.length - i - 1; j++) {
        if (array[j].value > array[j + 1].value) {
          array[j].color = Colors.red;
          array[j + 1].color = Colors.red;
          await Future.delayed(
            Duration(milliseconds: speed),
                () {
              setState(() {
                ArrayItem temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
              });
            },
          );
          array[j].color = Colors.green;
          array[j + 1].color = Colors.green;
        }
      }
    }
  }

  Future<void> insertionSort() async {
    for (int i = 1; i < array.length; i++) {
      array[i].color = Colors.green;
      int j = i - 1;
      while (j >= 0 && array[j].value > array[j + 1].value) {
        array[j].color = Colors.red;
        array[j + 1].color = Colors.red;
        await Future.delayed(
          Duration(milliseconds: speed),
              () {
            setState(() {
              ArrayItem temp = array[j];
              array[j] = array[j + 1];
              array[j + 1] = temp;
            });
          },
        );
        array[j].color = Colors.green;
        array[j + 1].color = Colors.green;
        j--;
      }
    }
  }

  Future<void> selectionSort() async {
    for (int i = 0; i < array.length; i++) {
      array[i].color = Colors.green;
      int minIndex = i;
      for (int j = i + 1; j < array.length; j++) {
        if (array[j].value < array[minIndex].value) {
          minIndex = j;
        }
      }
      array[minIndex].color = Colors.red;
      array[i].color = Colors.red;
      await Future.delayed(
        Duration(milliseconds: speed),
            () {
          setState(() {
            ArrayItem temp = array[i];
            array[i] = array[minIndex];
            array[minIndex] = temp;
          });
        },
      );
      array[minIndex].color = Colors.green;
      array[i].color = Colors.green;
    }
  }

  Future<void> mergeSort() async {
    // merge sort with future delayed and color update
    await mergeSortHelper(0, array.length - 1);
  }

  Future<void> mergeSortHelper(int left, int right) async {
    if (left < right) {
      int mid = (left + right) ~/ 2;
      await mergeSortHelper(left, mid);
      await mergeSortHelper(mid + 1, right);
      await merge(left, mid, right);
    }
  }

  // merge function with future delayed and color update
  Future<void> merge(int left, int mid, int right) async {
    int n1 = mid - left + 1;
    int n2 = right - mid;
    List<ArrayItem> leftArray = [];
    List<ArrayItem> rightArray = [];
    for (int i = 0; i < n1; i++) {
      leftArray.add(array[left + i]);
    }
    for (int i = 0; i < n2; i++) {
      rightArray.add(array[mid + 1 + i]);
    }
    int i = 0;
    int j = 0;
    int k = left;
    while (i < n1 && j < n2) {
      if (leftArray[i].value <= rightArray[j].value) {
        leftArray[i].color = Colors.red;
        rightArray[j].color = Colors.red;
        await Future.delayed(
          Duration(milliseconds: speed),
              () {
            setState(() {
              array[k] = leftArray[i];
            });
          },
        );
        leftArray[i].color = Colors.green;
        rightArray[j].color = Colors.green;
        i++;
      } else {
        leftArray[i].color = Colors.red;
        rightArray[j].color = Colors.red;
        await Future.delayed(
          Duration(milliseconds: speed),
              () {
            setState(() {
              array[k] = rightArray[j];
            });
          },
        );
        leftArray[i].color = Colors.green;
        rightArray[j].color = Colors.green;
        j++;
      }
      k++;
    }
    while (i < n1) {
      leftArray[i].color = Colors.red;
      await Future.delayed(
        Duration(milliseconds: speed),
            () {
          setState(() {
            array[k] = leftArray[i];
          });
        },
      );
      leftArray[i].color = Colors.green;
      i++;
      k++;
    }
    while (j < n2) {
      rightArray[j].color = Colors.red;
      await Future.delayed(
        Duration(milliseconds: speed),
            () {
          setState(() {
            array[k] = rightArray[j];
          });
        },
      );
      rightArray[j].color = Colors.green;
      j++;
      k++;
    }
  }

  Future<void> combSort() async {
    // for (int i = array.length ~/ 2 - 1; i >= 0; i--) {
    //   await heapify(array.length, i);
    // }
    // for (int i = array.length - 1; i >= 0; i--) {
    //   array[0].color = Colors.red;
    //   array[i].color = Colors.red;
    //   await Future.delayed(
    //     Duration(milliseconds: speed),
    //         () {
    //       setState(() {
    //         ArrayItem temp = array[0];
    //         array[0] = array[i];
    //         array[i] = temp;
    //       });
    //     },
    //   );
    //   array[0].color = Colors.green;
    //   array[i].color = Colors.green;
    //   await heapify(i, 0);
    // }
  }


  Future<void> heapSort() async {
    for (int i = array.length ~/ 2 - 1; i >= 0; i--) {
      await heapify(array.length, i);
    }
    for (int i = array.length - 1; i >= 0; i--) {
      array[0].color = Colors.red;
      array[i].color = Colors.red;
      await Future.delayed(
        Duration(milliseconds: speed),
            () {
          setState(() {
            ArrayItem temp = array[0];
            array[0] = array[i];
            array[i] = temp;
          });
        },
      );
      array[0].color = Colors.green;
      array[i].color = Colors.green;
      await heapify(i, 0);
    }
  }

  Future<void> heapify(int n, int i) async {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    if (left < n && array[left].value > array[largest].value) {
      largest = left;
    }
    if (right < n && array[right].value > array[largest].value) {
      largest = right;
    }
    if (largest != i) {
      array[i].color = Colors.red;
      array[largest].color = Colors.red;
      await Future.delayed(
        Duration(milliseconds: speed),
            () {
          setState(() {
            ArrayItem temp = array[i];
            array[i] = array[largest];
            array[largest] = temp;
          });
        },
      );
      array[i].color = Colors.green;
      array[largest].color = Colors.green;
      await heapify(n, largest);
    }
  }

  Future<void> radixSort() async {
    // radix sort with future delayed
    for (int i = 0; i < array.length; i++) {
      array[i].color = Colors.green;
      int j = i - 1;
      while (j >= 0 && array[j].value > array[j + 1].value) {
        array[j].color = Colors.red;
        array[j + 1].color = Colors.red;
        await Future.delayed(
          Duration(milliseconds: speed),
              () {
            setState(() {
              ArrayItem temp = array[j];
              array[j] = array[j + 1];
              array[j + 1] = temp;
            });
          },
        );
        array[j].color = Colors.green;
        array[j + 1].color = Colors.green;
        j--;
      }
    }
  }

  Future<void> quickSort() async {
    await quickSortHelper(0, array.length - 1);
  }

  Future<void> quickSortHelper(int low, int high) async {
    if (low < high) {
      int pivot = await partition(low, high);
      await quickSortHelper(low, pivot - 1);
      await quickSortHelper(pivot + 1, high);
    }
  }

  Future<int> partition(int low, int high) async {
    int pivot = array[high].value;
    int i = low - 1;
    for (int j = low; j < high; j++) {
      if (array[j].value < pivot) {
        i++;
        array[i].color = Colors.red;
        array[j].color = Colors.red;
        await Future.delayed(
          Duration(milliseconds: speed),
              () {
            setState(() {
              ArrayItem temp = array[i];
              array[i] = array[j];
              array[j] = temp;
            });
          },
        );
        array[i].color = Colors.green;
        array[j].color = Colors.green;
      }
    }
    array[i + 1].color = Colors.red;
    array[high].color = Colors.red;
    await Future.delayed(
      Duration(milliseconds: speed),
          () {
        setState(() {
          ArrayItem temp = array[i + 1];
          array[i + 1] = array[high];
          array[high] = temp;
        });
      },
    );
    array[i + 1].color = Colors.green;
    array[high].color = Colors.green;
    return i + 1;
  }

  Future<void> bucketSort() async {
    // create buckets
    List<List<ArrayItem>> buckets = [];
    for (int i = 0; i < 10; i++) {
      buckets.add([]);
    }
    // add items to buckets
    for (int i = 0; i < array.length; i++) {
      int bucketIndex = array[i].value ~/ 100;
      buckets[bucketIndex].add(array[i]);
    }
    // sort items in buckets
    for (int i = 0; i < buckets.length; i++) {
      for (int j = 0; j < buckets[i].length; j++) {
        buckets[i][j].color = Colors.green;
        int k = j - 1;
        while (k >= 0 && buckets[i][k].value > buckets[i][k + 1].value) {
          buckets[i][k].color = Colors.red;
          buckets[i][k + 1].color = Colors.red;
          await Future.delayed(
            Duration(milliseconds: speed),
                () {
              setState(() {
                ArrayItem temp = buckets[i][k];
                buckets[i][k] = buckets[i][k + 1];
                buckets[i][k + 1] = temp;
              });
            },
          );
          buckets[i][k].color = Colors.green;
          buckets[i][k + 1].color = Colors.green;
          k--;
        }
      }
    }
    // merge buckets
    array = [];
    for (int i = 0; i < buckets.length; i++) {
      array.addAll(buckets[i]);
    }
  }

  Future<void> countSort() async {
    // count sort with future delay
    List<int> count = List.filled(1000, 0);
    for (int i = 0; i < array.length; i++) {
      count[array[i].value]++;
    }
    int index = 0;
    for (int i = 0; i < count.length; i++) {
      while (count[i] > 0) {
        array[index].color = Colors.red;
        await Future.delayed(
          Duration(milliseconds: speed),
              () {
            setState(() {
              array[index].value = i;
            });
          },
        );
        array[index].color = Colors.green;
        index++;
        count[i]--;
      }
    }
  }

  void saveInputValuesToArray() {
    array = controller.text
        .trim()
        .split(',')
        .map(
          (e) => ArrayItem(value: int.parse(e), color: Colors.black),
    )
        .toList();
    setState(() {});
  }
}



// class SortButton extends StatelessWidget {
//   const SortButton({super.key, required this.sortFunction, required this.sortName});

//   final Function sortFunction;
//   final String sortName;

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


