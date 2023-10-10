part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ResetPasswordEventInitial extends ResetPasswordEvent {
  const ResetPasswordEventInitial();
}

class SendNumber extends ResetPasswordEvent {
  const SendNumber({this.phone});

  final String? phone;

  @override
  List<Object?> get props => [phone];
}

class GetReadyToSendData extends ResetPasswordEvent {
  const GetReadyToSendData();
}

class SendCode extends ResetPasswordEvent {
  const SendCode({required this.code});

  final String code;

  @override
  List<Object?> get props => [code];
}
