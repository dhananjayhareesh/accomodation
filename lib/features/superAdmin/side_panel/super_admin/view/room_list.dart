// room_management.dart
// Full, self-contained Room management module for web/desktop.
// Includes: Room model, sample data, RoomListPage, RoomDetailsPage, Edit/Create form.
// Paste into your project and navigate to RoomListPage.

import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/view/edit_room.dart';
import 'package:accomodation_admin/features/superAdmin/side_panel/super_admin/view/room_details.dart';
import 'package:accomodation_admin/widgets/custom_scafold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum RoomType { Room, DormWithBed, DormWithoutBed }

String roomTypeToString(RoomType t) {
  switch (t) {
    case RoomType.Room:
      return "Room";
    case RoomType.DormWithBed:
      return "Dormitory with Bed";
    case RoomType.DormWithoutBed:
      return "Dormitory without Bed";
  }
}

class Tariff {
  double? general;
  double? allotee;
  double? donor;
  double? staff;

  Tariff({this.general, this.allotee, this.donor, this.staff});

  Tariff copy() =>
      Tariff(general: general, allotee: allotee, donor: donor, staff: staff);
}

class RoomModel {
  String id;
  RoomType type;
  String? roomNumber; // For Room and DormWithBed
  String? dormName; // for DormWithoutBed
  int noOfPeople; // occupancy
  String? roomFacility;
  String? occupancyType;
  Tariff tariff;

  RoomModel({
    required this.id,
    required this.type,
    this.roomNumber,
    this.dormName,
    required this.noOfPeople,
    this.roomFacility,
    this.occupancyType,
    Tariff? tariff,
  }) : tariff = tariff ?? Tariff();

  RoomModel copy() => RoomModel(
        id: id,
        type: type,
        roomNumber: roomNumber,
        dormName: dormName,
        noOfPeople: noOfPeople,
        roomFacility: roomFacility,
        occupancyType: occupancyType,
        tariff: tariff.copy(),
      );
}

// ---------- SAMPLE DATA ----------
List<RoomModel> sampleRooms() {
  return [
    RoomModel(
      id: 'R-101',
      type: RoomType.Room,
      roomNumber: '101',
      noOfPeople: 2,
      roomFacility: 'Furnished',
      occupancyType: 'General',
      tariff: Tariff(general: 1200, allotee: 1000, donor: 0, staff: 900),
    ),
    RoomModel(
      id: 'R-102',
      type: RoomType.Room,
      roomNumber: '102',
      noOfPeople: 1,
      roomFacility: 'AC',
      occupancyType: 'General',
      tariff: Tariff(general: 1500, allotee: 1300, donor: 0, staff: 1100),
    ),
    RoomModel(
      id: 'D-1',
      type: RoomType.DormWithBed,
      roomNumber: 'D-1',
      noOfPeople: 1,
      roomFacility: 'Non-AC',
      occupancyType: 'Allotee',
      tariff: Tariff(general: 800, allotee: 700),
    ),
    RoomModel(
      id: 'DR-A',
      type: RoomType.DormWithoutBed,
      dormName: 'Alpha Dorm',
      noOfPeople: 10,
      roomFacility: 'Non-AC',
      occupancyType: 'General',
      tariff: Tariff(general: 90),
    ),
    RoomModel(
      id: 'DR-B',
      type: RoomType.DormWithoutBed,
      dormName: 'Beta Dorm',
      noOfPeople: 8,
      roomFacility: 'Furnished',
      occupancyType: 'Working Staff',
      tariff: Tariff(general: 120),
    ),
  ];
}

// ---------- ROOM LIST PAGE ----------
class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  final List<RoomModel> _rooms = sampleRooms();
  RoomType? _filterType;
  String _search = '';
  final TextEditingController _searchController = TextEditingController();

  // For responsive layout breakpoints
  static const double kTabletBreakpoint = 900;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<RoomModel> get filteredRooms {
    final query = _search.trim().toLowerCase();
    return _rooms.where((r) {
      if (_filterType != null && r.type != _filterType) return false;
      if (query.isEmpty) return true;

      // Search by room number, dormitory name, or id
      final roomNumber = (r.roomNumber ?? '').toLowerCase();
      final dormName = (r.dormName ?? '').toLowerCase();
      final id = r.id.toLowerCase();

      return roomNumber.contains(query) ||
          dormName.contains(query) ||
          id.contains(query);
    }).toList();
  }

  void _openDetails(RoomModel room) async {
    final updated = await Navigator.push<RoomModel>(
      context,
      MaterialPageRoute(
        builder: (_) => RoomDetailsPage(
          room: room.copy(),
          onDelete: () => _deleteRoom(room.id),
          onSave: (edited) {
            _updateRoom(edited);
          },
        ),
      ),
    );

    if (updated != null) {
      // this path won't be used because details pushes edit page itself;
      _updateRoom(updated);
    }
  }

  void _updateRoom(RoomModel edited) {
    final idx = _rooms.indexWhere((r) => r.id == edited.id);
    setState(() {
      if (idx >= 0) {
        _rooms[idx] = edited;
      } else {
        _rooms.add(edited);
      }
    });
  }

  void _deleteRoom(String id) {
    setState(() {
      _rooms.removeWhere((r) => r.id == id);
    });
  }

  void _createNewRoom() async {
    // generate a temporary id
    final newRoom = RoomModel(
      id: 'NEW-${DateTime.now().millisecondsSinceEpoch}',
      type: RoomType.Room,
      noOfPeople: 1,
    );
    final created = await Navigator.push<RoomModel>(
      context,
      MaterialPageRoute(
        builder: (_) => EditRoomPage(
          room: newRoom,
        ),
      ),
    );

    if (created != null) {
      setState(() {
        // assign a nicer id if roomNumber exists
        final niceId =
            (created.roomNumber != null && created.roomNumber!.isNotEmpty)
                ? 'R-${created.roomNumber}'
                : created.id;
        created.id = niceId;
        _rooms.add(created);
      });
    }
  }

  Widget _buildTopBar(double width) {
    final isWide = width >= kTabletBreakpoint;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Expanded(
            flex: isWide ? 2 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Manage Rooms",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "List, filter, search and edit rooms. Desktop/web optimized layout.",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                )
              ],
            ),
          ),

          // Filters and search
          Expanded(
            flex: isWide ? 3 : 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Filter dropdown
                DropdownButton<RoomType?>(
                  value: _filterType,
                  items: [
                    const DropdownMenuItem<RoomType?>(
                      value: null,
                      child: Text('All Types'),
                    ),
                    DropdownMenuItem(
                      value: RoomType.Room,
                      child: Text(roomTypeToString(RoomType.Room)),
                    ),
                    DropdownMenuItem(
                      value: RoomType.DormWithBed,
                      child: Text(roomTypeToString(RoomType.DormWithBed)),
                    ),
                    DropdownMenuItem(
                      value: RoomType.DormWithoutBed,
                      child: Text(roomTypeToString(RoomType.DormWithoutBed)),
                    ),
                  ],
                  onChanged: (v) => setState(() => _filterType = v),
                ),
                const SizedBox(width: 12),

                // Search field
                SizedBox(
                  width: isWide ? 300 : 180,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _search = v),
                    decoration: InputDecoration(
                      hintText: 'Search by room no / dorm name / id',
                      isDense: true,
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _search = '';
                                });
                              },
                            )
                          : const Icon(Icons.search),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRoomCard(RoomModel room, double cardWidth) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openDetails(room),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: cardWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        room.type == RoomType.DormWithoutBed
                            ? (room.dormName ?? 'Dormitory')
                            : (room.roomNumber ?? room.id),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        roomTypeToString(room.type),
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),

                // Details
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  children: [
                    _smallInfoChip('ID', room.id),
                    _smallInfoChip('Occupancy', '${room.noOfPeople}'),
                    if (room.roomFacility != null)
                      _smallInfoChip('Facility', room.roomFacility!),
                    if (room.occupancyType != null)
                      _smallInfoChip('Type', room.occupancyType!),
                    if (room.tariff.general != null)
                      _smallInfoChip('Tariff',
                          '₹${room.tariff.general!.toStringAsFixed(0)}'),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => _openDetails(room),
                      icon: const Icon(Icons.info_outline),
                      label: const Text("Details"),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () async {
                        final edited = await Navigator.push<RoomModel>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditRoomPage(
                              room: room.copy(),
                            ),
                          ),
                        );
                        if (edited != null) {
                          _updateRoom(edited);
                        }
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text("Edit"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _smallInfoChip(String title, String value) {
    return Chip(
      label: Text('$title: $value'),
      visualDensity: VisualDensity.compact,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= kTabletBreakpoint;
    final results = filteredRooms;

    // Determine grid columns for web/desktop
    int crossAxisCount = 1;
    double cardWidth = width;
    if (isWide) {
      crossAxisCount = (width / 320).floor(); // approx 320px per card
      if (crossAxisCount < 2) crossAxisCount = 2;
      if (crossAxisCount > 4) crossAxisCount = 4;
      cardWidth = (width / crossAxisCount) - 36;
    }

    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Rooms Management'),
        elevation: 0,
        backgroundColor: const Color(0xFFFBE4CD),
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTopBar(width),
            const SizedBox(height: 12),
            // result summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${results.length} item(s)',
                  style: const TextStyle(color: Colors.black54),
                ),
                // dummy filter chips or future sort
                Row(
                  children: [
                    const Text('View: '),
                    IconButton(
                      tooltip: 'Refresh (dummy)',
                      onPressed: () => setState(() {}),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),

            // list/grid
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Text(
                        'No rooms match your filters / search.',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    )
                  : LayoutBuilder(builder: (context, constraints) {
                      if (isWide) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.3,
                          ),
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final room = results[index];
                            return _buildRoomCard(room, cardWidth);
                          },
                        );
                      } else {
                        return ListView.separated(
                          itemCount: results.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, idx) {
                            final room = results[idx];
                            return _buildRoomCard(room, constraints.maxWidth);
                          },
                        );
                      }
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
