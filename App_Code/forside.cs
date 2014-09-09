using System.Data;
using System.Data.SqlClient;

public class forside
{
    DataAccess da = new DataAccess();
    SqlCommand cmd = new SqlCommand();
    DataTable dt = new DataTable();

    public DataTable getForsideContent() {
        cmd.CommandText = "SELECT [sm_forside].[header], [sm_content].[text], [sm_content].[image], [sm_content].[side], [sm_content].[forside_fk], [sm_content].[img_width], [sm_content].[img_height] FROM [sm_content] INNER JOIN [sm_forside] ON [sm_content].[forside_fk] = [sm_forside].[id]";
        return dt = da.GetData(cmd);
    }
}