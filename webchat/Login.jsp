<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>

 <%@page import="java.util.*"%>
 
 <!DOCTYPE html>
<html lang="en">
<head>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,900;1,300&display=swap" rel="stylesheet">

    <title>webapp</title>

    <style>
    .signup
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
    
    .signup input,.searchbox input{
        width:70%;
        padding:2px 10px ;
        margin:5px 0;
    }
   .signup input[type="submit"], .searchbox input[type="submit"],#btn{
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


    <script>

        document.getElementById("signup").style.display="none";

        function change()
        {
               var x = document.getElementById("signup");
               var y = document.getElementById("login");
                if (x.style.display === "none")
                {
                    x.style.display = "block";
                    y.style.display="none";
                } 
                else 
                {
                    x.style.display = "none";
                    y.style.display= "block";
                }

        }
        

        function validate()
        {

            var x=document.getElementById("Npword").value;
            var y=document.getElementById("Cpword").value;

            if(x===y)
            {
                document.getElementById("form").innerHTML="<input type='submit' onclick='validate()' id='submit'>";
                 document.getElementById("submit").click();
            }
            else{
                alert("password missmatch");
            }

        }

    </script>





</head>
<body>
    
    <%
        String signup = (String) session.getAttribute("signup");
        if (signup!=null){     
        out.print("<script>alert('Login created successfully');</script>");
        }      
        session.setAttribute("signup",null);
    %>



    <div class="signup" id="signup">
        
          <p>signup</p>
          <form action="./signup" method="get" accept-charset="UTF-8" id="form">

            <input type="text" name="username-signup" id="uname" autocomplete="off" placeholder="Username" >
            <input type="password" name="password-signup" id="Npword" placeholder="Password">
            <input type="password"    id="Cpword" placeholder="conform Password">

            <br>
            <input type='submit'  id='submit' value="submit">

          </form>

        
         <button onclick="change()" id="btn">Login<button>

    </div>


    <div class="searchbox" id="login">
    

            <p>Login</p>

            <form action="./access" method="get" accept-charset="UTF-8">
                <input type="text" name="username" id="uname" autocomplete="off" placeholder="Username">

                
                <input type="password" name="password" id="pword" placeholder="Password">
                <br>
                <input type="submit" value="Login">
            </form>
            <p>create new account</p><button onclick="change()" id="btn">signup<button>
    </div>


</body>
</html>