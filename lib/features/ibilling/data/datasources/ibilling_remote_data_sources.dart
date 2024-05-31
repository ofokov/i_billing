import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_billing/features/ibilling/data/models/contract_model.dart';
import 'package:i_billing/features/ibilling/data/models/user_model.dart';

import '../../domain/enteties/contracts.dart';
import '../../domain/enteties/user.dart';

abstract interface class IbillingRemoteDataSources {
  Future<List<Contract>> getListContracts();
  Future<User> getUserInfo(String email);
  Future<void> createNewContract(Contract contract);
}

class IbillingRemoteDataSourcesImpl implements IbillingRemoteDataSources {
  final FirebaseFirestore firebaseFirestore;

  IbillingRemoteDataSourcesImpl({required this.firebaseFirestore});

  @override
  Future<List<Contract>> getListContracts() async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('list_of_contracts');
      QuerySnapshot querySnapshot = await collectionReference.get();

      return querySnapshot.docs
          .map((doc) =>
              ContractModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    return [
      Contract(
        contractState: '',
        isSaved: true,
        contractNumber: 5,
        fullName: '',
        amount: '',
        lastInvoiceNumber: 5,
        numberOfInvoices: 5,
        date: DateTime.now(),
      )
    ];
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
      FirebaseFirestore.instance
          .collection('list_of_contracts')
          .doc()
          .set((contract as ContractModel).toJson());
    } catch (e) {
      print(e.toString());
    }
  }
}
