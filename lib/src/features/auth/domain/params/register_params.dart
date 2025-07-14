class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String phone;

  const RegisterParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });
}
