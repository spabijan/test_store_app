import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_store_app/model/services/manage_http_response.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_provider.dart';
import 'package:test_store_app/screens/authentication/repository/providers/auth_state_details_provider.dart';
import 'package:test_store_app/screens/cart_screen/widgets/blue_button.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShippingAddressScreen();
}

class _ShippingAddressScreen extends ConsumerState<ShippingAddressScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _localityController = TextEditingController();

  @override
  void dispose() {
    _stateController.dispose();
    _cityController.dispose();
    _localityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // read only on on start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(loggedUserProvider);
      if (user != null) {
        _stateController.text = user.state;
        _cityController.text = user.city;
        _localityController.text = user.locality;
      }
    });
  }

  void _updateShippingAddress() {
    if (formKey.currentState!.validate()) {
      final state = _stateController.text.trim();
      final city = _cityController.text.trim();
      final locality = _localityController.text.trim();
      final id = ref.read(loggedUserProvider)!.id;
      ref.read(authProvider.notifier).updateAddressData(
          id: id, city: city, state: state, locality: locality);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authProvider, (previous, next) {
      next.whenOrNull(data: (data) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully updated address')));
      }, error: (error, stackTrace) {
        if (error is HttpError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }
      });
      next.whenData((value) => Navigator.of(context).pop());
    });
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.96),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.96),
            title: Text('Delivery',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    letterSpacing: 1.7))),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Center(
                child: Column(
              children: [
                Text('Please fill in shipping data',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 17,
                        letterSpacing: 1.7,
                        fontWeight: FontWeight.w600)),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'State field is required';
                      }
                      return null;
                    },
                    controller: _stateController,
                    decoration: const InputDecoration(labelText: 'State')),
                const SizedBox(height: 8),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'City field is required';
                      }
                      return null;
                    },
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'City')),
                const SizedBox(height: 8),
                TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Locality field is required';
                      }
                      return null;
                    },
                    controller: _localityController,
                    decoration: const InputDecoration(labelText: 'Locality')),
                const SizedBox(height: 8),
              ],
            )),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final authUpdate = ref.watch(authProvider);

              return authUpdate.maybeMap(
                  loading: (loading) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  orElse: () => BlueButton(
                      textButton: 'Save', onTap: _updateShippingAddress));
            },
          ),
        ));
  }
}
