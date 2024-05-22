import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:responsi/model/job_model.dart';

class DetailPage extends StatelessWidget {
  final Jobs detail;

  const DetailPage({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          detail.jobTitle ?? 'Character Detail',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () async {
              var box = await Hive.openBox<Jobs>('bookmarks');
              if (!box.values.contains(detail)) {
                box.add(detail);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (detail.companyLogo != null)
                Center(
                  child: Image.network(
                    detail.companyLogo!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 16.0),
              Text('Company Name: ${detail.companyName ?? ''}'),
              Text('Job Title: ${detail.jobTitle ?? ''}'),
              Text('Minimum Salary: ${detail.annualSalaryMin ?? 'N/A'}'),
              Text('Maximum Salary: ${detail.annualSalaryMax ?? 'N/A'}'),
              Text('Job Industry: ${detail.jobIndustry![0]}'),
              Text('Job Description: ${detail.jobExcerpt ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}
