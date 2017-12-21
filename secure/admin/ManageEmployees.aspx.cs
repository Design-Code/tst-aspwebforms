using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TSTModel;

public partial class secure_admin_ManageEmployees : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvEmployees_SelectedIndexChanged(object sender, EventArgs e)
    {
        //gvEmployees.DataBind();
        mvEmployees.SetActiveView(vwDetails);
        dvEmployees.ChangeMode(DetailsViewMode.ReadOnly);
    }
    protected void dsEmployeeDetails_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        gvEmployees.DataBind();

        dvEmployees.DataSource = null;
        dvEmployees.DataSourceID = dsMaxEmployee.ID;
        dvEmployees.DataBind();
    }
    protected void dsEmployeeDetails_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        gvEmployees.DataBind();
    }
    protected void dsEmployeeDetails_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        //find the upload control
        FileUpload fuEmp = (FileUpload)dvEmployees.FindControl("fuEmp");
        //make sure there is a file
        if (fuEmp.HasFile)
        {
            //get the filename
            string fileName = fuEmp.FileName;
            //get the extension
            string ext = fileName.Substring(fileName.LastIndexOf("."));
            //generate a new file name
            string newImageName = Guid.NewGuid().ToString();
            //plug the extension back in
            newImageName += ext;
            //save the photo to the images folder
            fuEmp.SaveAs(Server.MapPath("~/screenImages/" + newImageName));
            //save the photo name to the DB
            e.Command.Parameters["@EmpPhotoUrl"].Value = newImageName;
        }
        else
        {
            e.Command.Parameters["@EmpPhotoUrl"].Value = "no_image.jpg";
            //no file uploaded

        }
    }
    protected void dsEmployeeDetails_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        //find the upload contrul
        FileUpload fuEmp = (FileUpload)dvEmployees.FindControl("fuEmp");
        if (fuEmp.HasFile)
        {
            //get the filename
            string fileName = fuEmp.FileName;
            //get the extension
            string ext = fileName.Substring(fileName.LastIndexOf("."));
            //generate a new file name
            string newImageName = Guid.NewGuid().ToString();
            //plug the extension back in
            newImageName += ext;
            //save the photo to the images folder
            fuEmp.SaveAs(Server.MapPath("~/screenImages/" + newImageName));
            //save the photo name to the DB
            e.Command.Parameters["@EmpPhotoUrl"].Value = newImageName;
        }
        else
        {
            TSTEntities ctx = new TSTEntities();
            
            string currentImage = (from x in ctx.C3TEmployees
                                   where x.EmployeeId == (int)gvEmployees.SelectedValue                                   select x.EmpPhotoUrl).Single();
        }
    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        mvEmployees.SetActiveView(vwDetails);
        dvEmployees.ChangeMode(DetailsViewMode.Insert);
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        mvEmployees.SetActiveView(vwMaster);
    }

    protected void LinkButton2_Click1(object sender, EventArgs e)
    {
        mvEmployees.SetActiveView(vwMaster);
    }
    protected void LinkButton2_Click2(object sender, EventArgs e)
    {
        mvEmployees.SetActiveView(vwMaster);
    }

    protected void cbActive_PreRender(object sender, EventArgs e)
    {
        ((CheckBox)sender).Checked = true;
    }
}