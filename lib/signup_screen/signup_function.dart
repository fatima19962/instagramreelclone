import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';
class  SignupFunction {
   static FirebaseAuth _auth = FirebaseAuth.instance;
   static FirebaseFirestore _firestore =FirebaseFirestore.instance;
   //instance read write delete ,...
   static Future<bool>createAccount(String email,String password) async{
        try{
         final result= await _auth.createUserWithEmailAndPassword(email:email,password:password);
          if(result.user !=null){
            _saveUserDetails(email);
            debugPrint(" user not null ");
             return true;


          }else{
            debugPrint(" user is null ");
            return false;
          }




         }catch(e){
            print(e);
            return false;
          }
   }


   static Future<void> _saveUserDetails(String email) async{
         try{
             String uid = _auth.currentUser!.uid;
             UserModel  userModel =UserModel(
                 uid:uid,
                 email: "",
                 name:"",
                 username:"",
                 bio:"",
                 addLink:"",
                 profileImage:"",
                 posts:0,
                 followers:0,
                 following:0,
             );
             await _firestore.collection('users').doc(uid).set(userModel.toJson());
             print("detail saved sucessfully");
         }catch(e){
           print(e);
         }
   }










}


// Future signUp() async{
//   // showCupertinoDialog(context: context, builder: builder)
//   try{
//
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailcon.text.trim(),
//         password: ''
//
//     )
//   }on FirebaseAuthException catch (e){
//     print(e);
//   }
// }