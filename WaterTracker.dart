import 'package:flutter/material.dart';

class waterTracker extends StatefulWidget {
  const waterTracker({super.key});

  @override
  State<waterTracker> createState() => _waterTrackerState();
}

class _waterTrackerState extends State<waterTracker> {
  final TextEditingController _glassTEC=TextEditingController(
    text: "1"
  );
  List<WaterTrack>glasslist=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Water Tracker "), centerTitle: true),
      body: Column(
        children: [
          Text(
           totalglass().toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          Text(
            "Glass's",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 50,
                  child: TextField(
                    controller: _glassTEC,
                    keyboardType:TextInputType.number,
                    textAlign: TextAlign.center,
                  )),

              TextButton(
                onPressed: _addnewtrack,
                child: Text(
                  "Add",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: glasslist.length,

              itemBuilder: (context, index) {
                WaterTrack watertrack=glasslist[index];

                return ListTile(


                  title: Text("${watertrack.dateTime.hour} : ${watertrack.dateTime.minute}"),
                  subtitle: Text("${watertrack.dateTime.day}/${watertrack.dateTime.month}/${watertrack.dateTime.year}"),
                  leading: CircleAvatar(child: Text("${watertrack.noglass}")),
                  trailing: IconButton(
                    onPressed: (){watertrackerdelte(index);},
                    icon: Icon(Icons.delete),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },

            ),
          ),
        ],
      ),
    );
  }
  void _addnewtrack(){
    if(_glassTEC.text.isEmpty)
      {
        _glassTEC.text="1";
      }
    final int noglass=int.tryParse(_glassTEC.text)??1;
    WaterTrack waterTrack =WaterTrack(dateTime: DateTime.now(), noglass: noglass);
    glasslist.add(waterTrack);
    setState(() {

    });

  }
  int totalglass()
  {
    int count=0;
    for(WaterTrack t in glasslist)
      {
        count+=t.noglass;
      }
    return count;
  }
  void watertrackerdelte(int index)
  {

    glasslist.removeAt(index);
    setState(() {

    });
  }
@override
  void dispose() {
    // TODO: implement dispose
    _glassTEC.dispose();
    super.dispose();

  }

}


class WaterTrack
{
  final int noglass;
  final DateTime dateTime;

  WaterTrack({required this.dateTime,required this.noglass});


}
