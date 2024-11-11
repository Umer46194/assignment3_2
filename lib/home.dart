import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures & Drag and Drop',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _dragOffset = Offset.zero;
  Color _paintedColor = Colors.green;

  void _updateDragDetails(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  // Draggable widget for changing color
  Draggable<int> _buildColorDraggable() {
    return Draggable<int>(
      data: Colors.deepOrange.value,
      feedback: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.palette,
          color: Colors.white,
          size: 30,
        ),
      ),
      childWhenDragging: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.palette,
          color: Colors.white70,
          size: 30,
        ),
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.palette,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  // Draggable widget for alarm icon (additional draggable)
  Draggable<String> _buildAlarmDraggable() {
    return Draggable<String>(
      data: 'alarm',
      feedback: Icon(
        Icons.alarm,
        color: Colors.blue.withOpacity(0.7),
        size: 80,
      ),
      childWhenDragging: Icon(
        Icons.alarm,
        color: Colors.grey,
        size: 80,
      ),
      child: Icon(
        Icons.alarm,
        color: Colors.blue,
        size: 80,
      ),
    );
  }

  // DragTarget widget to change color
  DragTarget<int> _buildColorDragTarget() {
    return DragTarget<int>(
      onAccept: (colorValue) {
        setState(() {
          _paintedColor = Color(colorValue);
        });
      },
      builder: (BuildContext context, List<int?> acceptedData, List<dynamic> rejectedData) {
        return GestureDetector(
          onPanUpdate: _updateDragDetails,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: _paintedColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Text(
              'Drop Color Here',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  // DragTarget widget for other draggable items (e.g., alarm)
  DragTarget<String> _buildAlarmDragTarget() {
    return DragTarget<String>(
      onAccept: (data) {
        // Handle alarm drop if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alarm icon dropped!')),
        );
      },
      builder: (BuildContext context, List<String?> acceptedData, List<dynamic> rejectedData) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.yellow[100],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Text(
            'Drop Alarm Here',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  // Combined DragTargets with layout
  Widget _buildDragTargets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildColorDragTarget(),
        SizedBox(height: 40),
        _buildAlarmDragTarget(),
      ],
    );
  }

  // Display drag offset information
  Widget _buildDragInfo() {
    return Text(
      'onPanUpdate:\nDragUpdateDetails(${_dragOffset.dx.toStringAsFixed(1)}, ${_dragOffset.dy.toStringAsFixed(1)})',
      style: TextStyle(fontSize: 16.0),
      textAlign: TextAlign.center,
    );
  }

  // Layout for draggable widgets
  Widget _buildDraggables() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildColorDraggable(),
        SizedBox(height: 20),
        _buildAlarmDraggable(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestures & Drag and Drop"),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildDragInfo(),
                  SizedBox(height: 20),
                  _buildDraggables(),
                  SizedBox(height: 40),
                  Divider(color: Colors.black, height: 44.0),
                  _buildDragTargets(),
                  Divider(color: Colors.black, height: 44.0),
                  // You can add more widgets here if needed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
