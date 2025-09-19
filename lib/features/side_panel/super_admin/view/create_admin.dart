import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';

class CreateAdminPage extends StatefulWidget {
  const CreateAdminPage({super.key});

  @override
  State<CreateAdminPage> createState() => _CreateAdminPageState();
}

class _CreateAdminPageState extends State<CreateAdminPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  // State for checkboxes
  final Map<String, bool> _powers = {
    'Allocation': false,
    'Vacation': false,
    'Maintenance': false,
    'Extension': false,
    'Reports': false,
    'User Management': false,
    'Settings': false,
  };

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _nameController.dispose();
    _phoneController.dispose();
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _createAdmin() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      final name = _nameController.text;
      final phone = _phoneController.text;
      final userId = _userIdController.text;
      final password = _passwordController.text;
      final assignedPowers =
          _powers.entries.where((e) => e.value).map((e) => e.key).toList();

      // You can now use this data to send to your backend, database, etc.
      print('Creating Admin:');
      print('Name: $name');
      print('Phone: $phone');
      print('UserID: $userId');
      print('Password: $password');
      print('Powers: $assignedPowers');

      // Show a confirmation snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New admin created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the new CustomScaffold and pass the page content to the body
    return CustomScaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Create New Admin',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF382D1E)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fill out the form below to add a new administrator.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 32),
                      _buildTextFormField(
                        controller: _nameController,
                        labelText: 'Full Name',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
                      _buildTextFormField(
                        controller: _phoneController,
                        labelText: 'Phone Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),
                      _buildTextFormField(
                        controller: _userIdController,
                        labelText: 'User ID',
                        icon: Icons.alternate_email,
                      ),
                      const SizedBox(height: 20),
                      _buildPasswordFormField(),
                      const SizedBox(height: 32),
                      Text(
                        'Assign Powers',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF382D1E)),
                      ),
                      const SizedBox(height: 16),
                      _buildPowersCheckboxes(),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createAdmin,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: const Color(0xFF382D1E),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Create Admin',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  Widget _buildPowersCheckboxes() {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: _powers.keys.map((String key) {
        return IntrinsicWidth(
          child: CheckboxListTile(
            title: Text(key),
            value: _powers[key],
            onChanged: (bool? value) {
              setState(() {
                _powers[key] = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: const Color(0xFF382D1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        );
      }).toList(),
    );
  }
}
