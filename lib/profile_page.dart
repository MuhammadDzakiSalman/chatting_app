import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('images/profile_dzaki.png'),
              // Ganti dengan path atau URL gambar profil pengguna
            ),
            SizedBox(height: 16),
            Text(
              'Dzaki',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Online',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            _buildInfoRow('Phone', '+123 456 7890'),
            _buildInfoRow('Email', 'dzaki@example.com'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aksi untuk mengedit profil
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
