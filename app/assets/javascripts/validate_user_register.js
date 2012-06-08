function password_val(string1) {
  if ( string1.length <= 5 ){
    $(".error_mes_pass").text("Password is too short (minimum is 6 characters)");
  } else {
    $(".error_mes_pass").text("");
  }
};
