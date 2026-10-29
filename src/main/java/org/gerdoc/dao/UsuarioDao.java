package org.gerdoc.dao;

import org.gerdoc.model.Usuario;

import java.util.List;

public interface UsuarioDao
{
    List<Usuario> findAll( );
    Usuario findById(Long id);
    Usuario save(Usuario usuario);
    void deleteById(Long id);
    Usuario update(Usuario usuario);
}
