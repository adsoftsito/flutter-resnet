import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'package:resnet/design/Design.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:rflutter_alert/rflutter_alert.dart';


class ResnetScreen extends StatefulWidget {
  static String routeName = 'ResnetScreen';

  @override
  _ResnetScreenState createState() => _ResnetScreenState();
}

class _ResnetScreenState extends State<ResnetScreen> {

  @override
  void initState() {
    super.initState();
  }

  File? _image;

  String? _path_img;

  final url = Uri.parse("https://your-resnet-service.cloud.okteto.net/v1/models/resnet:predict");
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  Future getImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null ) return;

      //final imageTemporary = File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);

      _path_img = image.path;


      setState(() {
        this._image = imagePermanent;


      });
    }on PlatformException catch (e){
      print("Falló al obtener recursos de las imagenes: $e");
    }
  }

  Future<File> saveFilePermanently(String imagePath) async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/${name}');


    return File(imagePath).copy(image.path);
  }




  Future<void> uploadImage() async {

    File file = File(_path_img!);
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);


    showDialog(
        context:  this.context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        }
    );

    try {

      final prediction_instance = {
        "instances" : [
          {
            "b64": "$fileInBase64"
          }
        ]
      };

      final res = await http.post(url, headers: headers, body: jsonEncode(prediction_instance));
      //print(jsonEncode(prediction_instance));


      if (res.statusCode == 200) {
        Navigator.pop(this.context);
        final json_prediction = jsonDecode(res.body);

        String clases_prediction = json_prediction['predictions'][0]['classes'].toString();

        final value = await rootBundle.loadString('assets/json/index.json');
        var datos = json.decode(value);
        var class_result_prediction = datos[clases_prediction.toString()][1];
        var result_prediction = datos[clases_prediction.toString()];


        Alert(
          context: this.context,
          type: AlertType.success,
          title: "¡Operación exitosa!",
          desc: "ID:$clases_prediction\nResultado: $class_result_prediction",
          buttons: [
            DialogButton(
              child: Text(
                "Confirmar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(this.context),
              color: Color(0xFF02B1FF),
              width: 120,
            )
          ],
        ).show();

      }else{
        Navigator.pop(this.context);
        Alert(
          context: this.context,
          type: AlertType.error,
          title: "Error",
          desc: "Ocurrió un error al mandar la imagen",
          buttons: [
            DialogButton(
              child: Text(
                "Confirmar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(this.context),
              color: Color(0xFF02B1FF),
              width: 120,
            )
          ],
        ).show();

      }

    } catch (e) {
      Navigator.pop(this.context);
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(

        floatingActionButton:  Visibility(
          visible:  _path_img != null ,
          child: FloatingActionButton(
            child: Icon(Icons.send_outlined, color: Colors.white,),
            foregroundColor: Color(0xFF02B1FF),
            onPressed: () {
              uploadImage();
            },
          ),

        ),


        body: Column(
          children: [

            Container(
              width: 100.w,
              height: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Resnet',
                          style: Theme.of(context).textTheme.bodyLarge),
                      sizedBox,
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: kOtherColor,

                  borderRadius: kTopBorderRadius,
                ),
                child:
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 50,),

                      SizedBox(height: 60,),
                      _image != null ? Image.file(_image!, width: 300, height: 400, fit: BoxFit.cover,) :
                      Image.asset('assets/images/take_photo.gif'),
                      SizedBox(height: 20,),

                      ElevatedButton.icon(
                        onPressed: (){
                          setState(() {
                            getImage(ImageSource.camera);
                          });
                        },
                        icon: Icon(Icons.camera_alt_outlined),
                        label: Text('Cámara'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF02B1FF)),
                            padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 14, color: Colors.white)
                            )
                        ),
                      ),

                      SizedBox(height: 20,),

                      ElevatedButton.icon(
                        onPressed: (){
                          setState(() {
                          getImage(ImageSource.gallery);
                          });
                        },
                        icon: Icon(Icons.attach_file_sharp),
                        label: Text('Galeria'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF02B1FF)),
                            padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 14, color: Colors.white)
                            )
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
