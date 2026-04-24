package com.svalero.videoclub.servlet;

import com.svalero.videoclub.dao.ClienteDao;
import com.svalero.videoclub.domain.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            ClienteDao clienteDao = new ClienteDao();

            switch (action) {
                case "view":
                    int idView = Integer.parseInt(request.getParameter("id"));
                    Cliente cliente = clienteDao.findById(idView);
                    request.setAttribute("cliente", cliente);
                    request.getRequestDispatcher("/view-cliente.jsp").forward(request, response);
                    break;

                case "new":
                    request.getRequestDispatcher("/form-cliente.jsp").forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    Cliente clienteEdit = clienteDao.findById(idEdit);
                    request.setAttribute("cliente", clienteEdit);
                    request.getRequestDispatcher("/form-cliente.jsp").forward(request, response);
                    break;

                case "delete":
                    int idDelete = Integer.parseInt(request.getParameter("id"));
                    clienteDao.delete(idDelete);
                    response.sendRedirect(request.getContextPath() + "/clientes");
                    break;

                case "eliminar":
                    int idEliminar = Integer.parseInt(request.getParameter("id"));
                    boolean eliminado = clienteDao.eliminar(idEliminar);
                    if (!eliminado) {
                        request.setAttribute("error", "Imposible eliminar. Existen alquileres vinculados a este cliente.");
                        List<Cliente> clientesError = clienteDao.findAll();
                        request.setAttribute("clientes", clientesError);
                        request.getRequestDispatcher("/list-clientes.jsp").forward(request, response);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/clientes");
                    }
                    break;

                case "search":
                    String nombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
                    String apellidos = request.getParameter("apellidos") != null ? request.getParameter("apellidos") : "";
                    List<Cliente> resultados = clienteDao.search(nombre, apellidos);
                    request.setAttribute("clientes", resultados);
                    request.setAttribute("nombre", nombre);
                    request.setAttribute("apellidos", apellidos);
                    request.getRequestDispatcher("/list-clientes.jsp").forward(request, response);
                    break;

                default:
                    List<Cliente> clientes = clienteDao.findAll();
                    request.setAttribute("clientes", clientes);
                    request.getRequestDispatcher("/list-clientes.jsp").forward(request, response);
                    break;
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            ClienteDao clienteDao = new ClienteDao();
            Cliente cliente = new Cliente();

            cliente.setNombre(request.getParameter("nombre"));
            cliente.setApellidos(request.getParameter("apellidos"));
            cliente.setEmail(request.getParameter("email"));
            cliente.setTelefono(request.getParameter("telefono"));
            cliente.setActivo(true);

            if ("edit".equals(action)) {
                cliente.setId(Integer.parseInt(request.getParameter("id")));
                clienteDao.update(cliente);
            } else {
                clienteDao.save(cliente);
            }

            response.sendRedirect(request.getContextPath() + "/clientes");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
