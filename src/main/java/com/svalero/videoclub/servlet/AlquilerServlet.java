package com.svalero.videoclub.servlet;

import com.svalero.videoclub.dao.AlquilerDao;
import com.svalero.videoclub.dao.ClienteDao;
import com.svalero.videoclub.dao.EmpleadoDao;
import com.svalero.videoclub.dao.PeliculaDao;
import com.svalero.videoclub.domain.Alquiler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/alquileres")
public class AlquilerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            AlquilerDao alquilerDao = new AlquilerDao();
            PeliculaDao peliculaDao = new PeliculaDao();
            ClienteDao clienteDao = new ClienteDao();
            EmpleadoDao empleadoDao = new EmpleadoDao();

            switch (action) {
                case "new":
                    request.setAttribute("peliculas", peliculaDao.findAll());
                    request.setAttribute("clientes", clienteDao.findAll());
                    request.getRequestDispatcher("/form-alquiler.jsp").forward(request, response);
                    break;

                case "devolver":
                    int idDevolver = Integer.parseInt(request.getParameter("id"));
                    Alquiler alquilerDevolver = alquilerDao.findById(idDevolver);
                    alquilerDevolver.setEstado("devuelto");
                    alquilerDevolver.setFechaDevolucion(LocalDate.now());
                    alquilerDao.update(alquilerDevolver);
                    response.sendRedirect(request.getContextPath() + "/alquileres");
                    break;

                default:
                    List<Alquiler> alquileres = alquilerDao.findAll();
                    request.setAttribute("alquileres", alquileres);
                    request.setAttribute("peliculas", peliculaDao.findAll());
                    request.setAttribute("clientes", clienteDao.findAll());
                    request.getRequestDispatcher("/list-alquileres.jsp").forward(request, response);
                    break;
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            AlquilerDao alquilerDao = new AlquilerDao();
            HttpSession session = request.getSession();

            Alquiler alquiler = new Alquiler();
            alquiler.setIdPelicula(Integer.parseInt(request.getParameter("idPelicula")));
            alquiler.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
            alquiler.setIdEmpleado(((com.svalero.videoclub.domain.Empleado) session.getAttribute("empleado")).getId());
            alquiler.setFechaInicio(LocalDate.now());
            alquiler.setEstado("activo");

            alquilerDao.save(alquiler);
            response.sendRedirect(request.getContextPath() + "/alquileres");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}