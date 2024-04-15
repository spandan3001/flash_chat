import 'package:flutter/material.dart';
import 'constants.dart';

class InputMessage extends StatelessWidget {
  const InputMessage(
      {Key? key,
      this.controller,
      required this.onPressed,
      this.onChanged,
      this.onImageSelect})
      : super(key: key);

  final TextEditingController? controller;
  final VoidCallback onPressed;
  final Function(String)? onChanged;
  final VoidCallback? onImageSelect;

  @override
  Widget build(BuildContext context) {
    const baseWidth = 360;
    double w = MediaQuery.sizeOf(context).width;
    double fem = w / baseWidth;
    double fFem = fem * 0.97;
    const sendButtonWidth = 50.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: w - (fem * (sendButtonWidth + 10)),
            constraints: BoxConstraints(
              maxHeight: 100 * fem,
              minHeight: 40 * fem,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(fem * 30),
                color: Colors.white,
                boxShadow: kElevationToShadow[1]),
            child: Row(
              children: [
                SizedBox(width: fem * 15),
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(fontSize: fFem * 15),
                    onChanged: onChanged,
                    maxLines: null,
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onImageSelect,
                  child: Transform.rotate(
                    angle: 0.3,
                    child: SizedBox(
                      width: fem * 40,
                      height: fem * 40,
                      child: const Icon(
                        Icons.attach_file_sharp,
                      ),
                    ),
                  ),
                ),
                // InkWell(
                //   customBorder: const CircleBorder(),
                //   onTap: () {},
                //   child: SizedBox(
                //     width: fem * 40,
                //     height: fem * 40,
                //     child: const Icon(
                //       Icons.currency_rupee,
                //     ),
                //   ),
                // ),
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {},
                  child: SizedBox(
                    width: fem * 40,
                    height: fem * 40,
                    child: const Icon(
                      Icons.camera_alt,
                    ),
                  ),
                ),
                const SizedBox(width: 5)
              ],
            ),
          ),
          SizedBox(
            width: fem * sendButtonWidth,
            height: fem * 50,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              child: const Material(
                color: kPrimaryColor,
                elevation: 1,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
