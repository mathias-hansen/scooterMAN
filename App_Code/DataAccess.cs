using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

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