import 'package:flutter/material.dart';

void main() {
  runApp(const TunasApp());
}

// Shared Top Header
AppBar buildTunasHeader(
  BuildContext context,
  String title,
  void Function(int) onTabChange,
) {
  return AppBar(
    title: Row(
      children: [
        const Icon(Icons.eco, color: Colors.green, size: 28),
        const SizedBox(width: 8),
        Text(
          'TUNAS',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications_none),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.notifications, color: Color(0xFFFF5722)),
                  SizedBox(width: 8),
                  Text('Notifications'),
                ],
              ),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Dr. Lim Wei Chen accepted your mentor request!'),
                  SizedBox(height: 8),
                  Text('• Sime Darby Challenge closing soon (30 Apr 2026).'),
                  SizedBox(height: 8),
                  Text('• New Huawei TVET AI Module unlocked.'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Dismiss'),
                ),
              ],
            ),
          );
        },
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: GestureDetector(
          onTap: () => onTabChange(3),
          child: const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFFF5722),
            child: Text(
              'XY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class TunasApp extends StatelessWidget {
  const TunasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUNAS - Malaysia AI Innovators',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5722),
          primary: const Color(0xFFFF5722),
          secondary: const Color(0xFF1E88E5),
          surface: const Color(0xFFF8F9FA),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 1,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _navigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DiscoverScreen(onNavigate: _navigateToTab),
      DevelopScreen(onNavigate: _navigateToTab),
      ConnectScreen(onNavigate: _navigateToTab),
      GrowScreen(onNavigate: _navigateToTab),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _navigateToTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search, color: Color(0xFFFF5722)),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book, color: Color(0xFFFF5722)),
            label: 'Develop',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people, color: Color(0xFFFF5722)),
            label: 'Connect',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up_outlined),
            selectedIcon: Icon(Icons.trending_up, color: Color(0xFFFF5722)),
            label: 'Grow',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. DISCOVER SCREEN
// ==========================================
class DiscoverScreen extends StatefulWidget {
  final void Function(int) onNavigate;
  const DiscoverScreen({super.key, required this.onNavigate});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _selectedFilter = 'All';

  final List<dynamic> _allTalents = [
    {
      'name': 'Aqil Rahman',
      'school': 'SM Sains Banting',
      'category': 'STEM',
      'tags': ['AI', 'Environment'],
      'avatarColor': Colors.blue,
      'bio': 'Developing AI models for weather forecasting and crop yield optimizations.',
    },
    {
      'name': 'Xin Yee',
      'school': 'SMK Seri Puteri',
      'category': 'Competitions',
      'tags': ['Robotics', 'Health'],
      'avatarColor': Colors.purple,
      'bio': 'Winner of the National Youth Robotics Challenge. Focused on AI in Healthcare.',
    },
    {
      'name': 'David Li',
      'school': 'SMK Kota Kemuning',
      'category': 'Schools',
      'tags': ['App Development', 'Community'],
      'avatarColor': Colors.orange,
      'bio': 'Created a community app connecting high school students with local volunteer work.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTalents = _selectedFilter == 'All'
        ? _allTalents
        : _allTalents.where((t) {
            final tags = t['tags'] as List;
            return t['category'] == _selectedFilter ||
                tags.contains(_selectedFilter);
          }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: buildTunasHeader(context, "Discover Talents", widget.onNavigate),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search students, schools or ideas...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.tune),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['All', 'Schools', 'Competitions', 'STEM'].map((
                filter,
              ) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selectedColor: const Color(0xFFFF5722),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured Young Talents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedFilter = 'All';
                  });
                },
                child: const Text('Show All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...filteredTalents.map((talent) => _buildTalentCard(context, talent)),
        ],
      ),
    );
  }

  Widget _buildTalentCard(BuildContext context, dynamic talent) {
    final tags = talent['tags'] as List;
    final Color avatarColor = talent['avatarColor'];

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: avatarColor.withOpacity(0.2),
          child: Text(
            talent['name'][0],
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: avatarColor,
            ),
          ),
        ),
        title: Text(
          talent['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(talent['school'], style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              children: tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag.toString(),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(talent['name']),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'School: ${talent['school']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(talent['bio']),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    widget.onNavigate(2);
                  },
                  child: const Text('Find Mentors for Project'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 2. DEVELOP SCREEN
// ==========================================
class DevelopScreen extends StatelessWidget {
  final void Function(int) onNavigate;
  const DevelopScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: buildTunasHeader(context, "My Learning Journey", onNavigate),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI Learning Pathway Recommended For You',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '1. Python AI Foundation (Completed)\n'
                        '2. Computer Vision with ModelArts (In Progress - 70%)\n'
                        '3. Edge Computing with IoT Devices (Upcoming)\n'
                        '4. National Pitch Readiness (Upcoming)',
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Continue Current Module'),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.blue.shade500],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology, size: 48, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'AI Learning Path',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Personalised learning journey based on your interests',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Learning Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => onNavigate(3),
                child: const Text('View All Stats >'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildProgressCard(context, 'AI & Data Literacy', 0.70, Colors.blue),
          _buildProgressCard(
            context,
            'Project Management',
            0.45,
            Colors.orange,
          ),
          _buildProgressCard(
            context,
            'Communication Skills',
            0.30,
            Colors.green,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended for You',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All available modules displayed.'),
                    ),
                  );
                },
                child: const Text('See All >'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildCourseCard(
                  context,
                  'HUAWEI TVET AI Program',
                  'Huawei Cloud',
                  Colors.red.shade100,
                  Icons.cloud,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCourseCard(
                  context,
                  'Design Thinking for Students',
                  '8 Lessons',
                  Colors.amber.shade100,
                  Icons.lightbulb,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
    BuildContext context,
    String title,
    double progress,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text(
              'Current Progress: ${(progress * 100).toInt()}%\n'
              'Next lesson: Real-world Model Evaluation.\n'
              'Estimated time remaining: 45 minutes.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Resuming lesson: $title')),
                  );
                },
                child: const Text('Resume Lesson'),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    String title,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text(
              'Partner / Provider: $subtitle\n\n'
              'Gain hands-on certification, real-world case studies, and cloud credits.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enrolled in $title!')),
                  );
                },
                child: const Text('Enroll Now'),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. CONNECT SCREEN
// ==========================================
class ConnectScreen extends StatefulWidget {
  final void Function(int) onNavigate;
  const ConnectScreen({super.key, required this.onNavigate});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  int _activeCategory = 0; // 0 = Mentors, 1 = Programmes, 2 = Partners
  final Map<String, bool> _connectedStatus = {};

  final List<dynamic> _mentors = [
    {
      'name': 'Dr. Lim Wei Chen',
      'role': 'AI Researcher, MMU',
      'tags': ['AI', 'Research'],
      'institution': 'Multimedia University (MMU)',
      'expertise': 'Deep Learning, Computer Vision, Smart Agriculture',
    },
    {
      'name': 'Pn. Aisyah Rahman',
      'role': 'Innovation Coach, MOE',
      'tags': ['Tech', 'Cloud', 'Product'],
      'institution': 'Ministry of Education (MOE)',
      'expertise': 'STEM curriculum integration, competition mentoring',
    },
    {
      'name': 'Irfan Hakim',
      'role': 'Cloud Architect, Huawei',
      'tags': ['Cloud', 'ModelArts', 'Edge AI'],
      'institution': 'Huawei Technologies Malaysia',
      'expertise': 'Enterprise AI infrastructure and edge model deployments',
    },
  ];

  final List<dynamic> _programmes = [
    {
      'title': 'AI Sandbox Talent Accelerator',
      'host': 'MDEC & MRANTI',
      'desc': '6-month incubation for secondary school innovation projects.',
    },
    {
      'title': 'National AI Sparks Bootcamp',
      'host': 'AI Nasional Bhd & MOHE',
      'desc':
          'Specialized training for pre-university candidates and finalists.',
    },
  ];

  final List<dynamic> _partners = [
    {
      'name': 'Huawei Cloud Malaysia',
      'type': 'Technology & Cloud Partner',
      'offering': 'Hosting, AI ModelArts, developer certifications',
    },
    {
      'name': 'Ministry of Science, Tech & Innovation (MOSTI)',
      'type': 'Government Agency',
      'offering': 'Grant facilitation and national showcase endorsements',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: buildTunasHeader(
          context,
          "Find Mentors & Opportunities",
          widget.onNavigate,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Expanded(
                child: _activeCategory == 0
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5722),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Mentors'),
                      )
                    : OutlinedButton(
                        onPressed: () => setState(() => _activeCategory = 0),
                        child: const Text('Mentors'),
                      ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _activeCategory == 1
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5722),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Programmes'),
                      )
                    : OutlinedButton(
                        onPressed: () => setState(() => _activeCategory = 1),
                        child: const Text('Programmes'),
                      ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _activeCategory == 2
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5722),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Partners'),
                      )
                    : OutlinedButton(
                        onPressed: () => setState(() => _activeCategory = 2),
                        child: const Text('Partners'),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_activeCategory == 0) ...[
            ..._mentors.map((m) => _buildMentorTile(m)),
          ] else if (_activeCategory == 1) ...[
            ..._programmes.map((p) => _buildProgrammeTile(p)),
          ] else ...[
            ..._partners.map((pt) => _buildPartnerTile(pt)),
          ],
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Challenge Board',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => _showAllChallengesModal(context),
                child: const Text('See All >'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildChallengeCard(
            title: 'Sime Darby Young Innovators Challenge',
            closingDate: 'Closing Date: 30 Apr 2026',
            color: Colors.green.shade100,
          ),
          _buildChallengeCard(
            title: 'MOSTI Science Innovator Challenge',
            closingDate: 'Closing Date: 15 May 2026',
            color: Colors.blue.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildMentorTile(dynamic mentor) {
    final String name = mentor['name'];
    final String role = mentor['role'];
    final tags = mentor['tags'] as List;
    final bool isConnected = _connectedStatus[name] ?? false;

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _showMentorDetailsModal(mentor),
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  name[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _showMentorDetailsModal(mentor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      role,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      children: tags
                          .map(
                            (t) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                t.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _connectedStatus[name] = !isConnected;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isConnected
                          ? 'Connection cancelled'
                          : 'Connection request sent to $name!',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isConnected
                    ? Colors.grey
                    : const Color(0xFFFF5722),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(isConnected ? 'Pending' : 'Connect'),
            ),
          ],
        ),
      ),
    );
  }

  void _showMentorDetailsModal(dynamic mentor) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(mentor['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Affiliation: ${mentor['institution']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Expertise: ${mentor['expertise']}'),
            const SizedBox(height: 8),
            const Text(
              'Verified Mentor under the National TUNAS AI Talent Framework.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Back'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _connectedStatus[mentor['name']] = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Request sent to ${mentor['name']}')),
              );
            },
            child: const Text('Request Mentorship Session'),
          ),
        ],
      ),
    );
  }

  Widget _buildProgrammeTile(dynamic prog) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFFECE5),
          child: Icon(Icons.rocket_launch, color: Color(0xFFFF5722)),
        ),
        title: Text(
          prog['title'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text('${prog['host']}\n${prog['desc']}'),
        trailing: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(prog['title']),
                content: Text(
                  'Organized by: ${prog['host']}\n\n'
                  'Your student profile (Xin Yee) meets the eligibility criteria.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Applied for ${prog['title']}!'),
                        ),
                      );
                    },
                    child: const Text('Submit Application'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Apply'),
        ),
      ),
    );
  }

  Widget _buildPartnerTile(dynamic partner) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.business, color: Colors.white),
        ),
        title: Text(
          partner['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text('${partner['type']}\n${partner['offering']}'),
        trailing: OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Opening portal for ${partner['name']}')),
            );
          },
          child: const Text('Portal'),
        ),
      ),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String closingDate,
    required Color color,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.emoji_events, color: Colors.black87),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(closingDate, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          _showChallengeRegisterDialog(title, closingDate);
        },
      ),
    );
  }

  void _showChallengeRegisterDialog(String title, String closingDate) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(
          '$closingDate\n\n'
          'Submit your AI project pitch to participate in this national level competition.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registration submitted successfully!'),
                ),
              );
            },
            child: const Text('Register Idea'),
          ),
        ],
      ),
    );
  }

  void _showAllChallengesModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'National AI Challenges (2026)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildChallengeCard(
              title: 'Sime Darby Young Innovators Challenge',
              closingDate: 'Closing: 30 Apr 2026',
              color: Colors.green.shade100,
            ),
            _buildChallengeCard(
              title: 'MOSTI Science Innovator Challenge',
              closingDate: 'Closing: 15 May 2026',
              color: Colors.blue.shade100,
            ),
            _buildChallengeCard(
              title: 'Samsung Solve for Tomorrow Malaysia',
              closingDate: 'Closing: 10 Jun 2026',
              color: Colors.amber.shade100,
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. GROW SCREEN
// ==========================================
class GrowScreen extends StatefulWidget {
  final void Function(int) onNavigate;
  const GrowScreen({super.key, required this.onNavigate});

  @override
  State<GrowScreen> createState() => _GrowScreenState();
}

class _GrowScreenState extends State<GrowScreen> {
  int _activeGrowthTab = 0; // 0 = Skills, 1 = Activities, 2 = Opportunities

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: buildTunasHeader(context, "My Progress", widget.onNavigate),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFFF5722),
                  child: Text(
                    'XY',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Xin Yee',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'SM Sains Banting • Form 4',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => _showFullPortfolioProfile(context),
                  child: const Text('View Profile >'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildGrowthSubTab(0, 'Skills'),
              _buildGrowthSubTab(1, 'Activities'),
              _buildGrowthSubTab(2, 'Opportunities'),
            ],
          ),
          const Divider(height: 24),
          if (_activeGrowthTab == 0) ...[
            const Text(
              'Skill Growth (Last 6 Months)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInteractiveSkillBar('AI', 0.8, Colors.blue),
                  _buildInteractiveSkillBar('Creativity', 0.6, Colors.purple),
                  _buildInteractiveSkillBar('Leadership', 0.7, Colors.orange),
                  _buildInteractiveSkillBar('Communication', 0.5, Colors.green),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Certs and Badges Obtained',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => _showAllBadgesModal(context),
                  child: const Text('See All >'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildBadgeTile(
              context,
              title: 'Huawei AI Explorer Certificate',
              date: 'Issued: Mar 2026',
              color: Colors.red.shade100,
              icon: Icons.workspace_premium,
            ),
            _buildBadgeTile(
              context,
              title: 'National AI Challenge Participant',
              date: 'Issued: Jan 2026',
              color: Colors.blue.shade100,
              icon: Icons.verified,
            ),
            _buildBadgeTile(
              context,
              title: 'Python for AI Fundamentals',
              date: 'Issued: Dec 2025',
              color: Colors.amber.shade100,
              icon: Icons.code,
            ),
          ] else if (_activeGrowthTab == 1) ...[
            const Text(
              'Recent Innovation Activities',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildActivityItem(
              'Pitch Presentation Submitted',
              'Sime Darby Challenge',
              '2 days ago',
            ),
            _buildActivityItem(
              'Completed Module 4',
              'Huawei TVET Cloud AI',
              '1 week ago',
            ),
            _buildActivityItem(
              'Joined Mentor Session',
              'Dr. Lim Wei Chen',
              '2 weeks ago',
            ),
          ] else ...[
            const Text(
              'Matched University & Career Pathways',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildOpportunityItem(
              'MMU AI Foundation Scholarship',
              'Fast-track entrance for National AI Challenge finalists.',
            ),
            _buildOpportunityItem(
              'Huawei Cloud Apprentice Program',
              'Internship & cloud lab access for secondary innovators.',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGrowthSubTab(int index, String label) {
    final bool isSelected = _activeGrowthTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeGrowthTab = index;
        });
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFFFF5722) : Colors.grey,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFF5722),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInteractiveSkillBar(
    String label,
    double fillPercent,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('$label Skill Breakdown'),
            content: Text(
              'Proficiency Score: ${(fillPercent * 100).toInt()}/100\n\n'
              'Verified via TUNAS continuous learning logs and challenge assessments.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 14,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              Container(
                width: 14,
                height: 80 * fillPercent,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildBadgeTile(
    BuildContext context, {
    required String title,
    required String date,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.black87, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(date, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(
                '$date\n\n'
                'Verified Digital Credential issued under the National AI Education Roadmap. '
                'Verifiable ID: TUNAS-2026-MY-${title.hashCode.abs().toString().substring(0, 5)}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Certificate downloaded to device!'),
                      ),
                    );
                  },
                  child: const Text('Download PDF'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildOpportunityItem(String title, String desc) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.school, color: Color(0xFFFF5722)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
        trailing: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Details for $title requested!')),
            );
          },
          child: const Text('Explore'),
        ),
      ),
    );
  }

  void _showFullPortfolioProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (_, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFFF5722),
                    child: Text(
                      'XY',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Xin Yee',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'SM Sains Banting • Form 4 Innovator',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Divider(height: 32),
            const Text(
              'National AI Innovation Portfolio',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Xin Yee has built healthcare AI robotics solutions, winning 1st place in the 2025 Selangor Youth Tech Summit.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Accredited Mentors',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              '• Dr. Lim Wei Chen (MMU AI Research)\n• Pn. Aisyah Rahman (MOE)',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
                foregroundColor: Colors.white,
              ),
              child: const Text('Close Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllBadgesModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verified Credentials Repository',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBadgeTile(
              context,
              title: 'Huawei AI Explorer Certificate',
              date: 'Issued: Mar 2026',
              color: Colors.red.shade100,
              icon: Icons.workspace_premium,
            ),
            _buildBadgeTile(
              context,
              title: 'National AI Challenge Participant',
              date: 'Issued: Jan 2026',
              color: Colors.blue.shade100,
              icon: Icons.verified,
            ),
            _buildBadgeTile(
              context,
              title: 'Python for AI Fundamentals',
              date: 'Issued: Dec 2025',
              color: Colors.amber.shade100,
              icon: Icons.code,
            ),
          ],
        ),
      ),
    );
  }
}
