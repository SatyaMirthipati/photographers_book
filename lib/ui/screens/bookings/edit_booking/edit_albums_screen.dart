import 'package:flutter/material.dart';
import 'package:photographers_book/bloc/booking_bloc.dart';
import 'package:photographers_book/ui/widgets/empty_widget.dart';
import 'package:provider/provider.dart';

import '../../../../model/booking.dart';
import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';
import '../../../widgets/navbar_button.dart';
import 'edit_album_details_screen.dart';
import 'edit_amount_details_screen.dart';

class EditAlbumsScreen extends StatefulWidget {
  final Map<String, dynamic> response;
  final Booking booking;

  const EditAlbumsScreen({
    super.key,
    required this.response,
    required this.booking,
  });

  static Future open(
    BuildContext context, {
    required Map<String, dynamic> response,
    required Booking booking,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditAlbumsScreen(
          response: response,
          booking: booking,
        ),
      ),
    );
  }

  @override
  State<EditAlbumsScreen> createState() => _EditAlbumsScreenState();
}

class _EditAlbumsScreenState extends State<EditAlbumsScreen> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    print(bookingBloc.updateSheetsData);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (bookingBloc.updateSheetsData.isNotEmpty) ...[
              Text(
                'Albums Added',
                style: textTheme.titleLarge!.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              for (int i = 0; i < bookingBloc.updateSheetsData.length; i++) ...[
                CustomCard(
                  margin: EdgeInsets.zero,
                  radius: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DetailsTile(
                                title: const Text('Sheet'),
                                value: Text(
                                  bookingBloc.updateSheetsData[i].sheet ?? 'NA',
                                ),
                              ),
                            ),
                            Expanded(
                              child: DetailsTile(
                                title: const Text('Quantity'),
                                value: Text(
                                  bookingBloc.updateSheetsData[i].quantity ??
                                      'NA',
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (i != 0)
                          Positioned(
                            top: -15,
                            right: -15,
                            child: IconButton(
                              onPressed: () async {
                                setState(() {
                                  bookingBloc.updateSheetsData.remove(
                                    bookingBloc.updateSheetsData[i],
                                  );
                                });
                              },
                              icon: Icon(
                                Icons.remove_circle,
                                color: Colors.redAccent.shade700,
                                size: 20,
                              ),
                            ),
                          ),
                        Positioned(
                          top: i != 0 ? 15 : -15,
                          right: -15,
                          child: IconButton(
                            onPressed: () async {
                              EditAlbumDetailsScreen.open(
                                context,
                                response: bookingBloc.updateSheetsData[i],
                                index: i,
                              );
                              setState(() {});
                            },
                            icon: Image.asset(
                              Images.edit,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ] else ...[
              const EmptyWidget(),
            ]
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          var response = widget.response;
          response['sheets'] = bookingBloc.updateSheetsData;

          EditAmountDetailsScreen.open(
            context,
            response: response,
            booking: widget.booking,
          );
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
