// ---------- ROOM DETAILS PAGE ----------
import 'package:accomodation_admin/features/side_panel/super_admin/view/edit_room.dart';
import 'package:accomodation_admin/features/side_panel/super_admin/view/room_list.dart';
import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/material.dart';

class RoomDetailsPage extends StatelessWidget {
  final RoomModel room;
  final VoidCallback? onDelete;
  final ValueChanged<RoomModel>? onSave;

  const RoomDetailsPage({
    super.key,
    required this.room,
    this.onDelete,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    void _openEdit() async {
      final edited = await Navigator.push<RoomModel>(
        context,
        MaterialPageRoute(
          builder: (_) => EditRoomPage(room: room.copy()),
        ),
      );

      if (edited != null) {
        // send back to parent
        onSave?.call(edited);
        Navigator.of(context).pop(edited);
      }
    }

    void _confirmDelete() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Delete Room'),
          content: const Text(
              'Are you sure you want to delete this room? This action cannot be undone.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete')),
          ],
        ),
      );

      if (ok == true) {
        onDelete?.call();
        Navigator.of(context).pop(); // close details
      }
    }

    return CustomScaffold(
      appBar: AppBar(
        title: Text(room.type == RoomType.DormWithoutBed
            ? (room.dormName ?? 'Dormitory')
            : (room.roomNumber ?? room.id)),
        backgroundColor: const Color(0xFFFBE4CD),
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Edit',
            onPressed: _openEdit,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Delete',
            onPressed: _confirmDelete,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomTypeToString(room.type),
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _detailTile('ID', room.id),
                      _detailTile('Occupancy', '${room.noOfPeople}'),
                      _detailTile('Room No', room.roomNumber ?? '-'),
                      _detailTile('Dormitory Name', room.dormName ?? '-'),
                      _detailTile('Facility', room.roomFacility ?? '-'),
                      _detailTile('Occupancy Type', room.occupancyType ?? '-'),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text('Tariff Rates',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _tariffChip('General', room.tariff.general),
                      _tariffChip('Allotee', room.tariff.allotee),
                      _tariffChip('Donor', room.tariff.donor),
                      _tariffChip('Staff', room.tariff.staff),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _openEdit,
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Room'),
                      ),
                      const SizedBox(width: 12),
                      TextButton.icon(
                        onPressed: _confirmDelete,
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Delete'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailTile(String title, String value) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _tariffChip(String label, double? value) {
    return Chip(
      label: Text(
          '$label: ${value == null ? "-" : "₹${value.toStringAsFixed(0)}"}'),
    );
  }
}
