<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.videoclub.domain.Pelicula" %>
<%@ page import="com.svalero.videoclub.domain.Cliente" %>
<%@ include file="includes/header.jsp" %>

<%
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
%>

<h1>Nuevo alquiler</h1>

<div class="card">
    <form action="<%= request.getContextPath() %>/alquileres" method="post">

        <div class="form-group">
            <label>Película</label>
            <select name="idPelicula" required>
                <option value="">Selecciona una película</option>
                <%
                    if (peliculas != null) {
                        for (Pelicula p : peliculas) {
                            if (p.isDisponible()) {
                %>
                <option value="<%= p.getId() %>"><%= p.getTitulo() %></option>
                <%
                            }
                        }
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label>Cliente</label>
            <select name="idCliente" required>
                <option value="">Selecciona un cliente</option>
                <%
                    if (clientes != null) {
                        for (Cliente c : clientes) {
                            if (c.isActivo()) {
                %>
                <option value="<%= c.getId() %>"><%= c.getNombre() %> <%= c.getApellidos() %></option>
                <%
                            }
                        }
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label>Fecha de inicio</label>
            <input type="date" name="fechaInicio" required>
        </div>

        <div class="form-group">
            <label>Fecha de devolución prevista</label>
            <input type="date" name="fechaDevolucion">
        </div>

        <div style="display:flex; gap:10px;">
            <button type="submit" class="btn btn-primary">Crear alquiler</button>
            <a href="<%= request.getContextPath() %>/alquileres" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<%@ include file="includes/footer.jsp" %>