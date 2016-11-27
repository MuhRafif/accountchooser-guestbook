<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<html>
  <head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  </head>

  <body>

<%
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
<<<<<<< HEAD

	if (session.getAttribute("user_id") != null) { 
=======
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
>>>>>>> parent of f00c73b... Updated Guestbook to include a very simple home-grown user managment
%>
<p>Hello, <%= user.getNickname() %>! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
<<<<<<< HEAD
<p>Hello. This is the AccountChooser Guestbook java sample application. 
</p>
<p>Once you <a href="/account-login.jsp">sign in</a> 
   you can include your name and photo with greetings you post.</p>
=======
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to include your name with greetings you post.</p>
>>>>>>> parent of f00c73b... Updated Guestbook to include a very simple home-grown user managment
<%
    }
%>
<%
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);
    // Run an ancestor query to ensure we see the most up-to-date
    // view of the Greetings belonging to the selected Guestbook.
    Query query = new Query("Greeting", guestbookKey).addSort("date", Query.SortDirection.DESCENDING);
    List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
    if (greetings.isEmpty()) {
        %>
        <p>Guestbook '<%= guestbookName %>' has no messages.</p>
        <%
    } else {
        %>
        <p>Messages in Guestbook '<%= guestbookName %>'.</p>
<<<<<<< HEAD
        <table border="1"><tr><td>
        
=======
>>>>>>> parent of f00c73b... Updated Guestbook to include a very simple home-grown user managment
        <%
        for (Entity greeting : greetings) {
            if (greeting.getProperty("user") == null) {
                %>
                <p>An anonymous person wrote:</p>
                <%
            } else {
                %>
<<<<<<< HEAD
                <p><%= UserServlet.getPhotoTag((String) greeting.getProperty("photo")) %>
                <b><%= greeting.getProperty("user") %></b> wrote:</p>
=======
                <p><b><%= ((User) greeting.getProperty("user")).getNickname() %></b> wrote:</p>
>>>>>>> parent of f00c73b... Updated Guestbook to include a very simple home-grown user managment
                <%
            }
            %>
            <blockquote><%= greeting.getProperty("content") %></blockquote>
            <%
        }
    }
%>
</td></tr>
</table>
    <form action="/sign" method="post">
      <div><textarea name="content" rows="3" cols="60"></textarea></div>
      <div><input type="submit" value="Post Greeting" /></div>
      <input type="hidden" name="guestbookName" value="<%= guestbookName %>"/>
    </form>

    <form action="/guestbook.jsp" method="get">
      <div><input type="text" name="guestbookName" value="<%= guestbookName %>"/></div>
      <div><input type="submit" value="Switch Guestbook" /></div>
    </form>

  </body>
</html>