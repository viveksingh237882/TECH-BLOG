
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <!-- link of the css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 92%, 67% 84%, 30% 84%, 0 93%, 0 0);
            }
        </style>
    </head>
    <body>
        <%@include file="normal_navbar.jsp" %>
        <main>
            <div class="col-md-4 offset-md-4">
                <div class="card-header text-center">
                    <span class=" fa fa-3x fa-user-circle"></span>
                    <br>
                    Register here
                </div>
                <div class="card-body">
                    <form id="reg-form" action="RegisterServlet" method="Post">
                        <div class="form-group">
                            <label for="user_name">User Name</label>
                            <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">

                        </div>


                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">

                        </div>


                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                        </div>

                        <div class="form-group">
                            <label for="gender">Select Gender</label>
                            <input type="radio"  id="gender" name="gender" value="male">Male
                            <input type="radio"  id="gender" name="gender" value="female">Female
                        </div>
                        <div>
                            <textarea name="about"class="form-control" id="" placeholder="Enter somthing about yourself"></textarea>
                        </div>
                        <div class="form-check">
                            <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                            <label class="form-check-label" for="exampleCheck1">agree term and condition</label>

                        </div>
                        <br>
                        <div class="container text-center"id ="loader" style="display:none;" >
                            <span class="fa fa-refresh fa-spin fa-3x"></span>
                            <h4>please wait...</h4>
                        </div>
                        <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                    </form>

                </div>


            </div>
        </main>
        <!--javascripts-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script>
            $(document).ready(function () {
                console.log("loaded...")

                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();
                    let form = new FormData(this);
                    $("#submit-btn").hide();
                    $("#loader").show();


                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)

                            $("#submit-btn").show();
                            $("#loader").hide();

                            if (data.trim() === 'Done')
                            {
                                swal("Registered Successfully...We are redirecting to login page")
                                        .then((value) => {
                                            window.location = "login_page.jsp"
                                        });
                            } else
                            {
                                swal(data);
                            }
                        },
                        error: function (jqXHR, textDataStatus, errorThrown) {
                            console.log(jqXHR)

                            $("#submit-btn").show();
                            $("#loader").hide();


                            swal("Something went wrong!!!")

                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>
    </body
</html>
