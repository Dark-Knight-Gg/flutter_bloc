
bool checkEmailPassword (String email, String password){
  bool isOk = false;
  if (RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    if(password.length >=9){
      isOk= true;
    }
  }
  return isOk;
}
bool checkEmail (String email){
  bool isOk = false;
  if (RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)){
    isOk = true;
  }
  return isOk;

}
bool checkPassword (String password){
  bool isOk = false;
  if (password.length>=9){
    isOk = true;
  }
  return isOk;
}