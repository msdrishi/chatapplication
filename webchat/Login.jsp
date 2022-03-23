<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>

 <%@page import="java.util.*"%>
 
 <!DOCTYPE html>
<html lang="en">
<head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,900;1,300&display=swap" rel="stylesheet">

    <title>webapp</title>

    <style>
    .searchbox
    {
        position:absolute;
        top:50%;
        left:50%;
        text-align:center;
        width:250px;
        margin:auto;
        height:auto;
        background-color:#F8F9FB;
        padding:10px;
        border-radius:20px;
        transform:translate(-50%,-50%);

    }
    
    .searchbox input{
        width:70%;
        padding:2px 10px ;
        margin:5px 0;
    }
    .searchbox input[type="submit"]{
        background-color:#007AFF;
        border:none;
        border-radius:10px;
        padding:5px;
        width:30%;
        color:#fff;

    }
    


    *{
        margin:0;
        padding:0;
font-family: 'Poppins', sans-serif;
    }

    body
    {
        background-color:#007AFF;
        background-repeat:no-repeat;
        width:100%;
        height:100vh;

    }
    </style>

</head>
<body>
    
    <div class="searchbox">
    <% String invalid=(String)session.getAttribute("invalid");%>
    
      <% if(invalid!=null)
      {%>
         <p><%=invalid%></p>
      <%}%>

     <form action="./access" method="get" accept-charset="UTF-8">
         <input type="text" name="username" id="uname" autocomplete="off" placeholder="Username">

         
         <input type="password" name="password" id="pword" placeholder="Password">
         <br>
         <input type="submit" value="Login">
     </form>


   </div>

</body>
</html>