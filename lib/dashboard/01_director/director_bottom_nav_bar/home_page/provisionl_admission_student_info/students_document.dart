import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentDocument extends StatefulWidget {
  final String fullName;
  final String mobileNumber;
  final String email;
  final String course;

  const StudentDocument({
    super.key,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.course,
  });

  @override
  _StudentDocumentState createState() => _StudentDocumentState();
}

class _StudentDocumentState extends State<StudentDocument> {
  Map<String, String> documentUrls = {};
  Map<String, String> graduationDocumentUrls = {};
  bool isLoading = true;

  String? uid;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = widget.fullName;
      await fetchDocumentUrls();
    } else {
      print('User not signed in');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchDocumentUrls() async {
    try {
      if (widget.fullName == null) {
        print('User ID is null. Cannot fetch documents.');
        setState(() {
          isLoading = false;
        });
        return;
      }

      print('Fetching documents for user ID: $uid');

      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('Provisional Admission Student')
          .child(widget.fullName);

      List<String> documentNames = [
        '10th Marksheet',
        '12th Marksheet',
        'Transfer Certificate',
        'Caste Certificate',
        'Caste Validity',
        'Domicile Certificate',
        'Gap Certificate',
        'Passport Photo',
        'Signature',
      ];

      Map<String, String> fetchedUrls = {};

      for (String docName in documentNames) {
        try {
          ListResult result = await storageRef.child(docName).listAll();
          if (result.items.isNotEmpty) {
            Reference fileRef = result.items.first;
            String url = await fileRef.getDownloadURL();
            fetchedUrls[docName] = url;
            print('Fetched URL for $docName: $url');
          } else {
            print('No files found for $docName');
          }
        } catch (e) {
          print('Error fetching $docName: $e');
        }
      }

      Reference gradRef = storageRef.child('Graduation Marksheet');
      ListResult gradListResult = await gradRef.listAll();

      Map<String, String> graduationUrls = {};

      for (Reference semesterRef in gradListResult.prefixes) {
        try {
          ListResult semesterFiles = await semesterRef.listAll();
          if (semesterFiles.items.isNotEmpty) {
            Reference fileRef = semesterFiles.items.first;
            String url = await fileRef.getDownloadURL();
            graduationUrls[semesterRef.name] = url;
            print('Fetched URL for ${semesterRef.name}: $url');
          } else {
            print('No files found for ${semesterRef.name}');
          }
        } catch (e) {
          print('Error fetching ${semesterRef.name}: $e');
        }
      }

      setState(() {
        documentUrls = fetchedUrls;
        graduationDocumentUrls = graduationUrls;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching document URLs: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  bool _isImage(String url) {
    return url.contains('.jpg') ||
        url.contains('.jpeg') ||
        url.contains('.png') ||
        url.contains('.gif');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        backgroundColor: Colors.purple,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileInfo(),
            const SizedBox(height: 24),
            const Text(
              'Uploaded Documents',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  for (var docName in documentUrls.keys)
                    _buildDocumentRow(docName, documentUrls[docName]!),
                  if (graduationDocumentUrls.isNotEmpty)
                    _buildGraduationMarksheetRow(context),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement download folder functionality if needed
                },
                child: const Text("Download Folder"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Name: ${widget.fullName}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mobile No: ${widget.mobileNumber}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Email: ${widget.email}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Completed Course: ${widget.course}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentRow(String documentName, String documentUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            documentName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_isImage(documentUrl)) {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Image.network(documentUrl),
                  ),
                );
              } else {
                _launchURL(documentUrl);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }

  Widget _buildGraduationMarksheetRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Graduation Marksheet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showGraduationBottomSheet(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }

  void _showGraduationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Graduation Marksheet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...graduationDocumentUrls.keys.map((semesterName) {
                return _buildSemesterDocumentRow(
                    semesterName, graduationDocumentUrls[semesterName]!);
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSemesterDocumentRow(String semesterName, String documentUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            semesterName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_isImage(documentUrl)) {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Image.network(documentUrl),
                  ),
                );
              } else {
                _launchURL(documentUrl);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
    }
  }
}
