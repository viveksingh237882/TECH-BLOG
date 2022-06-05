<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="    java.sql.Date"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>

            <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 92%, 67% 84%, 30% 84%, 0 93%, 0 0);
            }
             body{
                background: url(img/vivek.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>

    </head>
    <body>
        <!--startin gof the nav bar-->

        <nav class="navbar navbar-expand-lg navbar-dark primary-background ">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#"><span class="fa fa-bell-o"></span>Code with vivek <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span>Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Projects Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><spam class="	fa fa-address-book-o"></spam>Contact us</a>
                    </li>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><spam class="	fa fa-asterisk"></spam>Do Post</a>
                    </li>


                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!"  data-toggle="modal" data-target="#profile-modal"><spam class="fa fa-user-circle"></spam><%=user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><spam class="fa fa-user-plus"></spam>logout</a>
                    </li>

                </ul>
            </div>
        </nav>
        <!--end of the nav bar-->


        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {

        %>

        <div class="alert alert-danger" role="alert">
            <%= m.getContent()%>
        </div>

        <%                               session.removeAttribute("msg");

            }
        %>
        <!--start of the main body of the page-->
        <main>
            <div class="Container">
                <div class="row mt-4">
                    <!--first part col-->
                    <div class="col-md-4">
                        <!--categories-->
                        <div class="list-group">

                            <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action flex-column align-items-start active">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1">All Posts</h5>
                                    <small>3 days ago</small>
                                </div>
                                <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
                                <small>Donec id elit non mi porta.</small>
                            </a>
                            <!--getting all categories from our data base-->
                            <%
                                PostDao d = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list1 = d.getAllCategories();
                                for (Category c1 : list1) {
                            %>
                            <a href="#" onclick="getPosts(<%=c1.getCid()%>,this)" class=" c-link list-group-item list-group-item-action flex-column align-items-start">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1"><%= c1.getName()%></h5>
                                    <small class="text-muted"></small>
                                </div>
                                <p class="mb-1"><%= c1.getDescription()%></p>
                                <small class="text-muted">Donec id elit non mi porta.</small>
                            </a>
                            <%
                                }

                            %>



                        </div>
                    </div>
                    <!--second Part of the page-->
                    <div class="col-md-8">
                        <!--posts-->
                        <div class="Container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin"></i>
                            <h3 class="mt-2">Loading...</h3>
                        </div>
                        <div class="Container-fluid" id="post-container"></div>
                    </div>
                </div>


            </div>
        </main>
        <!--end of the main body of the page-->
        
        
        
        <!--start of the profile midel-->



        <!--   Modal -->  

        <div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">TechBolg</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center" >


                            <!--get profile from user we call the getter and setters of the profile-->
                            <img src="pics/<%=user.getProfile()%>"class="img-fluid" style="border-radius:50%;max-width: 150px;">
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>
                            <!--details-->
                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID:</th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email:</th>
                                            <td><%=user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Status:</th>
                                            <td><%=user.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender:</th>
                                            <td><%=user.getGender()%></td>
                                        </tr>


                                    </tbody>
                                </table>
                            </div>

                            <!--editing code-->
                            <div  id="profile-edit" style="display: none;" >
                                <h3 class="mt-3">Please Edit carefully</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>ID:</td>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Email:</td>
                                            <td><input type="email"class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Name:</td>
                                            <td><input type="text"class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Password:</td>
                                            <td><input type="password"class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender()%></td>
                                        </tr>

                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea class="form-control" name="user_about">
                                                    <%= user.getAbout()%>
                                                </textarea>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>New profile:</td>
                                            <td>
                                                <input type="file" name="image" class="form-control">
                                            </td>

                                        </tr>

                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-success">SAVE</button>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--end of the profile modal-->

        <!--post modal start-->

        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">

                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Provide Post Details...</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method="post">
                            <div class="from-group">
                                <select class="form-control" name="cid">
                                    <option selected disable>----Select Category----</option>

                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        for (Category c : list) {
                                    %>

                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                    <%
                                        }
                                    %>
                                </select>

                            </div>
                            <div class="form-group">
                                <input  name="pTitle" type="text"  placeholder="Enter the post Detail"class="form-control">
                            </div>
                            <div class="form-group">
                                <textarea name="pContent" class="form-control"  style="heigth:200px;" placeholder="Enter the Content"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea name="pCode" class="form-control"  style="heigth:200px;" placeholder="Enter your Program code(if any)"></textarea>
                            </div>
                            <div>
                                <label>Select our Pics..</label>
                                <br>
                                <input type="file"  name="pic">
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post  </button>                              
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <!--end of the profile modal-->

        <!--javascripts documentry-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script>src = "https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"</script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>

            $(document).ready(function () {
                let editStatus = false;
                $('#edit-profile-button').click(function () {
//                       alert("click button")
                    if (editStatus == false) {
                        $("#profile-details").hide();
                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back");
                    } else {
                        $("#profile-details").show();
                        $("#profile-edit").hide();
                        editStatus = false;
                        $(this).text("Edit");
                    }
                })
            })
        </script>
        <!--add post to js-->

        <script>

            $(document).ready(function (e) {
//               addding listenser
                $("#add-post-form").on("submit", function (event) {
//                    this code is called when submitte the file....
                    event.preventDefault();
                    console.log("you have click on the post button....")
                    let form = new FormData(this);
                    //calling to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //sucess...  
                            console.log(data);
                            if (data.trim() == 'Done') {
                                swal("Good Job!", "Saved successfully", "success");
                            } else {
                                swal("Error!!", "Sosmething went Wrong try again", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error...
                            swal("Error!!!", "Sosmething went Wrong try again", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>
        <!--loading post page using ajax-->
        <script>
            function getPosts(catId,temp){
                $("#loader").show();
                $("#post-container").hide();
                $(".c-link").removeClass('active')
                
                
                $.ajax({
                   url:"load_posts.jsp",
                   data:{cid:catId},
                   success:function(data,textStatus,jqXHR){
                   console.log(data);
                   $("#loader").hide()
                   $("#post-container").show();
                   $("#post-container").html(data)
                   $(temp).addClass('active')
               }
               })
            }
            $(document).ready(function(e){
                let allPostRef=$('.c-link')[0]
               getPosts(0,allPostRef)
            })
        </script>
        <!--end of the add post-->


    </body>
</html>
