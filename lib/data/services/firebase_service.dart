import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../models/loan_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ==================== AUTHENTICATION ====================
  
  // User Sign Up
  Future<User?> signUp(String email, String password, String name, String phone, String role) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Save user data to Firestore
      UserModel newUser = UserModel(
        name: name,
        email: email,
        phone: phone,
        role: role,
        createdAt: DateTime.now(),
      );
      
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toMap());
      
      return userCredential.user;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  // User Sign In
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  // Get Current User Data
  Future<UserModel?> getCurrentUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.id, userDoc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  // ==================== USER CRUD OPERATIONS ====================

  // CREATE - Add New Borrower
  Future<void> addBorrower(UserModel borrower) async {
    try {
      await _firestore.collection('users').add(borrower.toMap());
    } catch (e) {
      throw Exception('Failed to add borrower: $e');
    }
  }

  // READ - Get All Borrowers
  Stream<List<UserModel>> getAllBorrowers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'borrower')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // READ - Get Single Borrower
  Future<UserModel> getBorrower(String borrowerId) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(borrowerId).get();
    return UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }

  // UPDATE - Edit Borrower
  Future<void> updateBorrower(String borrowerId, UserModel updatedBorrower) async {
    try {
      await _firestore
          .collection('users')
          .doc(borrowerId)
          .update(updatedBorrower.toMap());
    } catch (e) {
      throw Exception('Failed to update borrower: $e');
    }
  }

  // DELETE - Remove Borrower
  Future<void> deleteBorrower(String borrowerId) async {
    try {
      await _firestore.collection('users').doc(borrowerId).delete();
    } catch (e) {
      throw Exception('Failed to delete borrower: $e');
    }
  }

  // ==================== LOAN CRUD OPERATIONS ====================

  // CREATE - Create New Loan
  Future<void> createLoan(LoanModel loan) async {
    try {
      await _firestore.collection('loans').add(loan.toMap());
    } catch (e) {
      throw Exception('Failed to create loan: $e');
    }
  }

  // READ - Get All Loans
  Stream<List<LoanModel>> getAllLoans() {
    return _firestore
        .collection('loans')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LoanModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // READ - Get Loans by Borrower
  Stream<List<LoanModel>> getLoansByBorrower(String borrowerId) {
    return _firestore
        .collection('loans')
        .where('borrowerId', isEqualTo: borrowerId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LoanModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // UPDATE - Update Loan Status
  Future<void> updateLoanStatus(String loanId, String status) async {
    try {
      await _firestore
          .collection('loans')
          .doc(loanId)
          .update({'status': status});
    } catch (e) {
      throw Exception('Failed to update loan status: $e');
    }
  }

  // DELETE - Delete Loan
  Future<void> deleteLoan(String loanId) async {
    try {
      await _firestore.collection('loans').doc(loanId).delete();
    } catch (e) {
      throw Exception('Failed to delete loan: $e');
    }
  }
}