import 'package:chat_z/base.dart';
import 'package:chat_z/models/category.dart';
import 'package:chat_z/screens/add_room/add_room_Naviagator.dart';
import 'package:chat_z/screens/add_room/add_room_ViewModel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../styles/colors.dart';

class Add_Screen_View extends StatefulWidget {
  const Add_Screen_View({Key? key}) : super(key: key);
  static const String routeName = 'addScreenView';

  @override
  State<Add_Screen_View> createState() => _Add_Screen_ViewState();
}

class _Add_Screen_ViewState extends BaseView<Add_Screen_View, AddRoomViewModel>
    implements AddRoomNavigator {
  var descriptionController = TextEditingController();
  var titleController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var categories = RoomCategory.getCategories();
  late RoomCategory selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    selectedCategory = categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Image.asset(
          Assets.imagesBackground,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              MediaQuery.of(context).size.height * 0.10,
            ),
            child: AppBar(
              // toolbarHeight: MediaQuery.of(context).size.height * 0.30,
              title: Text(
                ' Chat App',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 22,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.transparent)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              "Create New Room",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Image.asset(Assets.imagesGroup),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value.trim() == '') {
                                  return 'Please Enter Room Title';
                                }
                                return null;
                              },
                              controller: titleController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'room title',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: CHATCOLOR),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: CHATCOLOR),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: DropdownButton<RoomCategory>(
                                borderRadius: BorderRadius.circular(15),
                                style: Theme.of(context).textTheme.subtitle1,
                                value: selectedCategory,
                                items: categories
                                    .map(
                                      (e) => DropdownMenuItem<RoomCategory>(
                                        value: e,
                                        child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image.asset(e.image),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*.45,
                                            ),
                                            Text(e.name)
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (category) {
                                  if(category==null){
                                    return;
                                  }else {
                                    selectedCategory = category;
                                    setState(() {

                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value.trim() == '') {
                                  return 'Please Enter Room Description';
                                }
                                return null;
                              },
                              controller: descriptionController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: CHATCOLOR),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: CHATCOLOR),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .08,
                              child: ElevatedButton(
                                  onPressed: () {
                                    roomValidate();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            CHATCOLOR),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Create Room ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      Icon(Icons.double_arrow),
                                    ],
                                  )),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  void roomValidate() {
    if (formKey.currentState!.validate()) {
viewModel.AddRoomToFirestor(titleController.text, descriptionController.text, selectedCategory.id);
    }
  }

  @override
  void RoomCreated() {
    Navigator.pop(context);
  }
}
