        <%@ Page Title="" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="MenuCliente.aspx.cs" Inherits="EsteticaWeb.MenuCliente" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

            <style>
                .cliente-bienvenida {
                    text-align: center;
                    padding: 40px 20px;
                    background: linear-gradient(135deg, #f8f1ff, #ffffff);
                    border-radius: 20px;
                    margin: 30px auto;
                    max-width: 1000px;
                }

                .cliente-bienvenida h1 {
                    color: #512b79;
                    font-size: 38px;
                    font-weight: bold;
                    margin-bottom: 10px;
                }

                .cliente-bienvenida p {
                    color: #666;
                    font-size: 18px;
                }

                .cliente-botones {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        gap: 25px;
                        flex-wrap: wrap;
                        margin: 30px auto;
                }


                .cliente-card-solicitar {
                    background: linear-gradient(135deg, #9845d9, #512b79);
                    color: white;
                    border: none;
                    border-radius: 18px;
                    width: 260px;
                    height: 190px;
                    font-size: 22px;
                    font-weight: bold;
                    cursor: pointer;
                    box-shadow: 0 8px 20px rgba(81, 43, 121, 0.25);
                    transition: transform 0.3s, box-shadow 0.3s;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    gap: 12px;
                    text-decoration: none;
                    text-align: center;
                    padding: 20px;
                    box-sizing: border-box;
                }

                .cliente-card-solicitar:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 12px 25px rgba(81, 43, 121, 0.35);
                }

                .cliente-card-misturnos {
                    background: white;
                    color: #512b79;
                    border: 2px solid #d9c4ed;
                    border-radius: 18px;
                    width: 260px;
                    height: 190px;
                    font-size: 22px;
                    font-weight: bold;
                    cursor: pointer;
                    box-shadow: 0 8px 20px rgba(81, 43, 121, 0.12);
                    transition: transform 0.3s, box-shadow 0.3s;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    gap: 12px;
                    text-decoration: none;
                    text-align: center;
                    padding: 20px;
                    box-sizing: border-box;
                }

                .cliente-card-misturnos:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 12px 25px rgba(81, 43, 121, 0.25);
                }


                .cliente-icono {
                    font-size: 38px;
                }

                .cliente-card-solicitar small {
                    font-size: 14px;
                    font-weight: normal;
                    line-height: 1.5;
                }

                .cliente-card-solicitar:hover {
                    color: white;
                    text-decoration: none;
                }


                .cliente-card-misturnos small {
                    font-size: 14px;
                    font-weight: normal;
                    line-height: 1.5;
                }

                .cliente-card-misturnos:hover {
                    color: #512b79;
                    text-decoration: none;
                }

                .cliente-linea {
                    width: 70px;
                    height: 4px;
                    background-color: #8f45c7;
                    border-radius: 10px;
                    margin: 20px auto 0;
                }


                .cliente-fondo {
                    background-image:
                        linear-gradient(
                        rgba(255, 255, 255, 0.25),
                        rgba(248, 240, 255, 0.45)
                    ),
                    url('Recursos/Imagenes/fondo-estetimed.png');

                    background-size: cover;
                    background-position: center;
                    background-repeat: no-repeat;

                    min-height: 600px;
                    max-width: 1100px;

                    margin: 30px auto;
                    padding: 30px 20px;

                    border-radius: 22px;
                    box-sizing: border-box;
                }
            </style>

        </asp:Content>

        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div class="cliente-fondo">
            <div class="cliente-bienvenida">

            <h1>Bienvenido a EstetiMed</h1>

            <p>Gestioná tus turnos de forma rápida y sencilla</p>

        <div class="cliente-linea"></div>

        </div>
            <br />
            <asp:Panel ID="Panel1" runat="server">
            </asp:Panel>
            <asp:Panel ID="pnlSolicitarTurno" runat="server"
            HorizontalAlign="Center"
            CssClass="cliente-botones">
           <a href="SolicitudTurno.aspx" class="cliente-card-solicitar">

            <span class="cliente-icono">📅</span>

            <strong>Solicitar Turno</strong>
                                                                                
            <small>Elegí el tratamiento, la fecha y el horario</small>

        </a>
                <asp:Panel ID="pnlMisTurnos" runat="server">
           <a href="ListaTurnosClientes.aspx" class="cliente-card-misturnos">

            <span class="cliente-icono">📋</span>

            <strong>Mis turnos</strong>

            <small>Consultá tus turnos y revisá su estado</small>

        </a>
            </asp:Panel>
        </asp:Panel>

        </div>

</asp:Content>
