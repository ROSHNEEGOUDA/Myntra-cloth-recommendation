import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FashionForm extends StatefulWidget {
  static const routeName = '/fashion-form';

  @override
  _FashionFormState createState() => _FashionFormState();
}

class _FashionFormState extends State<FashionForm> {
  final _formKey = GlobalKey<FormState>();

  int age = 30;
  String gender = 'Female';
  String bodyType = 'Rectangle';
  String preferredStyle = 'Formal';
  String colorPreferences = 'Blue';
  String necklineType = 'V-neck';
  String sleeveType = 'Full-sleeve';
  String material = 'Cotton';
  String fitType = 'Regular';
  String occasion = 'Party';

  bool isLoading = false;
  String? recommendedDress;
  List<String> dressImageUrls = [];

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
      recommendedDress = null;
      dressImageUrls = [];
    });

    final apiUrl = 'http://127.0.0.1:5000/predict';

    final Map<String, dynamic> requestData = {
      "Age": age,
      "Gender": gender,
      "Body_Type": bodyType,
      "Preferred_Style": preferredStyle,
      "Color_Preferences": colorPreferences,
      "Neckline_Type": necklineType,
      "Sleeve_Type": sleeveType,
      "Material": material,
      "Fit_Type": fitType,
      "Occasion": occasion,
      "Trend_Score": 80,
      "Weather_Preference": "Winter",
      "Social_Media_Trend_Score": 88
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          recommendedDress = responseData["Recommended_Dress"];
        });

        fetchDressImages(recommendedDress!);
      } else {
        setState(() {
          recommendedDress = "Error: ${responseData["error"]}";
        });
      }
    } catch (error) {
      setState(() {
        recommendedDress = "Failed to connect to API!";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchDressImages(String dressId) async {
    final apiUrl = 'http://127.0.0.1:5000/recommendations';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final List<dynamic> dresses = jsonDecode(response.body);

      List<String> images = [];
      for (var dress in dresses) {
        if (dress["dress_id"] == dressId) {
          images.add(dress["image_path"]);
        }
      }

      setState(() {
        dressImageUrls = images;
      });
    } catch (error) {
      print("Error fetching images: $error");
    }
  }

  Widget buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text("Fashion Recommendation"),
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent.shade100, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Only show the form if there are no results yet
                if (recommendedDress == null) ...[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildDropdown(
                          label: "Gender",
                          value: gender,
                          items: ["Male", "Female"],
                          onChanged: (value) => setState(() => gender = value!),
                        ),
                        buildDropdown(
                          label: "Body Type",
                          value: bodyType,
                          items: ["Rectangle", "Hourglass", "Pear"],
                          onChanged: (value) =>
                              setState(() => bodyType = value!),
                        ),
                        buildDropdown(
                          label: "Preferred Style",
                          value: preferredStyle,
                          items: ["Casual", "Formal", "Party"],
                          onChanged: (value) =>
                              setState(() => preferredStyle = value!),
                        ),
                        buildDropdown(
                          label: "Color Preferences",
                          value: colorPreferences,
                          items: ["Blue", "Green"],
                          onChanged: (value) =>
                              setState(() => colorPreferences = value!),
                        ),
                        buildDropdown(
                          label: "Neckline Type",
                          value: necklineType,
                          items: ["V-neck", "Round-neck", "Square-neck"],
                          onChanged: (value) =>
                              setState(() => necklineType = value!),
                        ),
                        buildDropdown(
                          label: "Sleeve Type",
                          value: sleeveType,
                          items: ["Full-sleeve", "Half-sleeve", "Sleeveless"],
                          onChanged: (value) =>
                              setState(() => sleeveType = value!),
                        ),
                        buildDropdown(
                          label: "Material",
                          value: material,
                          items: ["Cotton", "Silk"],
                          onChanged: (value) =>
                              setState(() => material = value!),
                        ),
                        buildDropdown(
                          label: "Fit Type",
                          value: fitType,
                          items: ["Regular", "Slim", "Loose"],
                          onChanged: (value) =>
                              setState(() => fitType = value!),
                        ),
                        buildDropdown(
                          label: "Occasion",
                          value: occasion,
                          items: ["Formal", "Casual", "Party"],
                          onChanged: (value) =>
                              setState(() => occasion = value!),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Age",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: age.toString(),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() => age = int.tryParse(value) ?? 30);
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: submitForm,
                                child: Text("Get Recommendations"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 20),
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ] else ...[
                  SizedBox(height: 20),
                  Text("Recommended Dress: $recommendedDress",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  if (dressImageUrls.isNotEmpty) ...[
                    SizedBox(height: 20),
                    Text("Matching Dresses:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: dressImageUrls.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            dressImageUrls[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Text("Loading"));
                            },
                          ),
                        );
                      },
                    )
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        recommendedDress = null;
                        dressImageUrls = [];
                      });
                    },
                    child: Text("Try Again"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
