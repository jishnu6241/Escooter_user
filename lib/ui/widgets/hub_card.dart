import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HubCard extends StatelessWidget {
  final dynamic hubDetails;
  final Function() onTap;
  const HubCard({
    super.key,
    required this.onTap,
    required this.hubDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: onTap,
      color: Colors.greenAccent[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uri uri = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${hubDetails['latitude']},${hubDetails['longitude']}');

                        await launchUrl(uri);
                      },
                      child: Row(
                        children: [
                          Text(
                            hubDetails['name'].toString().toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.location_pin,
                            size: 22,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      hubDetails['address'],
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Available Scooters',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      hubDetails['scooters'].length.toString(),
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.green[900],
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
