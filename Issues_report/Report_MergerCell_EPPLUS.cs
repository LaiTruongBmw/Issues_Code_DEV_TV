using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using NativeExcel;
using OfficeOpenXml;

public partial class rpt_hrrc00500_0 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        CtlLib.SetUser(Session["APP_DBUSER"].ToString());
		var v_language = Session["SESSION_LANG"].ToString();
		string p_Recruitment, p_Org_Code, p_Position, p_Status, p_From_Date, p_To_Date, p_Emp_level;
		
		p_Recruitment	= Request["txtRecruitment"].ToString();
		p_Org_Code	    = Request["lstOrg_Code"].ToString();
		p_Position  	= Request["lstPosition"].ToString();
		p_Status 		= Request["lstStatus"].ToString();
		p_From_Date     = Request["dtFrom_Date"].ToString();
		p_To_Date       = Request["dtTo_Date"].ToString();
		p_Emp_level  	= Request["lstEmp_level"].ToString();

        string TemplateFile = "rpt_hrrc00500_0.xlsx";
        string TempFile = "../../../../system/temp/rpt_hrrc00500_0_" + Session["User_ID"].ToString() + ".xlsx";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

		ExcelPackage pck = new ExcelPackage(new FileInfo(TemplateFile));
        var exSheet = pck.Workbook.Worksheets[1];
		
        IRange range ;

		string para = "'" + p_Recruitment +"','" + p_Org_Code + "','" + p_Position + "','" + p_Status + "','" + p_From_Date +"','" + p_To_Date +"','" + p_Emp_level +"'";
		// Proceduce dia diem tuyen dung
		DataTable dt_emp2 = CtlLib.TableReadOpenCursor("ST_HR_RPT_HRRC00500_2", para);

		//DataTable dt_emp = CtlLib.TableReadOpenCursor("ST_HR_RPT_HRRC00500_0", para);
		
		if (dt_emp2.Rows.Count == 0){
			Response.Write((v_language =="ENG")?"There is no data!":"Không có dữ liệu!");
            Response.End();
        }			
		
		int count=0;
		//table 3
		int row_loop2 = 21;		
		int l_total_col2 = dt_emp2.Columns.Count;
		int l_total_row2 = dt_emp2.Rows.Count;        

		/*
		int row_loop = 6;		
		int l_total_col = dt_emp.Columns.Count;
		int l_total_row = dt_emp.Rows.Count;	
		 */	
         for (int l_addrow = 1; l_addrow < dt_emp2.Rows.Count ; l_addrow++){	
				exSheet.InsertRow(row_loop2 + l_addrow , 1);
				exSheet.Cells[row_loop2, 1, row_loop2, 7].Copy(exSheet.Cells[row_loop2 + l_addrow, 1, row_loop2 + l_addrow, 7]);
				exSheet.Row(row_loop2 + l_addrow).Height = 20;
				exSheet.DefaultRowHeight = 20;
        }

		// xu ly du lieu do vao excel table 3
        int row_tem = row_loop2;
		 if (dt_emp2.Rows.Count > 0)
		{
            string valA = dt_emp2.Rows[0][2].ToString();
            
            int check = 0;
			for (int i = 0; i < dt_emp2.Rows.Count; i++)
			{
                count++;
                exSheet.Cells[row_loop2 + i, 1].Value = count;

                for (int col = 2; col < l_total_col2; col++)				
				{				
				
                    exSheet.Cells[row_loop2 + i, col].Value = dt_emp2.Rows[i][col].ToString();						
				}
				//End for	
               /*
                string valB = dt_emp2.Rows[i][2].ToString();
                
                if(valA == valB)
                {
                     string val = dt_emp2.Rows[i][3].ToString();
                    if(check == 0)
                    {
                        exSheet.InsertRow(row_tem , 1);
                        exSheet.Cells[row_tem +1, 1, row_tem +1, 7].Copy(exSheet.Cells[row_tem, 1, row_tem, 7]);
                        
                    }
                 
                    
                    exSheet.Cells[row_tem, 2].Value = dt_emp2.Rows[i][2].ToString();
                   
                    if(val == "01")
                    {
                        exSheet.Cells[row_tem, 3].Value = dt_emp2.Rows[i][4].ToString();
                        
                    }
                    if(val == "02")
                    {
                        exSheet.Cells[row_tem, 4].Value = dt_emp2.Rows[i][4].ToString();
                    }
                    if(val == "03")
                    {
                        exSheet.Cells[row_tem, 5].Value = dt_emp2.Rows[i][4].ToString();
                    }
                    check ++;
                    if(check == 3)
                    check = 0;
                }
                else
                {
                    row_tem ++;
                    valA = valB;
                }

         /*       count++;
               // exSheet.Cells[row_loop2 + i, 1].Value = count;
				for (int col = 2; col < l_total_col2; col++)				
				{			

					exSheet.Cells[row_loop2 + i, col].Value = dt_emp2.Rows[i][col].ToString();
                    								
				}
				//End for	
				*/ 				
			}

            exSheet.DeleteRow(row_tem,1);
						
		}  
        // End export data
		/* 
		for (int l_addrow = 1; l_addrow < dt_emp.Rows.Count ; l_addrow++){	
				exSheet.InsertRow(row_loop + l_addrow , 1);
				exSheet.Cells[row_loop, 1, row_loop, l_total_col].Copy(exSheet.Cells[row_loop + l_addrow, 1, row_loop + l_addrow, l_total_col]);
				exSheet.Row(row_loop + l_addrow).Height = 20;
				exSheet.DefaultRowHeight = 20;
        }
		// xu ly du lieu do vao excel
		 if (dt_emp.Rows.Count > 0)
		{
			for (int i = 0; i < dt_emp.Rows.Count; i++)
			{
                
                count++;
                exSheet.Cells[row_loop + i, 1].Value = count;
				for (int col = 2; col < l_total_col; col++)				
				{				
					if(col == 4 || col == 5)
					{	
						if(dt_emp.Rows[i][col].ToString() !="" && dt_emp.Rows[i][col].ToString().Length == 8)
						{
							exSheet.Cells[row_loop + i, col].Value = new DateTime(int.Parse(dt_emp.Rows[i][col].ToString().Substring(0, 4)), int.Parse(dt_emp.Rows[i][col].ToString().Substring(4, 2)), int.Parse(dt_emp.Rows[i][col].ToString().Substring(6, 2)));
						}
					}
					else {
                        exSheet.Cells[row_loop + i, col].Value = dt_emp.Rows[i][col].ToString();
                    }								
				}
				//End for	
								
			}
						
		}  
        // End export data
		*/
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
		// Save As 
		pck.SaveAs(new FileInfo(TempFile));
        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        //System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Response.ContentType = "application/pdf";
        //Send file string to client 
        //Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }

    public Bitmap ResizeImage(Bitmap d, int w, int h)
    {
        Bitmap q = new Bitmap(w, h);
        float f, g;
        f = (float)w / (float)d.Width;
        g = (float)h / (float)d.Height;
        for (int i = 0; i < w; i++)
        {
            for (int j = 0; j < h; j++)
            {
                Color c;
                c = d.GetPixel((int)(i / f), (int)(j / g));
                q.SetPixel(i, j, c);
            }
        }
        return q;
    }
	public static bool IsNumeric(string strNum)
    {
        try
        {
            double tmp = double.Parse(strNum);
            return true;
        }
        catch
        {
            return false;
        }
    }
}