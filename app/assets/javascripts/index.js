/* Error codes */
var SUCCESS = 1;
var ERR_BAD_CREDENTIALS = -1;
var ERR_USER_EXISTS = -2;
var ERR_BAD_USERNAME = -3;
var ERR_BAD_PASSWORD = -4;

$(document).ready(function() {
    $("#logout").hide();

    $(".btn").hover(function() {
        $(this).addClass("activeBtn");
    },
    function() {
        $(this).removeClass("activeBtn");
    });

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

    $("#logout").click(function() {
        location.reload();
    });
});


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