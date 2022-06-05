<%-- 
    Document   : error_page
    Created on : 08-Feb-2022, 10:15:02 pm
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SomeThing went worng!!</title>
        
        
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
        <div class="container text-center">
            <img src="img/browser.png" class="img-fluid" alt=""/>
            <h4 class="display-3">Sorry!! SomeThing went wrong...</h4>
            <%--<%= exception %>--%>
            <a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home</a>
        </div>
    </body>
</html>
