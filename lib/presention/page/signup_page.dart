import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_demo/data/model/user_model.dart';

import 'package:product_demo/domain/api_helper/userdata_helpetr.dart';
import 'package:product_demo/presention/page/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController textNameController = TextEditingController();
  TextEditingController textAddresController = TextEditingController();
  TextEditingController textPincodeController = TextEditingController();
  TextEditingController textMobailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  final GlobalKey<FormState> singUpFormKey = GlobalKey<FormState>();
  bool isSingUpLoading = false;
  bool isLoginLoader = false;
  bool passwordVisible = false;
  @override
  void initState() {
    getLoginData();
    super.initState();
  }

  void getLoginData() async {
    isLoginLoader = true;
    await UserDataApi.profileData();
    setState(() {});
    isLoginLoader = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                      bottomRight: Radius.circular(150))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('New User',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Registration',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: singUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mobail No'),
                    TextField(
                        controller: textMobailController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone, size: 20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Mobail No.',
                        )),
                    const Text('Password'),
                    TextField(
                        controller: textPasswordController,
                        maxLength: 8,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock, size: 20),
                          suffixIcon: IconButton(
                            onPressed: () {
                              passwordVisible = !passwordVisible;
                              setState(() {});
                            },
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.purple,
                              size: 25,
                            ),
                          ),
                        )),
                    isSingUpLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: MaterialButton(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              onPressed: () async {
                                if (textMobailController.text.isNotEmpty &&
                                    textPasswordController.text.isNotEmpty) {
                                  if (UserDataApi.userDataList.any(
                                    (element) {
                                      return element.mobileNumber ==
                                          textMobailController.text;
                                    },
                                  )) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Already Registered")));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ));
                                  } else {
                                    await UserDataApi.addData(
                                      UserData(
                                        mobileNumber: textMobailController.text,
                                        password: textPasswordController.text,
                                      ),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Registered Succesfully")));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Please fill all details")));
                                }
                              },
                              child: const Text('Sing Up'),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
