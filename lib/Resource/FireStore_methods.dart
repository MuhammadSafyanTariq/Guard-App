import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';


// class firestoreMethods {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<String> uploadPost(
//     String description,
//     Uint8List file,
//     String uid,
//     String username,
//     String profileImage,
//   ) async {
//     String res = 'Some error occured';
//     try {
//       String photoUrl =
//           await StorageMehtods().uploadImagetoStorage('posts', file, true);
//       String postId = const Uuid().v1();
//       Post post = Post(
//         description: description,
//         uid: uid,
//         username: username,
//         likes: [],
//         postId: postId,
//         datePublished: DateTime.now(),
//         postUrl: photoUrl,
//         profImage: profileImage,
//       );
//       _firestore.collection('posts').doc(postId).set(post.toJson());
//       res = 'success';
//     } catch (error) {
//       res = error.toString();
//     }
//     return res;
//   }

  // Future<void> likePost(String postId, String uid, List likes) async {
  //   try {
  //     if (likes.contains(uid)) {
  //       await _firestore.collection('posts').doc(postId).update({
  //         'likes': FieldValue.arrayRemove([uid]),
  //       });
  //     } else {
  //       await _firestore.collection('posts').doc(postId).update({
  //         'likes': FieldValue.arrayUnion([uid]),
  //       });
  //     }
  //   } catch (error) {}
  // }

  // Future<void> postComment(
  //   String postId,
  //   String text,
  //   String uid,
  //   String name,
  //   String profilePic,
  // ) async {
  //   try {
  //     if (text.isNotEmpty) {
  //       String commentId = const Uuid().v1();
  //       await _firestore
  //           .collection('posts')
  //           .doc(postId)
  //           .collection('comments')
  //           .doc(commentId)
  //           .set({
  //         'profilePic': profilePic,
  //         'name': name,
  //         'uid': uid,
  //         'text': text,
  //         'commentId': commentId,
  //         'datePublished': DateTime.now(),
  //       });
  //     } else {
  //       print('TExt is empty');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> deletePost(String postId) async {
  //   try {
  //     await _firestore.collection('posts').doc(postId).delete();
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  // Future<void> followUser(String uid, String followId) async {
  //   try {
  //     DocumentSnapshot snap =
  //         await _firestore.collection('users').doc(uid).get();
  //     List following = (snap.data() as dynamic)['following'];
  //     if (following.contains(followId)) {
  //       await _firestore.collection('users').doc(uid).update({
  //         'following': FieldValue.arrayRemove([uid]),
  //       });

  //       await _firestore.collection('users').doc(uid).update({
  //         'followers': FieldValue.arrayRemove([followId]),
  //       });
  //     } else {
  //       await _firestore.collection('users').doc(followId).update({
  //         'followers': FieldValue.arrayUnion([uid]),
  //       });

  //       await _firestore.collection('users').doc(uid).update({
  //         'following': FieldValue.arrayUnion([followId]),
  //       });
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  // Future<void> signOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }
