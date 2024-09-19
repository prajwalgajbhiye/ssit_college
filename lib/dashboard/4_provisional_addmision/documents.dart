import 'dart:io';
import 'dart:ui'; // Needed for ImageFilter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import "package:path/path.dart" as path;

import '../user_selection_screen.dart';

class DocumentUploadPage extends StatefulWidget {
  final String userName;
  final String userMobile;
  final String userEmail;

  const DocumentUploadPage({super.key,
    required this.userName,
    required this.userMobile,
    required this.userEmail,
  });

  @override
  _DocumentUploadPageState createState() => _DocumentUploadPageState();
}

class DocumentStatus {
  File? file;
  String? errorMessage;

  DocumentStatus({this.file, this.errorMessage});
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  Map<String, DocumentStatus> uploadedDocuments = {
    '10th Marksheet': DocumentStatus(),
    '12th Marksheet': DocumentStatus(),
    'Transfer Certificate': DocumentStatus(),
    'Caste Certificate': DocumentStatus(),
    'Caste Validity': DocumentStatus(),
    'Domicile Certificate': DocumentStatus(),
    'Gap Certificate': DocumentStatus(),
    'Passport Photo': DocumentStatus(),
    'Signature': DocumentStatus(),
  };

  bool _isSubmitting = false;
  double _totalBytes = 0;
  double _bytesTransferred = 0;
  double _previousFilesBytesTransferred = 0;

  String? graduationPattern;
  Map<String, DocumentStatus> graduationDocuments = {};

  // Keep track of ongoing upload tasks
  List<UploadTask> _uploadTasks = [];

  // Function to pick documents using file picker
  Future<void> pickDocument(String docType, {bool isGraduation = false}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      // Get file size
      int fileSize = await file.length();

      // Check if file size is less than 1 MB (1 MB = 1,048,576 bytes)
      if (fileSize > 1048576) {
        setState(() {
          if (isGraduation) {
            graduationDocuments[docType]?.file = null;
            graduationDocuments[docType]?.errorMessage =
            'File size must be less than 1 MB.';
          } else {
            uploadedDocuments[docType]?.file = null;
            uploadedDocuments[docType]?.errorMessage =
            'File size must be less than 1 MB.';
          }
        });
        return;
      }

      // Check if file type is allowed
      String extension = path.extension(file.path).toLowerCase();
      if (!['.jpg', '.jpeg', '.png', '.pdf'].contains(extension)) {
        setState(() {
          if (isGraduation) {
            graduationDocuments[docType]?.file = null;
            graduationDocuments[docType]?.errorMessage =
            'Only image and PDF files are allowed.';
          } else {
            uploadedDocuments[docType]?.file = null;
            uploadedDocuments[docType]?.errorMessage =
            'Only image and PDF files are allowed.';
          }
        });
        return;
      }

      setState(() {
        if (isGraduation) {
          graduationDocuments[docType]?.file = file;
          graduationDocuments[docType]?.errorMessage = null;
        } else {
          uploadedDocuments[docType]?.file = file;
          uploadedDocuments[docType]?.errorMessage = null;
        }
      });
    }
  }

  // Function to calculate total bytes of all files
  Future<void> calculateTotalBytes() async {
    _totalBytes = 0;
    for (DocumentStatus docStatus in uploadedDocuments.values) {
      if (docStatus.file != null) {
        int size = await docStatus.file!.length();
        _totalBytes += size.toDouble();
      }
    }
    for (DocumentStatus docStatus in graduationDocuments.values) {
      if (docStatus.file != null) {
        int size = await docStatus.file!.length();
        _totalBytes += size.toDouble();
      }
    }
  }

  // Function to submit documents and upload them to Firebase Storage
  Future<void> submitDocuments(BuildContext context) async {
    try {
      setState(() {
        _isSubmitting = true;
      });

      await calculateTotalBytes();
      _bytesTransferred = 0;
      _previousFilesBytesTransferred = 0;

      // Show alert dialog with progress indicator
      StateSetter? dialogSetState;

      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: 'Uploading Documents',
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                dialogSetState = setState;
                return Center(
                  child: AlertDialog(
                    title: const Text('Uploading Documents'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LinearProgressIndicator(
                          value: _totalBytes > 0
                              ? _bytesTransferred / _totalBytes
                              : null,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${(_bytesTransferred / (1024 * 1024)).toStringAsFixed(2)} MB of ${(_totalBytes / (1024 * 1024)).toStringAsFixed(2)} MB uploaded',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );

      // Create a reference to Firebase Storage inside a student-specific folder
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('Provisional Admission Student')
          .child(widget.userName);

      // Upload regular documents
      for (String docType in uploadedDocuments.keys) {
        if (uploadedDocuments[docType]?.file != null) {
          File file = uploadedDocuments[docType]!.file!;
          String fileName = file.path.split('/').last;

          int fileSize = await file.length();

          String fileExtension = fileName.split('.').last;
          String mimeType = getMimeType(fileExtension);

          // Upload file to Firebase Storage
          Reference docRef = storageRef.child('$docType/$fileName');
          UploadTask uploadTask = docRef.putFile(
            file,
            SettableMetadata(contentType: mimeType),
          );

          _uploadTasks.add(uploadTask);

          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            if (dialogSetState != null) {
              dialogSetState!(() {
                double bytesTransferred = snapshot.bytesTransferred.toDouble();
                _bytesTransferred =
                    _previousFilesBytesTransferred + bytesTransferred;
              });
            }
          });

          await uploadTask;
          _uploadTasks.remove(uploadTask);
          _previousFilesBytesTransferred += fileSize.toDouble();
        }
      }

      // Upload graduation documents
      for (String docType in graduationDocuments.keys) {
        if (graduationDocuments[docType]?.file != null) {
          File file = graduationDocuments[docType]!.file!;
          String fileName = file.path.split('/').last;

          int fileSize = await file.length();

          String fileExtension = fileName.split('.').last;
          String mimeType = getMimeType(fileExtension);

          String folderName;
          if (graduationPattern == 'Semester') {
            folderName = docType.replaceAll(' Marksheet', '');
          } else if (graduationPattern == 'Yearly') {
            folderName = docType.replaceAll(' Marksheet', '');
          } else {
            folderName = docType;
          }

          Reference docRef =
          storageRef.child('Graduation Marksheet/$folderName/$fileName');
          UploadTask uploadTask = docRef.putFile(
            file,
            SettableMetadata(contentType: mimeType),
          );

          _uploadTasks.add(uploadTask);

          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            if (dialogSetState != null) {
              dialogSetState!(() {
                double bytesTransferred = snapshot.bytesTransferred.toDouble();
                _bytesTransferred =
                    _previousFilesBytesTransferred + bytesTransferred;
              });
            }
          });

          await uploadTask;
          _uploadTasks.remove(uploadTask);
          _previousFilesBytesTransferred += fileSize.toDouble();
        }
      }

      Navigator.of(context).pop();

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Success'),
            content: const Text('Your documents have been uploaded successfully.'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const UserSelectionScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading documents: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
        _uploadTasks.clear();
      });
    }
  }

  String getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  void selectGraduationPattern() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.timeline),
                title: const Text('Semester Pattern'),
                onTap: () {
                  setState(() {
                    graduationPattern = 'Semester';
                    graduationDocuments = {
                      '1st Semester Marksheet': DocumentStatus(),
                      '2nd Semester Marksheet': DocumentStatus(),
                      '3rd Semester Marksheet': DocumentStatus(),
                      '4th Semester Marksheet': DocumentStatus(),
                      '5th Semester Marksheet': DocumentStatus(),
                      '6th Semester Marksheet': DocumentStatus(),
                    };
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_view_day),
                title: const Text('Yearly Pattern'),
                onTap: () {
                  setState(() {
                    graduationPattern = 'Yearly';
                    graduationDocuments = {
                      '1st Year Marksheet': DocumentStatus(),
                      '2nd Year Marksheet': DocumentStatus(),
                      '3rd Year Marksheet': DocumentStatus(),
                    };
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
          onWillPop: () async {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => const UserSelectionScreen()),
                  (Route<dynamic> route) => false,
            );
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Upload Your Documents'),
              backgroundColor: Colors.white,
              elevation: 1,
              foregroundColor: Colors.black,
            ),
            backgroundColor: Colors.grey[100],
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Complete your admission process by uploading the required documents.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        ...uploadedDocuments.keys.map((docType) {
                          DocumentStatus docStatus =
                          uploadedDocuments[docType]!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  docStatus.file != null
                                      ? Icons.check_circle
                                      : Icons.insert_drive_file,
                                  color: docStatus.file != null
                                      ? Colors.green
                                      : Colors.blueGrey,
                                ),
                                title: Text(
                                  docType,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  docStatus.errorMessage ??
                                      (docStatus.file != null
                                          ? "Selected: ${docStatus.file!.path.split('/').last}"
                                          : 'No document selected'),
                                  style: TextStyle(
                                    color: docStatus.errorMessage != null
                                        ? Colors.red
                                        : Colors.grey[600],
                                  ),
                                ),
                                trailing: TextButton(
                                  onPressed: () => pickDocument(docType),
                                  child: const Text(
                                    'Select',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ExpansionTile(
                              leading: Icon(
                                graduationDocuments.values.any(
                                        (docStatus) => docStatus.file != null)
                                    ? Icons.check_circle
                                    : Icons.insert_drive_file,
                                color: graduationDocuments.values.any(
                                        (docStatus) => docStatus.file != null)
                                    ? Colors.green
                                    : Colors.blueGrey,
                              ),
                              title: const Text(
                                'Graduation Marksheet',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                graduationPattern != null
                                    ? '$graduationPattern Pattern Selected'
                                    : 'No pattern selected',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              children: [
                                if (graduationPattern == null)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ElevatedButton(
                                      onPressed: selectGraduationPattern,
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: Colors.blue,
                                      ),
                                      child: const Text('Select Pattern'),
                                    ),
                                  )
                                else ...graduationDocuments.keys.map((docType) {
                                  DocumentStatus docStatus =
                                  graduationDocuments[docType]!;
                                  return ListTile(
                                    leading: Icon(
                                      docStatus.file != null
                                          ? Icons.check_circle
                                          : Icons.insert_drive_file,
                                      color: docStatus.file != null
                                          ? Colors.green
                                          : Colors.blueGrey,
                                    ),
                                    title: Text(
                                      docType,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      docStatus.errorMessage ??
                                          (docStatus.file != null
                                              ? "Selected: ${docStatus.file!.path.split('/').last}"
                                              : 'No document selected'),
                                      style: TextStyle(
                                        color: docStatus.errorMessage != null
                                            ? Colors.red
                                            : Colors.grey[600],
                                      ),
                                    ),
                                    trailing: TextButton(
                                      onPressed: () => pickDocument(docType,
                                          isGraduation: true),
                                      child: const Text(
                                        'Select',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: ElevatedButton(
                                    onPressed: selectGraduationPattern,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
                                    ),
                                    child: const Text('Change Pattern'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                      _isSubmitting ? null : () => submitDocuments(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        ),
                      )
                          : const Text('Submit Documents'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        if (_isSubmitting)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
      ],
    );
  }
}
