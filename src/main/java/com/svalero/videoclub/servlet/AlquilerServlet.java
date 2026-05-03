package com.svalero.videoclub.servlet;

import com.svalero.videoclub.dao.AlquilerDao;
import com.svalero.videoclub.dao.ClienteDao;
import com.svalero.videoclub.dao.EmpleadoDao;
import com.svalero.videoclub.dao.PeliculaDao;
import com.svalero.videoclub.domain.Alquiler;
import com.svalero.videoclub.domain.Pelicula;
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

                case "search":
                    String estado = request.getParameter("estado") != null ? request.getParameter("estado") : "";
                    String fechaInicio = request.getParameter("fechaInicio") != null ? request.getParameter("fechaInicio") : "";
                    List<Alquiler> resultados = alquilerDao.search(estado, fechaInicio);
                    request.setAttribute("alquileres", resultados);
                    request.setAttribute("peliculas", peliculaDao.findAll());
                    request.setAttribute("clientes", clienteDao.findAll());
                    request.setAttribute("estado", estado);
                    request.setAttribute("fechaInicio", fechaInicio);
                    request.getRequestDispatcher("/list-alquileres.jsp").forward(request, response);
                    break;

                case "devolver":
                    int idDevolver = Integer.parseInt(request.getParameter("id"));
                    Alquiler alquilerDevolver = alquilerDao.findById(idDevolver);
                    alquilerDevolver.setEstado("devuelto");
                    alquilerDevolver.setFechaDevolucion(LocalDate.now());
                    alquilerDao.update(alquilerDevolver);
                    PeliculaDao peliculaDaoDevolver = new PeliculaDao();
                    peliculaDaoDevolver.aumentarStock(alquilerDevolver.getIdPelicula());
                    response.sendRedirect(request.getContextPath() + "/alquileres");
                    break;

                case "eliminar":
                    int idEliminar = Integer.parseInt(request.getParameter("id"));
                    boolean eliminado = alquilerDao.eliminar(idEliminar);
                    if (!eliminado) {
                        request.setAttribute("error", "Imposible eliminar. No se ha podido eliminar este alquiler.");
                        List<Alquiler> alquileresError = alquilerDao.findAll();
                        request.setAttribute("alquileres", alquileresError);
                        request.setAttribute("peliculas", peliculaDao.findAll());
                        request.setAttribute("clientes", clienteDao.findAll());
                        request.getRequestDispatcher("/list-alquileres.jsp").forward(request, response);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/alquileres");
                    }
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
            PeliculaDao peliculaDao = new PeliculaDao();
            HttpSession session = request.getSession();

            int idPelicula = Integer.parseInt(request.getParameter("idPelicula"));
            Pelicula pelicula = peliculaDao.findById(idPelicula);

            if (pelicula.getStock() <= 0) {
                request.setAttribute("error", "No hay stock disponible de esta película.");
                request.setAttribute("peliculas", peliculaDao.findAll());
                request.setAttribute("clientes", new com.svalero.videoclub.dao.ClienteDao().findAll());
                request.getRequestDispatcher("/form-alquiler.jsp").forward(request, response);
                return;
            }

            Alquiler alquiler = new Alquiler();
            alquiler.setIdPelicula(idPelicula);
            alquiler.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
            alquiler.setIdEmpleado(((com.svalero.videoclub.domain.Empleado) session.getAttribute("empleado")).getId());

            String fechaInicio = request.getParameter("fechaInicio");
            String fechaDevolucion = request.getParameter("fechaDevolucion");

            alquiler.setFechaInicio(LocalDate.parse(fechaInicio));
            if (fechaDevolucion != null && !fechaDevolucion.isEmpty()) {
                alquiler.setFechaDevolucion(LocalDate.parse(fechaDevolucion));
            }
            alquiler.setEstado("activo");
            alquiler.setPrecio(Double.parseDouble(request.getParameter("precio")));

            alquilerDao.save(alquiler);
            peliculaDao.reducirStock(idPelicula);
            response.sendRedirect(request.getContextPath() + "/alquileres");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}