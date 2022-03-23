
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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


         input[type="submit"],button,input[type="button"]{
               background-color:#007AFF;
                border:none;
                border-radius:10px;
                padding:5px;
                width:100px;
                color:#fff;
                cursor:pointer;
         }

         input[type="submit"]:hover{
              background-color:#0055b3;

         }
         input[type="button"]:hover{
            background-color:#0055b3;
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
        #newusers{
            width:200px;
            padding:5px 10px;
            margin:2px 0;
        }

        #text{
            min-width: 60px;
            max-width: 200px;
            padding: 14px 18px;
            background-color:#007AFF;
            border-radius: 16px;
            border: 1px solid #443f56;
            color:white;
            font-size:15px;
            margin-bottom:2px;
            border:none;

        }
        #mytext{
            min-width: 60px;
            max-width: 200px;
            padding: 14px 18px;
            background-color:#1F1C38;
            border-radius: 16px;
            color:white;
            font-size:15px;
            margin-bottom:2px;
            border:none;
     
           

        }



        </style>
    </head>

    
    <script type="text/javascript">

      <% String pathname=(String)session.getAttribute("username"); %>
     
    var path="ws://localhost:9090/webchat/chat/"+"<%=pathname%>";

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



        ws.onopen = function (event) 
        {
            
        };


    ws.onmessage = function(event) {
       
       var message=event.data;
       
       if(message.includes("friends:"))
       {
            var Firstname = message.split(" ");
            var namelist = document.getElementById("namelist");
            var element = document.createElement("input");
            console.log(Firstname[1]);
            element.type = "button";
            element.value = Firstname[1]; 
            element.name = "button"; 
            element.id= "newusers";
            element.class="newusers";
            element.onclick=function () 
            {
                  var x = document.getElementById(Firstname[1]);
                    if (x.style.display === "none") {
                        x.style.display = "block";
                    } else {
                        x.style.display = "none";
                    }
            };

            var foo = document.getElementById("fri");
            foo.appendChild(element);


             var box = document.createElement("div");
            console.log(Firstname[1]);
        
            box.id=Firstname[1];
            box.class="box";
            



       }
       else 
       {
           if(message.includes("joined"))
            {
                    loadname(message);
            }
            else{
                  var mySpan = document.getElementById("chat");
            
                    var me=document.getElementById('myname').innerText;
                    console.log(me );
                    console.log(message );

                    var chatname=message.split(":");
                    var compare=chatname[0];

                   if(!(compare===me))
                   {
                        mySpan.innerHTML+="<p id='text' >"+message+"</p>";
                       
                        notification();
                   }
                   else
                   {
                        mySpan.innerHTML+="<p id='mytext' >"+message+"</p>";
                      
                      
                   }
                 

            }


          

       }
    };

    ws.onclose = function(event)
    {
        
    };
 
    function loadname(name)
    {
        var Firstname = name.split(" ");
        var namelist = document.getElementById("namelist");
        // namelist.innerHTML += Firstname[0] +"<br/>";
        add(Firstname[0]);
    }
    
    function notification() {
				
				var mp3 = '<source src="msg.mp3" type="audio/mpeg">';
				document.getElementById("sound").innerHTML =
				'<audio autoplay="autoplay">' + mp3 + "</audio>";
			}


    function sendMsg(name) {
        var msg = document.getElementById("msg").value;
        if(msg)
        {
             <% String name=(String)session.getAttribute("username"); %>
             msg="<%=name%>"+">>"+msg+"("+curtime+")>>"+name;
            ws.send(msg);
        }
        document.getElementById("msg").value="";
    }

    




function add(name)
{

    var element = document.createElement("input");
    
    element.type = "button";
    element.value = name; 
    element.name = "button"; 
    element.id= "newusers";
    element.class="newusers";


    var foo = document.getElementById("fooBar");
    foo.appendChild(element);



}


function change()
{
    var x = document.getElementById("group");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}




</script>


    <body>


    <div class="user-online">   
        <% String s=(String)session.getAttribute("username"); %>
      <% if(s!=null)
      {%>
         <h1> Welcome <span id='myname'><%=s%></span></h1>
      <%}
      else
      {
          response.sendRedirect("http://localhost:9090/webchat/");
      }
      %>
     
     
     <div class="namelist" id="namelist">
            <input type="button" id="newusers" value="group" onclick="change()">
            <p>Users online</p>
            <p id="fooBar"></p><br>
            <p>Friends</p>
            <p id="fri"></p><br>
     </div>

    <div class="private-chat">
        <form action="./access" target="_blank" method="post" accept-charset="UTF-8">
         <input type="text" name="friend" id="uname" autocomplete="off" placeholder="Username">
         <input type="hidden" name="Myname" id="myname" value="<%=s%>">
         <br>
         <input type="submit" value="Connect">
     </form>
    </div>

  </div>
  <div id="sound"></div>

<%


      Connection c = null;
        Statement st= null;
        String username=(String)session.getAttribute("username");
        try {
           Class.forName("org.postgresql.Driver");
           c = DriverManager
              .getConnection("jdbc:postgresql://localhost:5432/"+username,
              "postgres", "1234");

            
              c.setAutoCommit(false);

        
       
           st = c.createStatement();
           ResultSet rs = st.executeQuery( "SELECT table_name FROM information_schema.tables WHERE table_schema='public'  AND table_type='BASE TABLE';" );
           while ( rs.next() ) {
              String  chat = rs.getString("TABLE_NAME");
              if(!(chat.equals("friends")))
              {
                  
             %>

            <div class="box" id=<%=chat%>>

            <div class="message box" id="message-box">
                    <div class="name-box">
                        <h3><%=chat%></h3>
                    </div>

                    <div id="chat" class="chat"></div>
                    <div>
                    <input type="text" name="msg" id="msg" placeholder="Enter message here"/>
                        <button onclick="return sendMsg('<%=chat%>');">Enter</button>
                    
                    </div>
                </div>

            </div>

              <%}
             
          
             
           }

           rs.close();
           st.close();
           c.close();
      
           
        }
        catch(Exception e)
        {
            System.out.println(e);
        }




%>
<%-- <div class="box" id="friend">

   <div class="message box" id="message-box">
         <div class="name-box">
            <h3>Naveen</h3>
        </div>

        <div id="chat" class="chat"></div>
        <div>
        <input type="text" name="msg" id="msg" placeholder="Enter message here"/>
            <button onclick="return sendMsg();">Enter</button>
        
        </div>
    </div>

</div> --%>




 
    </body>
</html>