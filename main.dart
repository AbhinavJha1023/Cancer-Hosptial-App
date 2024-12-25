import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

void main() {
  runApp(const HospitalManagementSystemApp());
}

class HospitalManagementSystemApp extends StatelessWidget {
  const HospitalManagementSystemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Management System',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A73E8),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A73E8),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// Models
class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String diagnosis;
  final String treatmentPlan;
  final double cost;
  final String bloodGroup;
  final String phoneNumber;
  final String address;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.diagnosis,
    required this.treatmentPlan,
    required this.cost,
    required this.bloodGroup,
    required this.phoneNumber,
    required this.address,
  });
}

class Doctor {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String specialization;
  final String qualification;
  final String experience;
  final String phoneNumber;
  final String email;
  final List<String> availableDays;

  Doctor({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.specialization,
    required this.qualification,
    required this.experience,
    required this.phoneNumber,
    required this.email,
    required this.availableDays,
  });
}

class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime dateTime;
  final String status;
  final String notes;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateTime,
    required this.status,
    required this.notes,
  });
}

// Custom Widgets
class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Patient> patients = [];
  final List<Doctor> doctors = [];
  final List<Appointment> appointments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Management'),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              // Toggle theme
            },
          ),
        ],
      ),
      drawer: NavigationDrawer(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1A73E8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.local_hospital, size: 32, color: Color(0xFF1A73E8)),
                ),
                SizedBox(height: 16),
                Text(
                  'Hospital Management',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Admin Panel',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.dashboard),
            label: const Text('Dashboard'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.people),
            label: const Text('Patients'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.medical_services),
            label: const Text('Doctors'),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.calendar_today),
            label: const Text('Appointments'),
          ),
          const Divider(),
          NavigationDrawerDestination(
            icon: const Icon(Icons.settings),
            label: const Text('Settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  DashboardCard(
                    title: 'Add Patient',
                    icon: Icons.person_add,
                    color: Colors.blue,
                    onTap: () => _navigateToScreen(
                      context,
                      AddPatientScreen(patients: patients),
                    ),
                  ),
                  DashboardCard(
                    title: 'View Patients',
                    icon: Icons.people,
                    color: Colors.green,
                    onTap: () => _navigateToScreen(
                      context,
                      ListPatientsScreen(patients: patients),
                    ),
                  ),
                  DashboardCard(
                    title: 'Add Doctor',
                    icon: Icons.person,
                    color: Colors.orange,
                    onTap: () => _navigateToScreen(
                      context,
                      AddDoctorScreen(doctors: doctors),
                    ),
                  ),
                  DashboardCard(
                    title: 'View Doctors',
                    icon: Icons.medical_services,
                    color: Colors.purple,
                    onTap: () => _navigateToScreen(
                      context,
                      ListDoctorsScreen(doctors: doctors),
                    ),
                  ),
                  DashboardCard(
                    title: 'New Appointment',
                    icon: Icons.calendar_today,
                    color: Colors.red,
                    onTap: () => _navigateToScreen(
                      context,
                      AddAppointmentScreen(
                        patients: patients,
                        doctors: doctors,
                        appointments: appointments,
                      ),
                    ),
                  ),
                  DashboardCard(
                    title: 'View Appointments',
                    icon: Icons.calendar_view_day,
                    color: Colors.teal,
                    onTap: () => _navigateToScreen(
                      context,
                      ListAppointmentsScreen(
                        appointments: appointments,
                        patients: patients,
                        doctors: doctors,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToScreen(BuildContext context, Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    setState(() {});
  }
}

// Add Patient Screen
class AddPatientScreen extends StatelessWidget {
  final List<Patient> patients;
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'age': TextEditingController(),
    'gender': TextEditingController(),
    'diagnosis': TextEditingController(),
    'treatmentPlan': TextEditingController(),
    'cost': TextEditingController(),
    'bloodGroup': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'address': TextEditingController(),
  };

  AddPatientScreen({Key? key, required this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Patient')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('Name', controllers['name']!),
                      _buildTextField('Age', controllers['age']!,
                          keyboardType: TextInputType.number),
                      _buildTextField('Gender', controllers['gender']!),
                      _buildTextField('Blood Group', controllers['bloodGroup']!),
                      _buildTextField('Phone Number', controllers['phoneNumber']!,
                          keyboardType: TextInputType.phone),
                      _buildTextField('Address', controllers['address']!,
                          maxLines: 3),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('Diagnosis', controllers['diagnosis']!),
                      _buildTextField('Treatment Plan',
                          controllers['treatmentPlan']!,
                          maxLines: 3),
                      _buildTextField('Cost', controllers['cost']!,
                          keyboardType: TextInputType.number,
                          prefixText: '\$'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _submitForm(context),
                icon: const Icon(Icons.save),
                label: const Text('Save Patient'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType? keyboardType,
        int maxLines = 1,
        String? prefixText,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixText: prefixText,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final patient = Patient(
        id: Random().nextInt(100000).toString(),
        name: controllers['name']!.text,
        age: int.parse(controllers['age']!.text),
        gender: controllers['gender']!.text,
        diagnosis: controllers['diagnosis']!.text,
        treatmentPlan: controllers['treatmentPlan']!.text,
        cost: double.parse(controllers['cost']!.text),
        bloodGroup: controllers['bloodGroup']!.text,
        phoneNumber: controllers['phoneNumber']!.text,
        address: controllers['address']!.text,
      );
      patients.add(patient);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Patient added successfully'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }
}

// Continue with similar improvements for ListPatientsScreen, AddDoctorScreen,
// ListDoctorsScreen, AddAppointmentScreen, and ListAppointmentsScreen...
// List Patients Screen
class ListPatientsScreen extends StatelessWidget {
  final List<Patient> patients;

  const ListPatientsScreen({Key? key, required this.patients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PatientSearchDelegate(patients),
              );
            },
          ),
        ],
      ),
      body: patients.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No patients available',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPatientScreen(patients: patients),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Patient'),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  patient.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(patient.name),
              subtitle: Text(
                'Age: ${patient.age} • Gender: ${patient.gender}\n'
                    'Blood Group: ${patient.bloodGroup}',
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view',
                    child: Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 8),
                        Text('View Details'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case 'view':
                      _showPatientDetails(context, patient);
                      break;
                    case 'edit':
                    // TODO: Implement edit functionality
                      break;
                    case 'delete':
                      _deletePatient(context, index);
                      break;
                  }
                },
              ),
              onTap: () => _showPatientDetails(context, patient),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPatientScreen(patients: patients),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showPatientDetails(BuildContext context, Patient patient) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Text(
                'Patient Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Divider(),
              _buildDetailRow('Name', patient.name),
              _buildDetailRow('Age', '${patient.age} years'),
              _buildDetailRow('Gender', patient.gender),
              _buildDetailRow('Blood Group', patient.bloodGroup),
              _buildDetailRow('Phone', patient.phoneNumber),
              _buildDetailRow('Address', patient.address),
              const SizedBox(height: 16),
              Text(
                'Medical Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(),
              _buildDetailRow('Diagnosis', patient.diagnosis),
              _buildDetailRow('Treatment Plan', patient.treatmentPlan),
              _buildDetailRow('Cost', '\$${patient.cost.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _deletePatient(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Patient'),
        content: const Text(
          'Are you sure you want to delete this patient? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              patients.removeAt(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Patient deleted'),
                  backgroundColor: Colors.red,
                ),
              );
              (context as Element).markNeedsBuild();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientSearchDelegate extends SearchDelegate {
  final List<Patient> patients;

  PatientSearchDelegate(this.patients);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = patients.where((patient) {
      return patient.name.toLowerCase().contains(query.toLowerCase()) ||
          patient.phoneNumber.contains(query) ||
          patient.id.contains(query);
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final patient = results[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(patient.name[0]),
          ),
          title: Text(patient.name),
          subtitle: Text('ID: ${patient.id} • Phone: ${patient.phoneNumber}'),
          onTap: () {
            close(context, patient);
          },
        );
      },
    );
  }
}

// Add Doctor Screen
class AddDoctorScreen extends StatelessWidget {
  final List<Doctor> doctors;
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'age': TextEditingController(),
    'gender': TextEditingController(),
    'specialization': TextEditingController(),
    'qualification': TextEditingController(),
    'experience': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'email': TextEditingController(),
  };

  final List<String> availableDays = [];

  AddDoctorScreen({Key? key, required this.doctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Doctor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('Name', controllers['name']!),
                      _buildTextField('Age', controllers['age']!,
                          keyboardType: TextInputType.number),
                      _buildTextField('Gender', controllers['gender']!),
                      _buildTextField('Phone Number', controllers['phoneNumber']!,
                          keyboardType: TextInputType.phone),
                      _buildTextField('Email', controllers['email']!,
                          keyboardType: TextInputType.emailAddress),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Professional Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('Specialization',
                          controllers['specialization']!),
                      _buildTextField('Qualification',
                          controllers['qualification']!),
                      _buildTextField('Experience (years)',
                          controllers['experience']!,
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 16),
                      Text(
                        'Available Days',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      _buildDaySelector(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _submitForm(context),
                icon: const Icon(Icons.save),
                label: const Text('Save Doctor'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        TextInputType? keyboardType,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDaySelector() {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: days.map((day) {
        return FilterChip(
          label: Text(day),
          selected: availableDays.contains(day),
          onSelected: (selected) {
            if (selected) {
              availableDays.add(day);
            } else {
              availableDays.remove(day);
            }
          },
        );
      }).toList(),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (availableDays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one available day'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final doctor = Doctor(
        id: Random().nextInt(100000).toString(),
        name: controllers['name']!.text,
        age: int.parse(controllers['age']!.text),
        gender: controllers['gender']!.text,
        specialization: controllers['specialization']!.text,
        qualification: controllers['qualification']!.text,
        experience: controllers['experience']!.text,
        phoneNumber: controllers['phoneNumber']!.text,
        email: controllers['email']!.text,
        availableDays: List.from(availableDays),
      );

      doctors.add(doctor);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doctor added successfully'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }
}

// Rest of the screens (ListDoctorsScreen, AddAppointmentScreen,
// ListAppointmentsScreen) would follow similar patterns of enhancement...
// List Doctors Screen
class ListDoctorsScreen extends StatelessWidget {
  final List<Doctor> doctors;

  const ListDoctorsScreen({Key? key, required this.doctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DoctorSearchDelegate(doctors),
              );
            },
          ),
        ],
      ),
      body: doctors.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No doctors available',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDoctorScreen(doctors: doctors),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Doctor'),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  doctor.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(doctor.name),
              subtitle: Text(
                'Specialization: ${doctor.specialization}\n'
                    'Experience: ${doctor.experience} years',
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Qualification', doctor.qualification),
                      _buildInfoRow('Phone', doctor.phoneNumber),
                      _buildInfoRow('Email', doctor.email),
                      const SizedBox(height: 8),
                      const Text(
                        'Available Days:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 8,
                        children: doctor.availableDays
                            .map((day) => Chip(label: Text(day)))
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit'),
                            onPressed: () {
                              // TODO: Implement edit functionality
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                            onPressed: () => _deleteDoctor(context, index),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDoctorScreen(doctors: doctors),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _deleteDoctor(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Doctor'),
        content: const Text(
          'Are you sure you want to delete this doctor? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              doctors.removeAt(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Doctor deleted'),
                  backgroundColor: Colors.red,
                ),
              );
              (context as Element).markNeedsBuild();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// Add Appointment Screen
class AddAppointmentScreen extends StatefulWidget {
  final List<Patient> patients;
  final List<Doctor> doctors;
  final List<Appointment> appointments;

  const AddAppointmentScreen({
    Key? key,
    required this.patients,
    required this.doctors,
    required this.appointments,
  }) : super(key: key);

  @override
  _AddAppointmentScreenState createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedPatientId;
  String? selectedDoctorId;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Appointment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appointment Details',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Patient',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedPatientId,
                        items: widget.patients.map((patient) {
                          return DropdownMenuItem(
                            value: patient.id,
                            child: Text(patient.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPatientId = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a patient';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Doctor',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedDoctorId,
                        items: widget.doctors.map((doctor) {
                          return DropdownMenuItem(
                            value: doctor.id,
                            child: Text('Dr. ${doctor.name} (${doctor.specialization})'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDoctorId = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a doctor';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Select Date',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            selectedDate == null
                                ? 'Select Date'
                                : DateFormat('MMM dd, yyyy').format(selectedDate!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _selectTime(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Select Time',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            selectedTime == null
                                ? 'Select Time'
                                : selectedTime!.format(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: notesController,
                        decoration: const InputDecoration(
                          labelText: 'Notes',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.save),
                label: const Text('Schedule Appointment'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a date'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a time'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final DateTime appointmentDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      final appointment = Appointment(
        id: Random().nextInt(100000).toString(),
        patientId: selectedPatientId!,
        doctorId: selectedDoctorId!,
        dateTime: appointmentDateTime,
        status: 'Scheduled',
        notes: notesController.text,
      );

      widget.appointments.add(appointment);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment scheduled successfully'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }
}

// List Appointments Screen
class ListAppointmentsScreen extends StatelessWidget {
  final List<Appointment> appointments;
  final List<Patient> patients;
  final List<Doctor> doctors;

  const ListAppointmentsScreen({
    Key? key,
    required this.appointments,
    required this.patients,
    required this.doctors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Today'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAppointmentsList(
              context,
              appointments.where((apt) =>
                  apt.dateTime.isAfter(DateTime.now().add(const Duration(days: 1)))).toList(),
            ),
            _buildAppointmentsList(
              context,
              appointments.where((apt) =>
              apt.dateTime.day == DateTime.now().day &&
                  apt.dateTime.month == DateTime.now().month &&
                  apt.dateTime.year == DateTime.now().year).toList(),
            ),
            _buildAppointmentsList(
              context,
              appointments.where((apt) =>
                  apt.dateTime.isBefore(DateTime.now())).toList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAppointmentScreen(
                  patients: patients,
                  doctors: doctors,
                  appointments: appointments,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildAppointmentsList(BuildContext context, List<Appointment> filteredAppointments) {
    if (filteredAppointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No appointments found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        final patient = patients.firstWhere((p) => p.id == appointment.patientId);
        final doctor = doctors.firstWhere((d) => d.id == appointment.doctorId);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(appointment.status),
              child: Icon(
                _getStatusIcon(appointment.status),
                color: Colors.white,
              ),
            ),
            title: Text('${patient.name} with Dr. ${doctor.name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(appointment.dateTime),
                ),
                Text(
                  'Status: ${appointment.status}',
                  style: TextStyle(
                    color: _getStatusColor(appointment.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: Row(
                    children: [
                      Icon(Icons.visibility),
                      SizedBox(width: 8),
                      Text('View Details'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'cancel',
                  child: Row(
                    children: [
                      Icon(Icons.cancel),
                      SizedBox(width: 8),
                      Text('Cancel'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'view':
                    _showAppointmentDetails(context, appointment, patient, doctor);
                    break;
                  case 'edit':
                  // TODO: Implement edit functionality
                    break;
                  case 'cancel':
                    _cancelAppointment(context, appointment);
                    break;
                }
              },
            ),
            onTap: () => _showAppointmentDetails(context, appointment, patient, doctor),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'in progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Icons.event;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'in progress':
        return Icons.timeline;
      default:
        return Icons.event_busy;
    }
  }

  void _showAppointmentDetails(
      BuildContext context,
      Appointment appointment,
      Patient patient,
      Doctor doctor,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Text(
                'Appointment Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Divider(),
              _buildDetailRow('Date & Time',
                  DateFormat('MMMM dd, yyyy \'at\' hh:mm a').format(appointment.dateTime)),
              _buildDetailRow('Status', appointment.status),
              _buildDetailRow('Patient Name', patient.name),
              _buildDetailRow('Patient Phone', patient.phoneNumber),
              _buildDetailRow('Doctor Name', 'Dr. ${doctor.name}'),
              _buildDetailRow('Specialization', doctor.specialization),
              _buildDetailRow('Doctor Phone', doctor.phoneNumber),
              if (appointment.notes.isNotEmpty)
                _buildDetailRow('Notes', appointment.notes),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement reschedule functionality
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Reschedule'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _cancelAppointment(context, appointment);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _cancelAppointment(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text(
          'Are you sure you want to cancel this appointment? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, Keep It'),
          ),
          TextButton(
            onPressed: () {
              final index = appointments.indexWhere((a) => a.id == appointment.id);
              if (index != -1) {
                appointments[index] = Appointment(
                  id: appointment.id,
                  patientId: appointment.patientId,
                  doctorId: appointment.doctorId,
                  dateTime: appointment.dateTime,
                  status: 'Cancelled',
                  notes: appointment.notes,
                );
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
              (context as Element).markNeedsBuild();
            },
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorSearchDelegate extends SearchDelegate {
  final List<Doctor> doctors;

  DoctorSearchDelegate(this.doctors);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
          doctor.specialization.toLowerCase().contains(query.toLowerCase()) ||
          doctor.phoneNumber.contains(query) ||
          doctor.email.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final doctor = results[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(doctor.name[0]),
          ),
          title: Text('Dr. ${doctor.name}'),
          subtitle: Text('${doctor.specialization}\n${doctor.email}'),
          isThreeLine: true,
          onTap: () {
            close(context, doctor);
          },
        );
      },
    );
  }
}