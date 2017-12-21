using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TSTModel;

public partial class secure_admin_ManageDepts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void gvDeptartments_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvDepartments.SetActiveView(vwDetails);
        dvDepartment.ChangeMode(DetailsViewMode.ReadOnly);
    }
    //code for adding a new dept
    //find ddl
    //DropDownList ddl = (DropDownList)fvEmployeeDetails.FindControl("ddlDept");

    //check to see if the user is adding a new dept
    //if(ddl.SelectedValue == "-1")
    //{
    //TextBox tbNewDept = (TextBox)fvEmployeeDetails.FindControl("tbNewDept");
    //string newDeptname = tbNewDept.Text;
    //create the dept object
    //C3TDepartments newDept = new C3TDepartments()
    //{
    //DepartmentName=newDeptname
    //};
    //inser the new dept
    //ctx.C3TDepartments.AddObject(newDept);
    //ctx.SaveChanges();
    //get the new Dept ID
    //int newId = ctx.C3tDepartments.Max(d=>d.DepartmentId);
    //set the new DeptId in the insert statement
    //e.Command.Parameters["@EmpDeptId"].Value=newId;
    protected void dsDepartmentDetails_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        gvDeptartments.DataBind();

        dvDepartment.DataSource = null;
        dvDepartment.DataSourceID = dsMaxDepartmentDetails.ID;
        dvDepartment.DataBind();
    }
    protected void dsDepartmentDetails_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        gvDeptartments.DataBind();
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        mvDepartments.SetActiveView(vwDetails);
        dvDepartment.ChangeMode(DetailsViewMode.Insert);
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        mvDepartments.SetActiveView(vwMaster);
    }
    protected void LinkButton2_Click1(object sender, EventArgs e)
    {
        mvDepartments.SetActiveView(vwMaster);
    }
    protected void LinkButton2_Click2(object sender, EventArgs e)
    {
        mvDepartments.SetActiveView(vwMaster);
    }
}