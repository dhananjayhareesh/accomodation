import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/model/admin_list_model.dart';
import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';

class AdminDetailsPage extends StatefulWidget {
  final AdminModel admin;

  const AdminDetailsPage({
    super.key,
    required this.admin,
  });

  @override
  State<AdminDetailsPage> createState() => _AdminDetailsPageState();
}

class _AdminDetailsPageState extends State<AdminDetailsPage> {
  late TextEditingController _nameController;
  late TextEditingController _userIdController;
  late TextEditingController _phoneController;
  final _passwordController = TextEditingController();

  late Map<String, bool> _editablePowers;
  bool _isEditMode = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the current admin's data
    _nameController = TextEditingController(text: widget.admin.name);
    _userIdController = TextEditingController(text: widget.admin.userId);
    _phoneController = TextEditingController(text: widget.admin.phone);

    // Initialize the map for checkbox states
    _editablePowers = {
      'Allocation': widget.admin.powers.contains('Allocation'),
      'Vacation': widget.admin.powers.contains('Vacation'),
      'Maintenance': widget.admin.powers.contains('Maintenance'),
      'Extension': widget.admin.powers.contains('Extension'),
      'Reports': widget.admin.powers.contains('Reports'),
      'User Management': widget.admin.powers.contains('User Management'),
      'Settings': widget.admin.powers.contains('Settings'),
    };
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userIdController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
      // If canceling edit, reset changes
      if (!_isEditMode) {
        _resetForm();
      }
    });
  }

  void _saveChanges() {
    // In a real app, you would send this data to your backend/API
    final updatedName = _nameController.text;
    final updatedPowers = _editablePowers.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    print('Saving changes...');
    print('Updated Name: $updatedName');
    print('New Password (if provided): ${_passwordController.text}');
    print('Updated Powers: $updatedPowers');

    // Show a confirmation snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Admin details updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Exit edit mode
    _toggleEditMode();
  }

  void _resetForm() {
    _nameController.text = widget.admin.name;
    _userIdController.text = widget.admin.userId;
    _phoneController.text = widget.admin.phone;
    _passwordController.clear();
    setState(() {
      _editablePowers = {
        'Allocation': widget.admin.powers.contains('Allocation'),
        'Vacation': widget.admin.powers.contains('Vacation'),
        'Maintenance': widget.admin.powers.contains('Maintenance'),
        'Extension': widget.admin.powers.contains('Extension'),
        'Reports': widget.admin.powers.contains('Reports'),
        'User Management': widget.admin.powers.contains('User Management'),
        'Settings': widget.admin.powers.contains('Settings'),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Admin' : widget.admin.name),
        backgroundColor: const Color(0xFF382D1E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditMode ? Icons.close : Icons.edit),
            onPressed: _toggleEditMode,
            tooltip: _isEditMode ? 'Cancel' : 'Edit Admin',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Name', _nameController),
                    _buildDetailRow('User ID', _userIdController,
                        enabled: false), // User ID is not editable
                    _buildDetailRow('Phone', _phoneController),
                    if (_isEditMode) _buildPasswordFormField(),
                    const SizedBox(height: 24.0),
                    Text(
                      'Assigned Powers',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF382D1E),
                          ),
                    ),
                    const SizedBox(height: 12.0),
                    _buildPowersSection(),
                    if (_isEditMode) const SizedBox(height: 32.0),
                    if (_isEditMode)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.save_alt_outlined),
                          label: const Text('Save Changes'),
                          onPressed: _saveChanges,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: const Color(0xFF382D1E),
                            foregroundColor: Colors.white,
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
    );
  }

  Widget _buildDetailRow(String title, TextEditingController controller,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        controller: controller,
        enabled: _isEditMode && enabled,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: enabled ? Colors.black : Colors.grey[700],
        ),
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          border: _isEditMode
              ? OutlineInputBorder(borderRadius: BorderRadius.circular(8))
              : InputBorder.none,
          filled: _isEditMode && enabled,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildPasswordFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: 'New Password (optional)',
          hintText: 'Leave blank to keep current password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[100],
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
      ),
    );
  }

  Widget _buildPowersSection() {
    return Wrap(
      spacing: 8.0,
      runSpacing: _isEditMode ? 0 : 8.0,
      children: _editablePowers.keys.map((String key) {
        if (_isEditMode) {
          return SizedBox(
            width: 250, // Constrain width in edit mode
            child: CheckboxListTile(
              title: Text(key),
              value: _editablePowers[key],
              onChanged: (bool? value) {
                setState(() {
                  _editablePowers[key] = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeColor: const Color(0xFF382D1E),
            ),
          );
        } else {
          // Only show the chip if the power is assigned
          if (_editablePowers[key]!) {
            return Chip(
              label: Text(key),
              backgroundColor: const Color(0xFFFBE4CD).withOpacity(0.5),
              side: const BorderSide(
                color: Color(0xFF382D1E),
              ),
            );
          } else {
            return const SizedBox.shrink(); // Hide if not assigned
          }
        }
      }).toList(),
    );
  }
}
