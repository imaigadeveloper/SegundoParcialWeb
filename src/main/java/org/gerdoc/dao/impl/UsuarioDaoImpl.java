package org.gerdoc.dao.impl;

import org.gerdoc.dao.UsuarioDao;
import org.gerdoc.model.Usuario;
import org.gerdoc.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import java.util.List;

public class UsuarioDaoImpl implements UsuarioDao
{
    private Session session;

    public UsuarioDaoImpl( )
    {
        session = HibernateUtil
                .getSessionFactory( )
                .openSession( );
    }

    @Override
    public List<Usuario> findAll()
    {
        CriteriaBuilder builder = session.getCriteriaBuilder();

        CriteriaQuery<Usuario> criteria =
                builder.createQuery(Usuario.class);
        criteria.from(Usuario.class);
        return session
                .createQuery(criteria)
                .getResultList();
    }

    @Override
    public Usuario findById(Long id)
    {
        return session.get( Usuario.class, id );
    }

    @Override
    public Usuario save(Usuario usuario)
    {
        Transaction transaction = null;
        try
        {
            transaction = session.beginTransaction();
            session.save( usuario );
            transaction.commit( );
            return usuario;
        }
        catch (Exception e)
        {
            e.printStackTrace();
            transaction.rollback( );
            return null;
        }
    }

    @Override
    public void deleteById(Long id)
    {
        Transaction transaction = null;
        Usuario usuario = null;
        try
        {
            usuario = findById( id );
            if( usuario != null )
            {
                transaction = session.beginTransaction();
                session.delete( usuario );
                transaction.commit( );
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            transaction.rollback( );
        }
    }

    @Override
    public Usuario update(Usuario usuario)
    {
        Transaction transaction = null;
        Usuario updatedUsuario = null;
        try
        {
            transaction = session.beginTransaction();
            updatedUsuario = (Usuario) session.merge( usuario );
            transaction.commit( );
            return updatedUsuario;
        }
        catch (Exception e)
        {
            e.printStackTrace();
            transaction.rollback( );
            return null;
        }
    }
}
