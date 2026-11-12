<%@ Page Title="" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="EsteticaWeb.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="imagen-inicio text-white py-5" style="min-height: 100vh;">
        <div class="container">

            <div class="col-12 col-md-8 col-lg-6 bg-dark bg-opacity-75 rounded-4 p-4 p-md-5 shadow mb-5">
                <h1 class="display-5 fw-semibold mb-3 text-white">Turnos Estetica</h1>
                <p class="lead mb-0 text-white">
                    Sistema para administrar turnos y clientes
               
                </p>
            </div>

            <div class="row row-cols-1 row-cols-md-3 g-4">

                <div class="col">
                    <div class="card h-100 bg-dark bg-opacity-75 text-white border-0 rounded-4 shadow">
                        <img src="Recursos/Imagenes/manicura.jpg" class="card-img-top rounded-top-4" alt="Manicura">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">Manicura</h5>
                            <p class="card-text">Tratamiento cosmético y de higiene enfocado en el cuidado, embellecimiento y salud de las manos y las uñas..</p>
                            <a href="#" class="btn btn-outline-light mt-auto">Ver más</a>
                        </div>
                    </div>
                </div>
          
                <div class="col">
                    <div class="card h-100 bg-dark bg-opacity-75 text-white border-0 rounded-4 shadow">
                        <img src="Recursos/Imagenes/lifting.jpg"
                            class="card-img-top rounded-top-4 "
                            style="height: 200px;"
                            alt="Lifting">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">Lifting</h5>
                            <p class="card-text">
                                Tratamiento estético que eleva, curva y estira tus pestañas naturales .
                                En lugar de rizarlas de manera temporal o añadir pestañas postizas, este procedimiento reestructura el vello para darle una apariencia más larga, espesa y con mayor volumen de forma natural
                            </p>
                            <a href="#" class="btn btn-outline-light mt-auto">Ver más</a>
                        </div>
                    </div>
                </div>

                <div class="col">
                    <div class="card h-100 bg-dark bg-opacity-75 text-white border-0 rounded-4 shadow">
                        <img src="https://purificacioncaballero.com/wp-content/uploads/21.jpg" class="card-img-top rounded-top-4" alt="...">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">Limpieza facial</h5>
                            <p class="card-text">Tratamiento dermatológico diseñado para purificar la piel del rostro en profundidad. Buscamos eliminar el exceso de sebo, células muertas, impurezas, puntos negros y restos de maquillaje o contaminación acumulados en los poros.</p>
                            <a href="#" class="btn btn-outline-light mt-auto">Ver más</a>
                        </div>
                    </div>
                </div>

                <div class="col">
                    <div class="card h-100 bg-dark bg-opacity-75 text-white border-0 rounded-4 shadow">
                        <img src="Recursos/Imagenes/depilacionlaser.jpg"
                            class="card-img-top rounded-top-4"
                            style="height: 200px;"
                            alt="...">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">Depilacion laser</h5>
                            <p class="card-text">
                                Procedimiento médico y estético que utiliza un haz de luz concentrado (láser) para reducir o eliminar el vello no deseado.
                                
                            </p>
                            <a href="#" class="btn btn-outline-light mt-auto">Ver más</a>
                        </div>
                    </div>
                </div>

                <div class="col">
                    <div class="card h-100 bg-dark bg-opacity-75 text-white border-0 rounded-4 shadow">
                        <img src="Recursos/Imagenes/electrodos.jpg"
                            class="card-img-top rounded-top-4"
                            style="height: 200px;"
                            alt="...">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">Electrodos</h5>
                            <p class="card-text">Tratamientos de electroestimulación (corporal) o de alta frecuencia (facial) que utilizan corrientes eléctricas suaves para tonificar músculos o mejorar la piel..</p>
                            <a href="#" class="btn btn-outline-light mt-auto">Ver más</a>
                        </div>
                    </div>
                </div>

                <div class="col">
                    <div class="card h-100 bg-dark bg-opacity-75 text-white border-0 rounded-4 shadow">
                        <img src="https://via.placeholder.com/400x200"
                            class="card-img-top rounded-top-4"
                            style="height: 200px;"
                            alt="...">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">En camino...</h5>
                            <p class="card-text">Descripción breve del tratamiento o servicio.</p>
                            <a href="#" class="btn btn-outline-light mt-auto">Ver más</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


</asp:Content>

