
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,900;1,300&display=swap" rel="stylesheet">

        <style media="screen" type="text/css">

        .chat {
                width: 500px;
                height: 200px;
                margin:auto;
                border: 1px solid silver;
                overflow-y: scroll;
                background-color:#FFFFFF;
                text-align:left;
                border-radius:20px;
                padding:10px;

        }

        #msg ,#uname{
            margin:auto;
            width: 200px;
            padding:7px;
            margin-top:10px;
       
            }


         input[type="submit"],button{
               background-color:#007AFF;
                border:none;
                border-radius:10px;
                padding:5px;
                width:100px;
                color:#fff;
         }
        h1 {
            text-align: center;
             color:#8579EB;
             font-size:17px;
        
        }

       .box{

            position:absolute;
            top:50%;
            left:50%;
            transform:translate(-50%,-50%);
            text-align:center;
            padding:10px;
            background-color:#FAFAFC;
            border-radius:10px;
            
            
       }
       span{
           color:white;
           font-size:34px;
       }

       *{
           margin:0;
           padding:0;
           font-family: 'Poppins', sans-serif;
       }
        body{
           background-color:#007AFF;
            width:100%;
            height:100vh;
        }
        
       .user-online{
           width:300px;
           height:100vh;
           overflow:hidden;
           background-color:#1F1C38;
           color:white;
           text-align:center;
       }
       
       .namelist{
           margin-top:20px;
           padding:20px;
           text-align:center;
       }
       
       .name-box{
           padding:5px 10px;
           border-radius:10px;
           color:#fff;
           background-color:#1F1C38;
       }
       .private-chat{
           width:300px;
           height:200px;
       }

        </style>
    </head>
    <script type="text/javascript">

      <% String pathname=(String)session.getAttribute("username"); %>
      <% String friend=(String)session.getAttribute("friend"); %>
     
    var path="ws://localhost:9090/webchat/chat/"+"<%=pathname%>/"+"<%=friend%>";

    var ws = new WebSocket(path);


    function formatAMPM(date) 
    {
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var ampm = hours >= 12 ? 'pm' : 'am';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0'+minutes : minutes;
        var strTime = hours + ':' + minutes + ' ' + ampm;
        return strTime;
     }

    var curtime=formatAMPM(new Date);


    ws.onmessage = function(event) {
       
    
       var mySpan = document.getElementById("chat");
      
       mySpan.innerHTML+= event.data+"<br/>";
    };

    ws.onclose = function(event)
    {
        ws.send("left the chat");
    };
 
 

    function sendMsg() {
        var msg = document.getElementById("msg").value;
        if(msg)
        {
             <% String name=(String)session.getAttribute("myname"); %>
             msg="<%=name%>"+">>"+msg+"("+curtime+")-private msg";
            ws.send(msg);
        }
        document.getElementById("msg").value="";
    }
</script>
    <body>
    <div class="user-online">   
        <% String s=(String)session.getAttribute("myname"); %>
      <% if(s!=null)
      {%>
         <h1> Welcome <span><%=s%></span></h1>
      <%}
      else
      {
          response.sendRedirect("http://localhost:9090/webchat/");
      }
      %>
     

 

  </div>

<div class="box">


   <div class="message box">
         <div class="name-box">
           <% String friendname=(String)session.getAttribute("friend"); %>
            <h3><%=friendname%></h3>
        </div>

        <div id="chat" class="chat"></div>
        <div>
        <input type="text" name="msg" id="msg" placeholder="Enter message here"/>
            <button onclick="return sendMsg();">Enter</button>
        
        </div>
    </div>


</div>


 
    </body>
</html>