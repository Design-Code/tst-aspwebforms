using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TSTModel;

public partial class Requests : System.Web.UI.Page
{
    TSTEntities ctx = new TSTEntities();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvRequests_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvRequests.SetActiveView(vwDetails);
        DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        mvRequests.SetActiveView(vwMaster);
    }
    protected void dsRequestDetails_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        gvRequests.DataBind();
        
    }

    protected void dsRequestDetails_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        //refresh the gridview
        
        gvRequests.DataBind();

        Response.Redirect("~/Thanks.aspx");

        //when we insert a ticket

        //show the gv
        //mvRequests.SetActiveView(vwMaster);
        //or show the details for the new Request
        DetailsView1.DataSource = null;
        DetailsView1.DataSourceID = dsMaxRequest.ID;
        DetailsView1.DataBind();

    }

    protected void dsRequestDetails_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        
        //find the upload control
        FileUpload screenCap = (FileUpload)DetailsView1.FindControl("screenCap");
        //make sure there is a file
        if (screenCap.HasFile)
        {
            //get filename
            string fileName = screenCap.FileName;
            //get the extension
            string ext = fileName.Substring(fileName.LastIndexOf("."));
            //generate a new file name
            string newImageName = Guid.NewGuid().ToString();
            //plug the extension back in 
            newImageName += ext;
            //save the photo to the images folder
            screenCap.SaveAs(Server.MapPath("~/screenImages/" + newImageName));
            //save the photo name to the DB
            e.Command.Parameters["@ReqScreenCapture"].Value = newImageName;
        }
        else
        {
            e.Command.Parameters["@ReqScreenCapture"].Value = "no_image.jpg";
            //no file uploaded

        }
    }
    protected void dsRequestDetails_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        
        
        
        //find the upload control
        FileUpload screenCap = (FileUpload)DetailsView1.FindControl("screenCap");
        //make sure there is a file
        if (screenCap.HasFile)
        {
            //get filename
            string fileName = screenCap.FileName;
            //get the extension
            string ext = fileName.Substring(fileName.LastIndexOf("."));
            //generate a new file name
            string newImageName = Guid.NewGuid().ToString();
            //plug the extension back in 
            newImageName += ext;
            //save the photo to the images folder
            screenCap.SaveAs(Server.MapPath("~/screenImages/" + newImageName));
            //save the photo name to the DB
            e.Command.Parameters["@ReqScreenCapture"].Value = newImageName;
        }
        else
        {
            
            //no file uploaded - keep current image for the product

            //use linq to EF to grab the current image for screenCap
            //create the data context
            
            
            string currentImage = (from r in ctx.C3TRequests
                where r.ReqId == (int)gvRequests.SelectedValue
                                select r.ReqScreenCapture).Single();

            e.Command.Parameters["@ReqScreenCapture"].Value = currentImage;
                    
            
            //string currentImage = (from r in ctx.Products
            //                       where p.ProductID == (int)gvProducts.SelectedValue
            //                       select p.PictureURL).Single();



        }
        //show the gv if ticket goes from open to closed or from closed to open

        //get the current status
        int statusId = (from r in ctx.C3TRequests
                       where r.ReqId == (int)gvRequests.SelectedValue
                       select r.ReqStatusId).Single();
        //get the new status
        int newStatus = (int)e.Command.Parameters["@ReqStatusId"].Value;

        if((statusId <=2 && newStatus ==3) || (statusId ==3 && newStatus <= 2))
        {
            mvRequests.SetActiveView(vwMaster);
        }
    }

    protected void btnNewTicket_Click(object sender, EventArgs e)
    {
        mvRequests.SetActiveView(vwDetails);
        DetailsView1.ChangeMode(DetailsViewMode.Insert);

    }

    
    //if you had a delete column on your gvRequests then you would enter the following
    //to hide the delete column if user is not an admin
    //if(!User.IsInRole("tech") && gvRequests.Columns.Count > 0)
    //{
    // hide the last column
    // gvRequests.Columns[gvRequests.Columns.Count - 1].Visible = false;
    //}


    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

        if (CheckBox1.Checked)
        {
            gvRequests.DataSourceID = dsClosedRequests.ID;
            gvRequests.DataBind();
            //CheckBox1.Text = "VIEW OPEN TICKETS";
        }
        else
        {
            gvRequests.DataSourceID = dsRequests.ID;
            gvRequests.DataBind();
            //CheckBox1.Text = "VIEW CLOSED TICKETS";
        }
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        mvRequests.SetActiveView(vwMaster);
    }
    protected void LinkButton2_Click1(object sender, EventArgs e)
    {
        mvRequests.SetActiveView(vwMaster);
    }
}