import 'package:flutter/material.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? expenseData;

  const ExpenseDetailsScreen({Key? key, this.expenseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = expenseData?['title'] ?? 'Whole Foods';
    final double amount = expenseData?['amount']?.toDouble() ?? 84.20;
    final String merchant = expenseData?['merchant'] ?? 'Whole Foods Market, Downtown Branch';
    final String category = expenseData?['category'] ?? 'Groceries - Food & Drink';
    final String paymentMethod = expenseData?['paymentMethod'] ?? 'Visa Debit •••• 4321';
    final String date = expenseData?['date'] ?? 'Oct 14, 2026, 6:30 PM';
    final String notes = expenseData?['notes'] ?? 'Weekly family grocery run. Bread, milk, vegetables, chicken. Receipt attached.';

    const primaryGreen = Color(0xFF1B4D3E);
    const backgroundMint = Color(0xFFF2F7F4);

    return Scaffold(
      backgroundColor: backgroundMint,
      appBar: AppBar(
        backgroundColor: backgroundMint,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 20),
              onPressed: () => Navigator.maybePop(context),
            ),
          ),
        ),
        title: const Text(
          'Expense Details',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.black87, size: 20),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              '-\$${amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow('Category', category, Icons.category_outlined),
                    const Divider(height: 24, color: Color(0xFFF0F0F0)),
                    _buildDetailRow('Merchant/Shop', merchant, Icons.store_outlined),
                    const Divider(height: 24, color: Color(0xFFF0F0F0)),
                    _buildDetailRow('Payment Method', paymentMethod, Icons.payment_outlined),
                    const Divider(height: 24, color: Color(0xFFF0F0F0)),
                    _buildDetailRow('Notes/Description', notes, Icons.notes_outlined),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Receipt',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: backgroundMint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.description_outlined, size: 28, color: primaryGreen),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Receipt attached',
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('Edit Expense', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.white,
                ),
                child: const Text('Delete Expense', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600)),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F7F4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF1B4D3E)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
