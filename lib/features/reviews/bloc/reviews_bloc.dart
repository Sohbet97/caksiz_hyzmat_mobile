import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/reviews/data/review_repository.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewRepository reviewRepository;
  ReviewsBloc({required this.reviewRepository}) : super(ReviewsInitial()) {
    on<ReviewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
