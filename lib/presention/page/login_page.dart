import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_demo/data/model/user_model.dart';
import 'package:product_demo/domain/api_helper/userdata_helpetr.dart';
import 'package:product_demo/presention/page/poduct_list_page.dart';

import 'package:product_demo/presention/page/signUp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  TextEditingController textMobailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool isLoginLoading = false;

  @override
  void initState() {
    getLoginData();
    super.initState();
  }

  void getLoginData() async {
    isLoginLoading = true;
    await UserDataApi.profileData();
    setState(() {});
    isLoginLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: [
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
                Text('Welcome Back',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Login',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Mobail No'),
              TextFormField(
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
                ),
              ),
              const SizedBox(height: 20),
              const Text('Password'),
              TextFormField(
                controller: textPasswordController,
                maxLength: 8,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock, size: 20),
                  suffixIcon: IconButton(
                    onPressed: () {
                      passwordVisible = !passwordVisible;
                      setState(() {});
                    },
                    icon: Icon(
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
              ),
              isLoginLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: MaterialButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onPressed: () async {
                          // await UserDataApi.profileData();
                          for (var ele in UserDataApi.userDataList) {
                            print(ele.toJson());
                          }
                          if (textMobailController.text.isNotEmpty &&
                              textPasswordController.text.isNotEmpty) {
                            if (UserDataApi.userDataList.any((element) =>
                                element.mobileNumber ==
                                textMobailController.text)) {
                              if (UserDataApi.userDataList.any((element) =>
                                      element.password ==
                                      textPasswordController.text) &&
                                  UserDataApi.userDataList.any((element) =>
                                      element.mobileNumber ==
                                      textMobailController.text)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                  'Welcome to App',
                                  style:
                                      TextStyle(backgroundColor: Colors.blue),
                                )));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Your Password is Wrong',
                                      style: TextStyle(
                                          backgroundColor: Colors.red),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                'User Not Found',
                                style: TextStyle(backgroundColor: Colors.red),
                              )));

                              print("User Not Found");
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              'please fill all details',
                              style: TextStyle(backgroundColor: Colors.red),
                            )));
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ));
                  },
                  child: const Text(
                    "Don't have an account? Sign up here",
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
