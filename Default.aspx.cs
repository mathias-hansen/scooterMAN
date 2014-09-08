using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    forside Forside = new forside();
    DataTable dt = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        
        dt = Forside.getForsideContent();
        int max_fk = 0;
        foreach (DataRow row in dt.Rows)
        {
            if (max_fk < Convert.ToInt32(row["forside_fk"]))
            {
                max_fk = Convert.ToInt32(row["forside_fk"]);
            }
        }
        int content = 0;
        foreach (DataRow row in dt.Rows)
        {
            if (content < Convert.ToInt32(row["forside_fk"]))
            {
                if (content != 0)
                {
                    litContent.Text += "</article>";
                }
                content = Convert.ToInt32(row["forside_fk"]);
                litContent.Text += "<article><h1>" + row["header"] + "</h1>";
                litContent.Text += formatContent(row);
            }
            else {
                litContent.Text += formatContent(row);
            }
        }
    }
    public string formatContent(DataRow row) {
        string content = "";
        if (row["text"].ToString() != "" && row["image"].ToString() == "")
        {
            content = "<section class='text'><p>" + row["text"] + "</p></section>";
        }
        else if (row["text"].ToString() == "" && row["image"].ToString() != "" && row["side"].ToString() == "")
        {
            content = "<section class='img'><img style='max-width:" + row["img_width"] + "px;min-width:" + row["img_width"] + "px;max-height:" + row["img_height"] + "px;min-height:" + row["img_height"] + "px;' src='img/content/" + row["image"] + "'></section>";
        }
        else if (row["text"].ToString() != "" && row["image"].ToString() != "" && Convert.ToBoolean(row["side"]) != null)
        {
            if (Convert.ToBoolean(row["side"]))
            {
                content = "<section class='img-left'><img style='max-width:" + row["img_width"] + "px;min-width:" + row["img_width"] + "px;max-height:" + row["img_height"] + "px;min-height:" + row["img_height"] + "px;' src='img/content/" + row["image"] + "'><p>" + row["text"] + "</p></section>";
            }
            else
            {
                content = "<section class='img-right'><p>" + row["text"] + "</p><img style='max-width:" + row["img_width"] + "px;min-width:" + row["img_width"] + "px;max-height:" + row["img_height"] + "px;min-height:" + row["img_height"] + "px;' src='img/content/" + row["image"] + "'></section>";
            }
        }
        return content;
    }


    public class forside
    {
        DataAccess da = new DataAccess();
        SqlCommand cmd = new SqlCommand();
        DataTable dt = new DataTable();

        public DataTable getForsideContent()
        {
            cmd.CommandText = "SELECT [sm_forside].[header], [sm_content].[text], [sm_content].[image], [sm_content].[side], [sm_content].[forside_fk], [sm_content].[img_width], [sm_content].[img_height] FROM [sm_content] INNER JOIN [sm_forside] ON [sm_content].[forside_fk] = [sm_forside].[id]";
            return dt = da.GetData(cmd);
        }
    }
    public class DataAccess
    {
        SqlConnection _Con = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString);

        public DataTable GetData(SqlCommand CMD)
        {
            DataTable dt = new DataTable();
            SqlDataAdapter objDa = new SqlDataAdapter();

            try
            {
                CMD.Connection = _Con;
                objDa.SelectCommand = CMD;
                objDa.Fill(dt);
            }
            catch (Exception)
            {
                throw;
            }
            return dt;
        }
        public void ModifyData(SqlCommand CMD)
        {
            CMD.Connection = _Con;
            _Con.Open();
            CMD.ExecuteNonQuery();
            _Con.Close();
        }
    }
}