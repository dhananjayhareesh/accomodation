// ---------- ROOM DETAILS PAGE (Responsive & Professional) ----------
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete')),
          ],
        ),
      );

      if (ok == true) {
        onDelete?.call();
        Navigator.of(context).pop();
      }
    }

    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          room.type == RoomType.DormWithoutBed
              ? (room.dormName ?? 'Dormitory')
              : (room.roomNumber ?? room.id),
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFFBE4CD),
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            tooltip: 'Edit',
            onPressed: _openEdit,
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.black,
            ),
          ),
          IconButton(
            tooltip: 'Delete',
            onPressed: _confirmDelete,
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 800;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Room Type Header
                          Text(
                            roomTypeToString(room.type),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.black54),
                          ),
                          const SizedBox(height: 20),

                          // ------- Room Details -------
                          Text("Room Information",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),

                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: isWide ? 3 : 1,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: isWide ? 3.5 : 4,
                            children: [
                              _detailTile('ID', room.id),
                              _detailTile('Occupancy', '${room.noOfPeople}'),
                              _detailTile('Room No', room.roomNumber ?? '-'),
                              _detailTile(
                                  'Dormitory Name', room.dormName ?? '-'),
                              _detailTile('Facility', room.roomFacility ?? '-'),
                              _detailTile(
                                  'Occupancy Type', room.occupancyType ?? '-'),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // ------- Tariff Section -------
                          Text("Tariff Rates",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),

                          Table(
                            border: TableBorder.all(
                                color: Colors.grey.shade300, width: 1),
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(3),
                            },
                            children: [
                              _tariffRow('General', room.tariff.general),
                              _tariffRow('Allotee', room.tariff.allotee),
                              _tariffRow('Donor', room.tariff.donor),
                              _tariffRow('Staff', room.tariff.staff),
                            ],
                          ),

                          const SizedBox(height: 40),
                          const Divider(),
                          const SizedBox(height: 20),

                          // ------- Action Buttons -------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton.icon(
                                onPressed: _confirmDelete,
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.redAccent),
                                label: const Text("Delete",
                                    style: TextStyle(color: Colors.redAccent)),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: _openEdit,
                                icon: const Icon(Icons.edit),
                                label: const Text("Edit Room"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _detailTile(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  TableRow _tariffRow(String label, double? value) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black87)),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(value == null ? "-" : "₹${value.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}
