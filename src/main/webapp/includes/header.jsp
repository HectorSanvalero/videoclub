<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("empleado") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String rol = (String) sesion.getAttribute("rol");
    com.svalero.videoclub.domain.Empleado empleadoActual = (com.svalero.videoclub.domain.Empleado) sesion.getAttribute("empleado");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Videoclub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<nav>
    <a href="<%= request.getContextPath() %>/peliculas"><strong>🎬 Videoclub</strong></a>

    <div style="display:flex; align-items:center; gap:8px;">
        <span style="color:#eee;">👤 <%= empleadoActual.getNombre() %> <%= empleadoActual.getApellidos() %></span>
        <span style="color:<%= "admin".equals(rol) ? "#e94560" : "#4a9eff" %>; font-size:0.85rem;">
            (<%= "admin".equals(rol) ? "Admin" : "Empleado" %>)
        </span>
    </div>

    <div>
        <a href="<%= request.getContextPath() %>/peliculas">Películas</a>
        <a href="<%= request.getContextPath() %>/clientes">Clientes</a>
        <a href="<%= request.getContextPath() %>/alquileres">Alquileres</a>
        <% if ("admin".equals(rol)) { %>
        <a href="<%= request.getContextPath() %>/empleados">Empleados</a>
        <% } %>
        <a href="<%= request.getContextPath() %>/logout">Cerrar sesión</a>
    </div>
</nav>
<div class="container">