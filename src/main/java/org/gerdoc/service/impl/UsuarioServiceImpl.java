package org.gerdoc.service.impl;

import org.gerdoc.dao.UsuarioDao;
import org.gerdoc.dao.impl.UsuarioDaoImpl;
import org.gerdoc.model.Usuario;
import org.gerdoc.service.UsuarioService;

import java.util.List;

public class UsuarioServiceImpl implements UsuarioService
{
    private UsuarioDao usuarioDao;

    public UsuarioServiceImpl( )
    {
        this.usuarioDao = new UsuarioDaoImpl( );
    }

    @Override
    public List<Usuario> findAll()
    {
        return usuarioDao.findAll( );
    }

    @Override
    public Usuario findById(Long id)
    {
        return usuarioDao.findById( id );
    }

    @Override
    public void save(Usuario usuario)
    {
        usuarioDao.save( usuario );
    }

    @Override
    public void deleteById(Long id)
    {
        usuarioDao.deleteById( id );
    }

    @Override
    public void update(Usuario usuario)
    {
        usuarioDao.update( usuario );
    }
}
