class RecentFile {
  final String? icon, name, checkInDate, room;

  RecentFile({this.icon, this.name, this.checkInDate, this.room});
}

List demoRecentFiles = [
  RecentFile(
    icon: "assets/icons/xd_file.svg",
    name: "Ramesh Kumar",
    checkInDate: "01-03-2021",
    room: "Room 101",
  ),
  RecentFile(
    icon: "assets/icons/Figma_file.svg",
    name: "Sita Devi",
    checkInDate: "27-02-2021",
    room: "Room 205",
  ),
  RecentFile(
    icon: "assets/icons/doc_file.svg",
    name: "Anil Sharma",
    checkInDate: "23-02-2021",
    room: "Dorm A - Bed 3",
  ),
  RecentFile(
    icon: "assets/icons/sound_file.svg",
    name: "Meena Gupta",
    checkInDate: "21-02-2021",
    room: "Room 305",
  ),
  RecentFile(
    icon: "assets/icons/media_file.svg",
    name: "Rajesh Patel",
    checkInDate: "23-02-2021",
    room: "Room 404",
  ),
  RecentFile(
    icon: "assets/icons/pdf_file.svg",
    name: "Priya Singh",
    checkInDate: "25-02-2021",
    room: "Dorm B - Bed 1",
  ),
  RecentFile(
    icon: "assets/icons/excel_file.svg",
    name: "Arun Kumar",
    checkInDate: "25-02-2021",
    room: "Room 110",
  ),
];
