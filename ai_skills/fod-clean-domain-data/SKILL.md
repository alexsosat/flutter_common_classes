---
name: fod-clean-domain-data
description: >-
  Guide for implementing Clean Architecture Domain and Data layers using UseCaseAsync, UseCase, Params, NoParams, Failure, AppFailure, HttpCallFailure, and fpdart Either error handling.
  Use when writing business use cases, repository interfaces, data sources, and domain failure mappings with flutter_common_classes.
---

# Domain & Data Layer Guidelines (`flutter_common_classes`)

This skill outlines how to implement the Domain and Data layers in a Flutter application following Clean Architecture principles and using `flutter_common_classes` abstractions.

---

## 1. Domain Layer: UseCases & Params

All business operations should be encapsulated in Use Cases inheriting from `UseCaseAsync<SuccessType, Params>` for asynchronous tasks or `UseCase<SuccessType, Params>` for synchronous tasks.

### Step 1: Define Input Parameters
Inherit from `Params` to standardize payload formatting (headers, query parameters, request body):

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';

class GetUserByIdParams extends Params {
  final String userId;

  const GetUserByIdParams({required this.userId});

  @override
  Map<String, dynamic>? queries() => {'id': userId};
}
```

For operations without parameters, use `NoParams`:
```dart
const params = NoParams();
```

### Step 2: Implement Use Cases
Implement `UseCaseAsync` with `fpdart` `Either<Failure, T>` return type:

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUserByIdUseCase implements UseCaseAsync<UserEntity, GetUserByIdParams> {
  final UserRepository repository;

  GetUserByIdUseCase(this.repository);

  @override
  Failure? failure;

  @override
  Future<Either<Failure, UserEntity>> call({required GetUserByIdParams params}) async {
    return await repository.getUserById(params);
  }
}
```

---

## 2. Error Handling & Failure Hierarchy

`flutter_common_classes` provides a structured failure architecture using functional error handling (`Either<Failure, T>`).

### Standard Failure Classes

1. **`Failure`**: Abstract base class containing `String title` and `String message`.
2. **`AppFailure`**: Application and domain-level failures:
   - `AppFailure.unexpected("Error message")`: For unhandled logic/catch errors.
   - `AppFailure.invalidForm("Form validation failed")`: Form validation failures.
   - `AppFailure.cacheException(exception)`: Cache storage failures.
   - `AppFailure.environment(exception)`: Missing environment variable errors.
3. **`HttpCallFailure`**: Network and HTTP exceptions:
   - `HttpCallFailure.fromException(httpException)`: Automatically maps `HttpCallException` status types (`connectionError`, `serverError`, `unauthorized`, `clientError`, `badRequest`, etc.).

### Creating Custom Domain Failures
```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure() : super(
    title: "Usuario no encontrado",
    message: "El usuario solicitado no existe o fue eliminado.",
  );
}
```

---

## 3. Data Layer: Repository & Data Source Implementation

### Step 1: Repository Interface (Domain Layer)
```dart
abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserById(GetUserByIdParams params);
}
```

### Step 2: Repository Implementation (Data Layer)
Catch low-level data source exceptions and map them to domain `Failure` instances:

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:fpdart/fpdart.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserById(GetUserByIdParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(HttpCallFailure(
        title: "Sin conexión",
        message: "Por favor verifica tu conexión a internet.",
        type: HttpExceptions.connectionError,
      ));
    }

    try {
      final userModel = await remoteDataSource.fetchUser(params);
      return Right(userModel.toEntity());
    } on HttpCallException catch (e) {
      return Left(HttpCallFailure.fromException(e));
    } catch (e) {
      return Left(AppFailure.unexpected(e.toString()));
    }
  }
}
```

---

## 4. Testing with Mock Data Sources

`flutter_common_classes` exports `MockDataSource` and `MockModel` helpers to speed up offline development and unit tests:

```dart
import 'package:flutter_common_classes/flutter_common_classes.dart';

class UserMockDataSource extends MockDataSource<UserModel> {
  @override
  UserModel get mockItem => UserModel(id: "1", name: "John Doe", email: "john@example.com");

  @override
  List<UserModel> get mockList => [mockItem];
}
```
