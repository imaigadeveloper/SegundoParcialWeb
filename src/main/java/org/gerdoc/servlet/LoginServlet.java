package org.gerdoc.servlet;

import org.gerdoc.model.Materia;
import org.gerdoc.model.Profesor;
import org.gerdoc.model.ProfesorMateria;
import org.gerdoc.service.MateriaService;
import org.gerdoc.service.ProfesorMateriaService;
import org.gerdoc.service.UsuarioService;
import org.gerdoc.service.impl.MateriaServiceImpl;
import org.gerdoc.service.impl.ProfesorMateriaServiceImpl;
import org.gerdoc.service.impl.ProfesorServiceImpl;
import org.gerdoc.service.impl.UsuarioServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serial;

@WebServlet("/ProfesorMateriaServlet")
public class LoginServlet extends HttpServlet
{
    @Serial
    private static final long serialVersionUID = 1L;
    private final ProfesorMateriaService profesorMateriaService = new ProfesorMateriaServiceImpl( );
    private final RolService rolService = new ProfesorServiceImpl( );
    private final UsuarioService usuarioService = new UsuarioServiceImpl( );

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String accion = req.getParameter("accion");
        if ("delete".equals(accion))
        {
            Long id = Long.parseLong( req.getParameter("id" ) );
            profesorMateriaService.deleteById( id );
            resp.sendRedirect("ProfesorMaterias.jsp" );
            return;
        }
        Long profesorId = Long.parseLong( req.getParameter("profesorId" ) );
        Long materiaId = Long.parseLong( req.getParameter("materiaId" ) );
        Long id = Long.parseLong( req.getParameter("id" ) );
        Profesor profesor = profesorService.findById( profesorId );
        Materia materia = materiaService.findById( materiaId );

        ProfesorMateria profesorMateria = ProfesorMateria.builder( )
                .materia(materia)
                .profesor(profesor)
                .build();
        if( "update".equals(accion) )
        {
            profesorMateria.setId( id );
            profesorMateriaService.update( profesorMateria );
        }
        else
        {
            profesorMateriaService.save( profesorMateria );
        }
        resp.sendRedirect("ProfesorMaterias.jsp");
    }
}
