import 'package:anix/C/AuthController.dart';
import 'package:flutter/material.dart';

import 'SignInScreen.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({super.key});

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  final AuthController _authController = AuthController();
  String _ownerName = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOwnerData();
  }

  Future<void> _fetchOwnerData() async {
    final userData = await _authController.getCurrentUserData();
    if (userData != null && mounted) {
      setState(() {
        _ownerName = userData['name'] ?? 'Owner'; // Fallback to 'Owner'
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() {
        _ownerName = 'Owner'; // Use fallback if data fails to load
        _isLoading = false;
      });
    }
  }

  Future<void> _signOut() async {
    await _authController.signOut();
    if (mounted) {
      // Navigate to the SignInScreen and remove all previous screens
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4834D4),
        elevation: 0, // Makes the AppBar flat for a modern look
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'OWNER DASHBOARD',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            // We use the _ownerName state variable you are already fetching
            Text(
              _ownerName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out', // Improves accessibility on web/desktop
            onPressed: _signOut,
          ),
        ],
      ),

      backgroundColor: Colors.grey[100],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
        length: 2, // The number of tabs
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // This Sliver contains the content that scrolls above the tabs
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, $_ownerName!',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildProjectShowcase(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // This Sliver makes the TabBar sticky
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    labelColor: Color(0xFF6C63FF),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Color(0xFF6C63FF),
                    tabs: [
                      Tab(icon: Icon(Icons.construction), text: "Ongoing Sites"),
                      Tab(icon: Icon(Icons.check_circle), text: "Completed Sites"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              // Content for the "Ongoing Sites" tab
              _buildSiteList(status: 'Ongoing'),
              // Content for the "Completed Sites" tab
              _buildSiteList(status: 'Completed'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the horizontal image scroll showcase
  Widget _buildProjectShowcase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Completed Projects Showcase',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Temporary number of items
            itemBuilder: (context, index) {
              // Temporary colored containers
              final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple];
              return Card(
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: colors[index % colors.length].withOpacity(0.7),
                  ),
                  child: Center(child: Text('Project ${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Placeholder widget for the content of each tab
  Widget _buildSiteList({required String status}) {
    // Later, this will be a list of projects fetched from Firestore
    return Center(
      child: Text(
        '$status Sites List',
        style: const TextStyle(fontSize: 20, color: Colors.grey),
      ),
    );
  }
}

// This helper class is needed to make the TabBar sticky
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[100], // Or your preferred background color
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}