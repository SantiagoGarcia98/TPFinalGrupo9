using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using dominio;
using negocio;
using System.Runtime.CompilerServices;

namespace WindowsFormsApp
{
    public class DataArticulo
    {
        public List<Articulo> ListarArticulo()
        {
            List <Articulo> list = new List<Articulo>();
            SqlConnection conexion = new SqlConnection();
            SqlCommand comando = new SqlCommand();
            SqlDataReader lector;

            try
            {

                

                conexion.ConnectionString = "server = localhost\\SQLEXPRESS; database = CATALOGO_P3_DB; integrated security = true; ";
                comando.CommandType = System.Data.CommandType.Text;
                comando.CommandText = ("select A.id, A.codigo,A.nombre, A.descripcion, A.idMarca,M.Descripcion as marca, A.idcategoria,C.Descripcion as categoria,A.precio from articulos A Left join Marcas M on a.idmarca=m.id left join categorias c on a.idcategoria = c.id");
                comando.Connection = conexion;

                conexion.Open();
                lector = comando.ExecuteReader();

                while (lector.Read())
                {
                    Articulo aux = new Articulo();
                    aux.id = (int)lector["id"];
                    aux.Codigo = (string)lector["codigo"];
                    aux.Nombre = (string)lector["nombre"];
                    aux.Descripcion = (string)lector["descripcion"];

                    aux.NombreMarca = new Marca();
                    if (lector["idMarca"] != DBNull.Value)
                        aux.NombreMarca.Id = (int)lector["idMarca"];
                    aux.NombreMarca.descripcion = lector["Marca"] != DBNull.Value //Dejo este comentario aca para explicar que hice : // "¿la columna Marca tiene algo?"
                        ? (string)lector["Marca"] // si: usa ese texto
                        : ""; // el : significa que no: entonces devuelve "";

                    aux.TipoCategoria = new Categoria();
                    if (lector["IdCategoria"] != DBNull.Value)
                        aux.TipoCategoria.Id = (int)lector["IdCategoria"];
                    aux.TipoCategoria.descripcion = lector["Categoria"] != DBNull.Value
                        ? (string)lector["Categoria"]
                        : "";
                    //aux.NombreMarca.Id =(int)lector["idMarca"];

                    aux.Precio = (decimal)lector["precio"];

                    

                    List<Imagen> imagenes = obtenerImagen(aux.id);
                    if (imagenes.Count > 0)
                    {
                        aux.urlImagen = imagenes;
                        
                         
                    }
                    list.Add(aux);
                }
              
                
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conexion.Close();
            }


            }
        public List<Imagen>obtenerImagen(int id)
        {
            List<Imagen> listadoImagen = new List<Imagen>();
            AccesoSQL datos = new AccesoSQL();
            datos.setConsulta("select i.id, i.imagenUrl, a.Id articulo from imagenes i, articulos a where a.Id = i.IdArticulo");
            try
            {
                datos.ConsultaBD();
                while (datos.Lector.Read())
                {
                    int articulos = (int)datos.Lector["articulo"];
                    if (articulos == id)
                    {
                        Imagen imagen = new Imagen();
                        imagen.Id = (int)datos.Lector["id"];
                        imagen.IdArticulo = articulos;
                        imagen.Url = (string)datos.Lector["imagenurl"];
                        listadoImagen.Add(imagen);
                    }
                }
                return listadoImagen;
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ModificarArticulo(Articulo articulo)
        {
            AccesoSQL datos = new AccesoSQL();

            try
            {
                datos.setConsulta(
                    "UPDATE ARTICULOS " +
                    "SET Codigo = @codigo, " +
                    "Nombre = @nombre, " +
                    "Descripcion = @descripcion, " +
                    "IdMarca = @idMarca, " +
                    "IdCategoria = @idCategoria, " +
                    "Precio = @precio " +
                    "WHERE Id = @id"
                );

                datos.setParametro("@codigo", articulo.Codigo);
                datos.setParametro("@nombre", articulo.Nombre);
                datos.setParametro("@descripcion", articulo.Descripcion);
                datos.setParametro("@idMarca", articulo.NombreMarca.Id);
                datos.setParametro("@idCategoria", articulo.TipoCategoria.Id);
                datos.setParametro("@precio", articulo.Precio);
                datos.setParametro("@id", articulo.id);

                datos.ejecutarAccion();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void AgregarArticulo(Articulo articulo)
        {
            AccesoSQL datos = new AccesoSQL();
            try
            {
                ObtenerMarcayCategoria(articulo);
                datos.setConsulta("insert into articulos (Codigo,Nombre,Descripcion,IdMarca,IdCategoria,Precio) values(@Codigo,@Nombre,@Descripcion,@IdMarca,@IdCategoria,@Precio)");
                datos.setParametro("@codigo", articulo.Codigo);
                datos.setParametro("@nombre", articulo.Nombre);
                datos.setParametro("@descripcion", articulo.Descripcion);
                datos.setParametro("@idMarca", articulo.NombreMarca.Id);
                datos.setParametro("@idCategoria", articulo.TipoCategoria.Id);
                datos.setParametro("@precio", articulo.Precio);
                datos.setParametro("@id", articulo.id);
                datos.ejecutarAccion();
                AgregarImagen(articulo.urlImagen);                
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        private void ObtenerMarcayCategoria(Articulo nuevo)
        {
            AccesoSQL datos = new AccesoSQL();
            datos.setConsulta("select c.id IDCategoria, m.id IDMarca from categorias c, marcas m where m.Descripcion=@nombreMarca and c.Descripcion=@nombreCategoria");
            datos.setParametro("@nombreMarca", nuevo.NombreMarca.descripcion);
            datos.setParametro("@nombreCategoria", nuevo.TipoCategoria.descripcion);
            try
            {
                datos.ConsultaBD();
                if (datos.Lector.Read())
                {
                    nuevo.TipoCategoria.Id = (int)datos.Lector["IDCategoria"];
                    nuevo.NombreMarca.Id = (int)datos.Lector["IDMarca"];
                }
            }
            catch (Exception ex)
            {

                throw ex ;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        private void AgregarImagen(List<Imagen> imagenes)
        {
            int id = UltimoArticulo();
            foreach (Imagen aux in imagenes)
            {
                AccesoSQL datos = new AccesoSQL();
                datos.setConsulta("insert into imagenes (IdArticulo,ImagenUrl) values(@idArticulo,@UrlImagen)");
                datos.setParametro("@idArticulo", id);
                datos.setParametro("@UrlImagen", aux.Url);
                try
                {
                    datos.ejecutarAccion();
                }
                catch (Exception ex)
                {

                    throw ex;
                }
                finally 
                {
                    datos.cerrarConexion(); 
                }

            }
        }
        private int UltimoArticulo()
        {
            AccesoSQL datos = new AccesoSQL();
            datos.setConsulta("select id from articulos");
            int id = 0;
            try
            {
                datos.ConsultaBD();
                while (datos.Lector.Read()) 
                {
                    id = (int)datos.Lector["id"];
                } 
                return id;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        


    }
}
