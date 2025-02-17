// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:utueji/src/core/errors/failures.dart';

// class ErrorHandler {
//   static Failure handleServerError(Supabase  error) {
//     switch (error.status) {
//       case 401:
//         return ServerFailure(ErrorMessages.erroNaoAutorizado);
//       case 404:
//         return ServerFailure(ErrorMessages.erroNaoEncontrado);
//       case 500:
//         return ServerFailure(ErrorMessages.erroInternoServidor);
//       case 408:
//         return ServerFailure(ErrorMessages.erroTimeout);
//       default:
//         return ServerFailure(ErrorMessages.erroServidor);
//     }
//   }

//   static Failure handleGeneralError(Exception e) {
//     // Aqui você pode adicionar um log para rastrear o erro se necessário
//     return ServerFailure(ErrorMessages.erroInesperado);
//   }
// }
