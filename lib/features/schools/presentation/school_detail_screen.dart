import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/schools/bloc/school_detail_bloc.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';
import 'package:mobile/features/schools/presentation/widgets/school_error_widget.dart';

import '../../../generated/l10n.dart';

class SchoolDetailScreen extends StatelessWidget {
  const SchoolDetailScreen({super.key, required this.schoolModel});
  final SchoolModel schoolModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SchoolDetailBloc, SchoolDetailState>(
        builder: (context, state) {
          if (state is GetSchoolDetailProgress || state is SchoolDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetSchoolDetailError) {
            return SchoolErrorWidget(
              errorText: state.errorMessage,
              onTap: () {
                context.read<SchoolDetailBloc>().add(
                  GetSchoolDetailEvent(schoolId: schoolModel.id),
                );
              },
              title: S.of(context).schoolsLoadError,
            );
          }
          return Text(state.toString());
        },
      ),
    );
  }
}
