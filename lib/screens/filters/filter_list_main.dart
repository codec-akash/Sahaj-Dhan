import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/utils/text_theme.dart';

class FilterNameSelector extends StatefulWidget {
  final List<String> clientsList;
  const FilterNameSelector({
    super.key,
    required this.clientsList,
  });

  @override
  State<FilterNameSelector> createState() => _FilterNameSelectorState();
}

class _FilterNameSelectorState extends State<FilterNameSelector> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];

  void _filterList() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.clientsList.where((item) {
        return item.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void initState() {
    _filteredItems = widget.clientsList;
    _searchController.addListener(_filterList);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterList);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Investors",
          style: TextUtil.titleText,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(_filteredItems[index]);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                  color: Colors.transparent,
                  child: Text(
                    _filteredItems[index],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextUtil.titleText,
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
