abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangeState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {}
class RegisterErrorState extends RegisterStates {}

class CreateUserLoadingState extends RegisterStates {}
class CreateUserSuccessState extends RegisterStates {}
class CreateUserErrorState extends RegisterStates {}
