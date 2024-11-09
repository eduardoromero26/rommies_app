import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomies_app/models/expense_model.dart';
import 'package:roomies_app/services/firestore/firestore_service.dart';
import 'package:roomies_app/services/secure_storage/secure_storage_service.dart';
import 'package:roomies_app/utils/firestore_keys.dart';
import 'package:roomies_app/utils/secure_storage_keys.dart';

class ExpensesService {
  final FirestoreService firestoreService = FirestoreService();
  final SecureStorageService secureStorageService = SecureStorageService();

  Future<void> createExpense(ExpenseModel expense) async {
    try {
      final String? houseId =
          await secureStorageService.read(SecureStorageKeys.houseId);
      if (houseId != null) {
        final documentReference = FirebaseFirestore.instance
            .collection(
                '${FirestoreKeys.houses}/$houseId/${FirestoreKeys.expenses}')
            .doc();
        final String expenseId = documentReference.id;
        expense = expense.copyWith(id: expenseId);
        await documentReference.set(expense.toJson());
      } else {
        throw Exception('House ID is null');
      }
    } catch (e) {
      Exception('Error creating expense: $e');
    }
  }

  // Future<ExpenseModel?> readExpense(String expenseId) async {
  //   try {
  //     String? houseId = await _getHouseId();
  //     if (houseId == null) {
  //       print('House ID is null');
  //       return null;
  //     }
  //     DocumentSnapshot doc = await _firestoreService.readDocument(
  //         'houses/$houseId/expenses', expenseId);
  //     if (doc.exists) {
  //       return ExpenseModel.fromJson(doc.data() as Map<String, dynamic>);
  //     } else {
  //       print('Expense document does not exist');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error reading expense: $e');
  //     return null;
  //   }
  // }

  Future<void> updateExpense(String expenseId, ExpenseModel expense) async {
    try {
      final String? houseId =
          await secureStorageService.read(SecureStorageKeys.houseId);
      if (houseId != null) {
        await firestoreService.updateDocument(
            '${FirestoreKeys.houses}/$houseId/${FirestoreKeys.expenses}',
            expenseId,
            expense.toJson());
      } else {
        throw Exception('House ID is null');
      }
    } catch (e) {
      Exception('Error updating expense: $e');
    }
  }

  // Future<void> deleteExpense(String expenseId) async {
  //   try {
  //     String? houseId = await _getHouseId();
  //     if (houseId == null) {
  //       print('House ID is null');
  //       return;
  //     }
  //     await _firestoreService.deleteDocument(
  //         'houses/$houseId/expenses', expenseId);
  //   } catch (e) {
  //     print('Error deleting expense: $e');
  //   }
  // }

  Future<List<ExpenseModel>> readAllExpenses() async {
    try {
      final String? houseId =
          await secureStorageService.read(SecureStorageKeys.houseId);
      List<DocumentSnapshot> docs = await firestoreService.readAllDocuments(
        'houses/$houseId/expenses',
        orderBy: 'date',
        descending: true,
      );
      return docs.map((doc) {
        return ExpenseModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      Exception('Error reading all expenses: $e');
      return [];
    }
  }
}
