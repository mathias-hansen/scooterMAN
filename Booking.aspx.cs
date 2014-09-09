using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Booking : System.Web.UI.Page
{
    public string json;
    public string test = "false";
    public string date;

    protected void Page_Load(object sender, EventArgs e)
    {
        Calendar1.SelectedDate = DateTime.Now.Date;
    }
    protected void btnOrder_Click(object sender, EventArgs e)
    {
        string ori = txtOri.Text;
        string dist = txtDest.Text;
        date = Calendar1.SelectedDate.ToString();
        test = "true";
        json = new WebClient().DownloadString("http://maps.googleapis.com/maps/api/distancematrix/json?origins=" + ori + "&destinations=" + dist + "&mode=driving&language=en");
        json += ";";
    }
}