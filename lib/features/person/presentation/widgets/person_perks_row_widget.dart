import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import 'person_perk_item_widget.dart';

class PersonPerksRowWidget extends StatelessWidget {
  const PersonPerksRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Row(
      children: [
        Expanded(
          child: PersonPerkItemWidget(
            icon: Icons.local_shipping_outlined,
            title: localization.personFreeShipping,
            description: localization.personFreeShippingDesc,
          ),
        ),
        Expanded(
          child: PersonPerkItemWidget(
            icon: Icons.assignment_return_outlined,
            title: localization.personFreeReturn,
            description: localization.personFreeReturnDesc,
          ),
        ),
      ],
    );
  }
}