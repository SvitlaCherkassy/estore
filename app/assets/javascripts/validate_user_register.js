function password_val(password) {
  if ( password.length <= 5 ){
    $(".error_mes_pass").text("Password is too short (minimum is 6 characters)");
  } else {
    $(".error_mes_pass").text("");
  }
};

function IsValidEmail(email) {
  var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
  if (filter.test(email)) {
    $(".error_mes_email").text("");
  } else {
    $(".error_mes_email").text("Invalid email");
  }
};
