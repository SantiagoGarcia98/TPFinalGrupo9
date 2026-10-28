<%@ Page Title="" Language="C#" MasterPageFile="~/MiMaster.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EsteticaWeb.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-8 mx-auto ">
            <br />
            <label for="txtmail" class="form-label mb-2">Correo electronico</label>        
            <asp:TextBox ID="txtmail" runat="server" class="form-control" placeholder="nombre@ejemplo.com"></asp:TextBox>
            <br />
        <div>
            <label for="txtpass"" class="form-label">Contraseña</label>                
            <asp:TextBox ID="txtpass" runat="server" type="password" class="form-control" placeholder="Ingrese la contraseña" ></asp:TextBox>
            <div class="strength-bar" data-bs-strength=""></div>
        </div>
            <br />           
            <asp:Button ID="BtnIngresar" runat="server" class="btn" Text="Ingresar" />
            <div class="vstack gap-2">
                <br />
      <a class="theme-secondary" href="#">Registrate</a>
      <a class="theme-secondary" href="#">Has olvidado la contraseña?</a>
    </div>
        </div>
    </div>
    

</asp:Content>
