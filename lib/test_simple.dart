import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SimpleTest extends StatelessWidget {
  const SimpleTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Test')),
      body: Column(
        children: [
          // Test Button
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance.collection('test').add({
                  'message': 'Hello Firebase!',
                  'time': DateTime.now(),
                });
                print('✅ Firebase কাজ করছে!');
              } catch (e) {
                print('❌ Firebase Error: $e');
              }
            },
            child: const Text('Firebase Test করুন'),
          ),
          
          // Live Data দেখুন
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('test').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('✅ Firebase Connected! Data: ${snapshot.data!.docs.length}');
              }
              return const Text('❌ Firebase Connection Failed');
            },
          )
        ],
      ),
    );
  }
}