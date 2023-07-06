import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/utils/utils.dart';

class AuthWidgets {
  ElevatedButton continueButton(
    BuildContext context, {
    required void Function()? onPressed,
    isLogin = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        shadowColor: Colors.black,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        fixedSize: Size(sW(context) / 2, 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(isLogin ? "Login" : "Register"),
    );
  }

  ElevatedButton verifyButton(BuildContext context, {isContinue = true}) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shadowColor: Colors.black,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          fixedSize: Size(isContinue ? sW(context) / 1.5 : sW(context) / 2, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("verifying"),
            spaceWidth(15),
            const CupertinoActivityIndicator(
              color: Colors.white,
            )
          ],
        ));
  }

  TextFormField field(
      {required cntr,
      required txt,
      isNumber = false,
      required ic,
      Function()? onTap}) {
    return TextFormField(
      onTap: onTap,
      readOnly: false,
      controller: cntr,
      validator: (value) {
        if (value!.isEmpty) {
          return "*required";
        } else {
          return null;
        }
      },
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(fontSize: 11),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        labelText: txt,
        errorStyle: const TextStyle(
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(fontSize: 11, color: Colors.grey),
        suffixIcon: Icon(
          ic,
          size: 20,
          color: Colors.grey,
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
