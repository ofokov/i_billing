import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_billing/features/ibilling/data/models/contract_model.dart';
import 'package:i_billing/features/ibilling/data/models/user_model.dart';

import '../../domain/enteties/contracts.dart';
import '../../domain/enteties/user.dart';

abstract interface class IbillingRemoteDataSources {
  Future<List<Contract>> getListContracts();
  Future<User> getUserInfo(String email);
  Future<Contract> getContract(String id);
  Future<void> createNewContract(Contract contract);
  Future<void> deleteContract(Contract contract);

  //new

  Future<List<Contract>> getLimitedListOfContract();
  Future<List<Contract>> getMoreListOfContract(List<Contract> contracts);
}

class IbillingRemoteDataSourcesImpl implements IbillingRemoteDataSources {
  final FirebaseFirestore firebaseFirestore;

  IbillingRemoteDataSourcesImpl({required this.firebaseFirestore});

  @override
  Future<List<Contract>> getListContracts() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('list_of_contracts');
      QuerySnapshot querySnapshot =
          await collectionReference.orderBy('date').get();

      return querySnapshot.docs.map((doc) {
        try {
          return ContractModel.fromJson(doc.data() as Map<String, dynamic>);
        } catch (_) {
          return Contract();
        }
      }).toList();
    } catch (e) {
      print(e.toString());
    }

    return [Contract()];
  }

  @override
  Future<User> getUserInfo(String email) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> result =
          await FirebaseFirestore.instance.collection('user').doc(email).get();
      return UserModel.fromJson(result.data() as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
    }

    return User(
        fullName: 'GYHUJI',
        phoneNumber: 'hjnk',
        profession: 'tyguhjik',
        dateOfBirth: 'ctyvyubini',
        email: "ftyguhij");
  }

  @override
  Future<void> createNewContract(Contract contract) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      print(contract.date);
      final Map<String, dynamic> jsonContract =
          (contract as ContractModel).toJson();

      // Add the contract to the 'list_of_contracts' collection
      final doc =
          await firestore.collection('list_of_contracts').add(jsonContract);
      print(jsonContract);

      // Get the generated document ID
      final String id = doc.id;

      // Add the document ID to the JSON data
      jsonContract['id'] = id;
      print(jsonContract);

      // Update the document with the new data
      await firestore
          .collection('list_of_contracts')
          .doc(id)
          .update(jsonContract);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  @override
  Future<Contract> getContract(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> result =
          await FirebaseFirestore.instance
              .collection('list_of_contracts')
              .doc(id)
              .get();
      return ContractModel.fromJson(result.data() as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
    }

    return Contract();
  }

  @override
  Future<List<Contract>> getLimitedListOfContract() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('list_of_contracts');
      QuerySnapshot querySnapshot =
          await collectionReference.orderBy('date').limit(3).get();

      return querySnapshot.docs.map((doc) {
        try {
          return ContractModel.fromJson(doc.data() as Map<String, dynamic>);
        } catch (_) {
          return Contract();
        }
      }).toList();
    } catch (e) {
      print(e.toString());
    }

    return [Contract()];
  }

  @override
  Future<List<Contract>> getMoreListOfContract(List<Contract> contracts) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('list_of_contracts');
      QuerySnapshot querySnapshot = await collectionReference
          .orderBy('date')
          .startAfter([contracts.last.contractNumber])
          .limit(3)
          .get();

      contracts.addAll(querySnapshot.docs.map((doc) {
        try {
          return ContractModel.fromJson(doc.data() as Map<String, dynamic>);
        } catch (_) {
          return Contract();
        }
      }));
      return contracts;
    } catch (e) {
      print(e.toString());
    }

    return [Contract()];
  }

  @override
  Future<void> deleteContract(Contract contract) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add the contract to the 'list_of_contracts' collection
      final doc = await firestore
          .collection('list_of_contracts')
          .doc(contract.id)
          .delete();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
