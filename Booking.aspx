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
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Calendar ID="Calendar1" runat="server">
                            <TitleStyle BackColor="#1da2ff" ForeColor="white" />
                            <NextPrevStyle ForeColor="White" />
                            <DayStyle BackColor="White" />
                            <DayHeaderStyle BackColor="White" />
                        </asp:Calendar>
                    </ContentTemplate>
                </asp:UpdatePanel>
                
                <div class="input-group clockpicker" data-align="top" data-autoclose="true">
                    <input id="inputTime" type="text" class="form-control" onfocus="$(this).blur();" runat="server" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-time"></span>
                    </span>
                </div>
                <div id="clock"></div>
                <script type="text/javascript">
                    $('.clockpicker').clockpicker({
                        afterHourSelect: function () {
                            document.querySelector('#ContentPlaceHolder1_inputTime').value = document.querySelector('.clockpicker-span-hours').innerHTML + ":" + document.querySelector('.clockpicker-span-minutes').innerHTML;
                        },
                        afterDone: function () {
                            document.querySelector('#ContentPlaceHolder1_inputTime').value = document.querySelector('.clockpicker-span-hours').innerHTML + ":" + document.querySelector('.clockpicker-span-minutes').innerHTML;
                        },
                    });
                    $('.form-control').focus();
                </script>
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
    <div id="status"></div>
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
        

        var json = <%=json%>
        console.log(json);
        if (json.status == "OK") {
            document.querySelector('#status').innerHTML = "";
            if ('<%=test%>' == "true") {
                if ('<%=time%>' != document.querySelector('#ContentPlaceHolder1_inputTime').value) {
                    document.querySelector('#ContentPlaceHolder1_inputTime').value = '<%=time%>';
                }
                 
                document.querySelector('google-map-directions').setAttribute('startaddress', document.querySelector('#ContentPlaceHolder1_txtOri').value);
                document.querySelector('google-map-directions').setAttribute('endaddress', document.querySelector('#ContentPlaceHolder1_txtDest').value);
                document.querySelector('#map').removeAttribute('style');
             
            }
        
            document.querySelector('#distance').innerHTML = json.rows[0].elements[0].distance.text;

            document.querySelector('#distance').innerHTML += "<br>" + '<%=date%>';

            document.querySelector('#distance').innerHTML += "<br>" + '<%=time%>';
        }
        else {
             document.getElementById('status').innerHTML = "FEJL!!!!!!!";
        }
    </script>
</asp:Content>

