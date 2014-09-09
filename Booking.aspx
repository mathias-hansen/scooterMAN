<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Booking.aspx.cs" Inherits="Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>page = 1</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <article id="booking">
        <section id="sel">
            <div>
                <asp:TextBox placeholder="Hvor skal du henstes?" ID="txtOri" runat="server" />
                <asp:TextBox placeholder="Hvor skal du hen?" ID="txtDest" runat="server" />
            </div>
            <div class="flex">
                <asp:Calendar ID="Calendar1" runat="server">
                    <TitleStyle BackColor="#1da2ff" ForeColor="white" />
                    <DayStyle BackColor="White" />
                    <DayHeaderStyle BackColor="White" />
                </asp:Calendar>
                <iframe id="clock" src="http://test.nanoplex.dk/clock-picker/"></iframe>
            </div>
        </section>
        <section id="map" style="opacity:0; position:fixed;">
            <google-map
                fittomarkers></google-map>
            <google-map-directions
                startaddress="Galten"
                endaddress="Århus"
                travelmode="DRIVING"></google-map-directions>
        </section>
    </article>
    <div id="distance"></div>

    <asp:Button ID="btnOrder" Text="Bestil" OnClick="btnOrder_Click" runat="server" />

    <script>
        var gmap = document.querySelector('google-map');
        gmap.addEventListener('api-load', function (e) {
            document.querySelector('google-map-directions').map = this.map;
        });

        eventFire(document.querySelector('body'),'click');

        function eventFire(el, etype) {
            if (el.fireEvent) {
                el.fireEvent('on' + etype);
            } else {
                var evObj = document.createEvent('Events');
                evObj.initEvent(etype, true, false);
                el.dispatchEvent(evObj);
            }
        }

        if ('<%=test%>' == "true") {
            document.querySelector('google-map-directions').setAttribute('startaddress', document.querySelector('#ContentPlaceHolder1_txtOri').value);
            document.querySelector('google-map-directions').setAttribute('endaddress', document.querySelector('#ContentPlaceHolder1_txtDest').value);
            document.querySelector('#map').removeAttribute('style');
             
        }
        var json = <%=json%>
        document.querySelector('#distance').innerHTML = json.rows[0].elements[0].distance.text;

        document.querySelector('#distance').innerHTML += "<br>" + '<%=date%>';
    </script>
</asp:Content>

