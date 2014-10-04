/* Error codes */
var SUCCESS = 1;
var ERR_BAD_CREDENTIALS = -1;
var ERR_USER_EXISTS = -2;
var ERR_BAD_USERNAME = -3;
var ERR_BAD_PASSWORD = -4;
var MAX_USERNAME_LENGTH = 128;
var MAX_PASSWORD_LENGTH = 128;

$(document).ready(function() {
    /* Hide the logout logo in the main screen. Show it when the client goes to the login screen. */
    $("#logout").hide();
    /* Client side form validation. Hide it first. If it is blurred, show the warning messages. */
    $("#userWarningMsg").hide();
    $("#passwordWarningMsg").hide();

    /* Changing styling of the buttons on hover. */
    $(".btn").hover(function() {
        $(this).addClass("activeBtn");
    },
    function() {
        $(this).removeClass("activeBtn");
    });

    /* Make a post request to the server when login button is clicked. */
    $("#Login").click(function(e) {
        e.preventDefault(); /* Prevent the page from reloading after pressing submit button to submit a form. */
        var username = document.getElementById("user").value;
        var password = document.getElementById("password").value;
        $.ajax({
            type: "POST",
            url: "users/login",
            dataType: "json",
            data: { "user": username, "password": password },
            success: function(data) {
                message(data, username);
            }
        });
    });

    /* Make a post request to the server when addUser button is clicked. */
    $("#AddUser").click(function(e) {
        e.preventDefault(); /* Prevent the page from reloading after pressing submit button to submit a form. */
        var username = document.getElementById("user").value;
        var password = document.getElementById("password").value;
        $.ajax({
            type: "POST",
            url: "users/add",
            dataType: "json",
            data: { "user": username, "password": password },
            success: function(data) {
                message(data, username);
            }
        });
    });

    /* When logout is clicked, reload the page so that it goes back to the main screen. */
    $("#logout").click(function() {
        location.reload();
    });

    /* Client-side Form Validation for the user input field. */
    $("#user").blur(function() {
        if ($(this).val() == "" || $(this).val().length > MAX_USERNAME_LENGTH) {
            $("#usernameWarningMsg").html("The user name should be non-empty and at most 128 characters long.");
            $("#usernameWarningMsg").show();
        }
    });
    $("#user").focus(function() {
        $("#usernameWarningMsg").hide();
    });

    /* Client-side Form Validation for the password input field. */
    $("#password").blur(function() {
        if ($(this).val().length > MAX_PASSWORD_LENGTH) {
            $("#passwordWarningMsg").html("The password should be at most 128 characters long.");
            $("#passwordWarningMsg").show();
        }
    });
    $("#password").focus(function() {
        $("#passwordWarningMsg").hide();
    });
});

/* Print the messages according to the errCode sent back from the server. */
var message = function(returnedJson, username) {
    var errCode = returnedJson.errCode;
    var msg = "";
    if (errCode === SUCCESS) {
        msg = "Welcome " + username + ".<br/>You have logged in " + returnedJson.count + " times.";
        $(".Message").html(msg);
        $("form").hide();
        $("#logout").show();
    } else {
        switch(errCode) {
            case ERR_BAD_CREDENTIALS:
                msg = "Invalid username and password combination. Please try again.";
                break;
            case ERR_USER_EXISTS:
                msg = "This username already exists. Please try again.";
                break;
            case ERR_BAD_USERNAME:
                msg = "The user name should be non-empty and at most 128 characters long. Please try again.";
                break;
            case ERR_BAD_PASSWORD:
                msg = "The password should be at most 128 characters long. Please try again.";
                break;
            default:
                msg = "System error.";
                break;
        }
        $(".Message").html(msg);
        $("#user").val("");
        $("#password").val("");
    }
    return msg;
};