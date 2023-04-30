import 'dart:async';

import 'package:first_bloc_app/bloc_signin_example/dialog/loading_controller.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  // singleton
  LoadingScreen._sharedInstance();
  static late final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  // to show
  void show({required String text, required BuildContext context}){
    if(_controller?.update(text)??false){
      return;
    }else{
      _controller = showOverLay(context: context, text: text);
    }
  }


  // to Hide
  void hide(){
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController showOverLay({required BuildContext context, required String text}){
    final _text = StreamController<String>();
    _text.add(text);

    // get the size
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width*0.8,
                minWidth: size.width*0.5,
                maxHeight: size.height*0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      StreamBuilder(
                        stream: _text.stream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Text(snapshot.data!, textAlign: TextAlign.center);
                          }else{
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    // Displaying to the screen
    state!.insert(overlay);

    return LoadingScreenController(
      close:(){
        _text.close();
        overlay.remove();
        return true;
      }, 
      update: (text) {
        _text.add(text);
        return true;
      }
    );
  }
}