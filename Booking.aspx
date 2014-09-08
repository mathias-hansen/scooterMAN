<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Booking.aspx.cs" Inherits="Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>page = 1</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Bestil en tid</h1>
    <asp:TextBox ID="txtFrom" placeholder="Hvor skal du hentes?" runat="server" />
    <asp:TextBox ID="txtTo" placeholder="Hvor skal du hen?" runat="server" />
</asp:Content>

