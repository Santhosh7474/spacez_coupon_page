import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coupons UI',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const CouponsScreen(),
    );
  }
}

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final double _originalPrice = 19500.00;
  final double _couponAmount = 6900.00;
  double _currentPrice = 19500.00;
  bool _couponApplied = false;

  void _applyCoupon() {
    setState(() {
      if (!_couponApplied) {
        _currentPrice = _originalPrice - _couponAmount;
        _couponApplied = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Success! ₹6900 discount applied."),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Coupon already applied."),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _reserveBooking() {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bokking confirmed"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildMainHeader(),
            _buildCouponsAppBar(),
            Expanded(
              child: Container(
                color: const Color(0xFFF5F5F5),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCouponCard(
                          onApply: _applyCoupon,
                          isApplied: _couponApplied,
                        ),
                        const SizedBox(height: 16),
                        _buildCouponCard(
                          onApply: _applyCoupon,
                          isApplied: _couponApplied,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Payment offers:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildCouponCard(
                          onApply: _applyCoupon,
                          isApplied: _couponApplied,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildMainHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "SPACEZ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 1.2,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Menu accesed"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCouponsAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () {},
          ),
          const Text(
            "Coupons",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({
    required VoidCallback onApply,
    required bool isApplied,
  }) {
    const Color couponColor = Color(0xFFC6723B);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 90,
              color: couponColor,
              child: Center(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Positioned(
                      right: 8,
                      top: 10,
                      bottom: 10,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(15, (index) {
                              return Container(
                                height: 4,
                                width: 2,
                                color: Colors.white.withOpacity(0.5),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "₹6,900",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,

                            fontSize: 22,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "LONGSTAY",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: onApply,
                          icon: Icon(
                            isApplied
                                ? Icons.check_circle_outline
                                : Icons.local_offer_outlined,
                            size: 16,
                          ),
                          label: Text(isApplied ? "Applied" : "Apply"),
                          style: TextButton.styleFrom(
                            foregroundColor: isApplied
                                ? Colors.green
                                : couponColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "15% off when you book for 5 days or more and 20% off when you book for 30 days or more.",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 8),
                    const Text(
                      "Read more",
                      style: TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.underline,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreenBanner() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(color: Color(0xFF1E8A6B)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.discount_outlined, color: Colors.white, size: 20),
          SizedBox(width: 8),
          Text(
            "Book now & Unlock exclusive rewards!",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildGreenBanner(),

        Container(
          padding: EdgeInsets.fromLTRB(
            16.0,
            16.0,
            16.0,
            MediaQuery.of(context).padding.bottom + 16.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${_originalPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "₹${_currentPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          "for 2 nights",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        "24 Apr - 26 Apr | 8 guests",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.edit_outlined,
                        size: 14,
                        color: Colors.blue[700],
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _reserveBooking();
                },
                child: const Text("Reserve"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC6723B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}