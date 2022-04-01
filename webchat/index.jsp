
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

        .msg ,#uname{
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
        .newusers{
            width:400px;
            padding:5px 10px;
            margin:2px 0;
        }
        .onlineusers{
            width:400px;
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

        .namelist input
        {
            width:200px;
        }



        </style>
    </head>
    <script type="text/javascript" src="jquery.js">
</script>

    <script type="text/javascript">

      <% String pathname=(String)session.getAttribute("username"); %>
     
    var path="ws://localhost:9090/webchat/chat/"+"<%=pathname%>/"+location.port;

    var ws = new WebSocket(path);


    console.log(location.port);

    
    function formatAMPM(date) 
    {
        var hours = date.getHours();
        var minutes = date.getMinutes();
        var ampm = hours >= 12 ? 'pm' : 'am';
        hours = hours % 12;
        hours = hours ? hours : 12; 
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
       
       if(message.includes("srtksr6724t:"))
       {
            var Firstname = message.split(" ");
            
           addfriend(Firstname[1]);



       }
       else if(message.includes("hfo8yr679r69"))
       {
           var closeuser=message.split(" ");

           var leftuser=closeuser[0];


            offlineuser(leftuser);

       }
       else if(message.includes("requestf2u3hyr9ydb"))
       {
            var Firstname = message.split(" ");
            var element = document.createElement("input");
            element.type = "button";
            element.value = Firstname[1]; 
            element.id = Firstname[1]+"-request";
            element.className="newusers";
            element.onclick=function() 
            {
                  accept_request(Firstname[1]);
                  hidebutton(Firstname[1]);
            };


          
            var req2 = document.getElementById("req");
            req2.appendChild(element);


       }
       else if(message.includes("alter23ifhped32"))
       {
           var msg=message.split("-");
           var me=document.getElementById('myname').innerText;

           addfriend(msg[1]);
           addtable(msg[1]);
           addfrienddatabase(msg[1],me);

           

       }
       else 
       {
           if(message.includes("34y34yrgws"))
            {
                    loadname(message);
            }
            else{
                  
                    var me=document.getElementById('myname').innerText;
                    console.log(me );
                    console.log(message );

                    var chatname=message.split(">>");
                    var mymsg=chatname[0];
                    var myname=mymsg.split(":");
                    var namecheck=myname[0];
                    var friendname=chatname[1];

                    if(friendname===me)
                    {
                        friendname=namecheck;
                    }
                    var chatid= me+"-"+friendname;
                    console.log(chatid);
                    var mySpan = document.getElementById(chatid);

                    document.getElementById("getmsg").value=mymsg;

                   
                  
                     

                  
                      

            
                   if(!(namecheck===me))
                   {
                        mySpan.innerHTML+="<p id='text' >"+mymsg+"</p>";
                         
                       
                        notification();
                   }
                   else
                   {
                        mySpan.innerHTML+="<p id='mytext' >"+mymsg+"</p>";
                      
                      
                   }

                     calljava(message,me,friendname);
                 

            }


          

       }
    };

    ws.onclose = function(event)
    {
        
    };
     function get(msg)
     {
        
        window.location.replace("index.jsp?mess="+msg);
     }

  function  addfrienddatabase(name,owner)
  {
       $.ajax({
            type:'GET',
            data:{name:name,owner:owner},
            url:'Ajaxservlet',
            success: function(result)
            {

            }
        });
  }
    function loadname(name)
    {
        var Firstname = name.split(" ");
        add(Firstname[0]);
    }

    function offlineuser(name)
    {
        var elem = document.getElementById(name+"-online");
        elem.parentNode.removeChild(elem);
    }
    function hidebutton(name)
    {
        var elem = document.getElementById(name+"-request");
        elem.parentNode.removeChild(elem);
    }
    function addfriend(name)
    {
        
 
            var element = document.createElement("input");
            console.log(name);
            element.type = "button";
            element.value = name; 
            element.name = "button"; 
            element.id = name;
            element.className="newusers";
            element.onclick=function () 
            {
                  var x = document.getElementById(name+"-box");
                    if (x.style.display == "none") {
                        x.style.display = "block";
                    } else {
                        x.style.display = "none";
                    }
            };

            var foo = document.getElementById("fri");
            foo.appendChild(element);


             var box = document.createElement("div");
            console.log(name);
        
            box.id=name;
            box.class="box";
            
    }


    function addtable(name)
    {
        
   var me=document.getElementById('myname').innerText;
   console.log(me);

    var x = document.createElement("DIV");
    x.id=name+"-box";
    x.className="box";

    var namebox=document.createElement("DIV");
    namebox.className="name-box";

    var chatname=document.createElement("h3");
    const node = document.createTextNode(name);
    chatname.appendChild(node);

    namebox.appendChild(chatname);
     
    x.appendChild(namebox);

    var chatmsg=document.createElement("div");

    chatmsg.id=me+"-"+name;
    chatmsg.className="chat";
    
    x.appendChild(chatmsg);

    var msgbox=document.createElement("input");

    msgbox.id="msg-"+name;
    msgbox.className="msg";
    msgbox.placeholder="Enter the message";

    x.appendChild(msgbox);


    var btn=document.createElement("button");
    btn.onclick=function ()
    {
        return sendMsg(name);

    }

    btn.innerHTML="send";

    
    x.appendChild(btn);


    document.body.appendChild(x);




    }


    function filldata(message)
    {
               var me=document.getElementById('myname').innerText;
                    console.log(me );
                    console.log(message );

                    var chatname=message.split(">>");
                    var mymsg=chatname[0];
                    var myname=mymsg.split(":");
                    var namecheck=myname[0];
                    var friendname=chatname[1];

                    if(friendname===me)
                    {
                        friendname=namecheck;
                    }
                    var chatid= me+"-"+friendname;
                    console.log(chatid);
                    var mySpan = document.getElementById(chatid);

                     
                   if(!(namecheck===me))
                   {
                        mySpan.innerHTML+="<p id='text' >"+mymsg+"</p>";
                         
                       
                        notification();
                   }
                   else
                   {
                        mySpan.innerHTML+="<p id='mytext' >"+mymsg+"</p>";
                      
                      
                   }
    }


    function notification() {
				
				var mp3 = '<source src="msg.mp3" type="audio/mpeg">';
				document.getElementById("sound").innerHTML =
				'<audio autoplay="autoplay">' + mp3 + "</audio>";
			}


    function sendMsg(name) {

        console.log("sending msg");

        var id="msg-"+name;
        var msg = document.getElementById(id).value;
        if(msg)
        {
             <% String name=(String)session.getAttribute("username"); %>
             msg="<%=name%>"+">>"+msg+"("+curtime+")>>"+name;
            ws.send(msg);
        }
        document.getElementByClass("msg").value="";
    }
   
   function accept_request(name)
   {
       ws.send(name+"-accepteoiqy3addf");
   }
    
  function request(name)
  {
      <% String rname=(String)session.getAttribute("username"); %>
      var req=name+"-diuye3ur02ydpcus-"+"<%=rname%>";
      ws.send(req);
  }



function add(name)
{

    var element = document.createElement("input");
    
    element.type = "button";
    element.value = name; 
    element.name = "button"; 
    element.id = name+"-online";
    element.className="onlineusers";
    element.title="add user"
    element.onclick=function () 
            {
                  request(name);
            };


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

function calljava(message,owner,friend)
{
       $.ajax({
            type:'POST',
            data:{message:message ,owner:owner, friend:friend},
            url:'Ajaxservlet',
            success: function(result)
            {

            }
        });

}

function hidebox(name)
{
 var x = document.getElementById( name +"-box");
                    if (x.style.display == "none")
                    {
                        x.style.display = "block";
                    } 
                    else {
                        x.style.display = "none";
                    }
}

</script>



    <body>
 
  
    <input type="hidden" value="do" id="getmsg" name="getmsg"/>

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
           
            <p>Users online</p>
            <p id="fooBar"></p><br>
            <p>Friends</p>

            <% 
            
        Connection cn = null;
         Statement stt= null;
        String usernamee=(String)session.getAttribute("username");
        try {
           Class.forName("org.sqlite.JDBC");
           cn = DriverManager
              .getConnection("jdbc:sqlite:/C:/sqlite/tomcat 9090/"+usernamee+".db");

              
              cn.setAutoCommit(false);

        
       
           stt = cn.createStatement();

           ResultSet rs = cn.getMetaData().getTables(null, null, null, null);
            while (rs.next()) {
                System.out.println(rs.getString("TABLE_NAME"));
                String chat=rs.getString("TABLE_NAME");
                
                if(!(chat.equals("friends")))
                {

                
                %> <input type="button" value=<%=chat%> id=<%=chat%> class="newusers" name="button" onclick= hidebox('<%=chat%>') />
           
        <% }
        }

        stt.close();
        cn.close();

        }
        catch(Exception e)
        {
            System.out.println(e);
        }






             %>

            <p id="fri"></p><br>
            <p>Request</p>
            <p id="req"></p><br>


     </div>



  </div>
  <div id="sound"></div>
   
  <form action="./request" method=get id="request">
     
  </form>




<%


        Connection c = null;
        Connection con=null;
        Statement st= null;
        String username=(String)session.getAttribute("username");
        try {
           Class.forName("org.sqlite.JDBC");
           c = DriverManager
              .getConnection("jdbc:sqlite:/C:/sqlite/tomcat 9090/"+username+".db");

               con = DriverManager
              .getConnection("jdbc:sqlite:/C:/sqlite/tomcat 9090/"+username+".db");

            
              c.setAutoCommit(false);

        
       
           st = c.createStatement();

           ResultSet rs = c.getMetaData().getTables(null, null, null, null);
            while (rs.next()) {
                System.out.println(rs.getString("TABLE_NAME"));
                String chat=rs.getString("TABLE_NAME");
                String chatid = chat+"-box";
                String chatmsg = username+"-"+chat;
                String msgid="msg-"+chat;

              if(!(chatid.equals("friends-box")))
              {
                  
             %>

            <div class="box" id="<%=chatid%>">

    
                    <div class="name-box">
                        <h3><%=chat%></h3>
                    </div>

                    <div id="<%=chatmsg%>" class="chat">

                    <%
                     ResultSet r=null;
                Statement nst=con.createStatement();

                r=nst.executeQuery("select * from "+chat+";");
                    while(r.next())
                    {
                        String  cstr = r.getString(1);

                        String arr[]=cstr.split(">>");

                        String omsg=arr[0];
                        String friend_name=arr[1];

                        if(username.equals(friend_name))
                        {%> <p id='text' ><%=omsg%></p>

                        <% 
                        }
                        else
                        {
                        %>  <p id='mytext' ><%=omsg%></p>

                       <% }
                      
                        
                   }
                    r.close();
                   nst.close();
     %>
                    
                    </div>

                    <div>


                    <input type="text" name="msg" class="msg" id='<%=msgid%>' placeholder="Enter message here"/>
                        <button onclick="return sendMsg('<%=chat%>');">Enter</button>
                    
                    </div>
         

            </div>

              <% }



              
             
          
             
           }

           rs.close();
           st.close();
           c.close();
           con.close();
      
           
        }
        catch(Exception e)
        {
            System.out.println(e);
        }




%>

 
    </body>
</html>