<%@ Page Title="Requests" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Requests.aspx.cs" Inherits="Requests" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:MultiView ID="mvRequests" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!-- Gridview Here-->
        
            <!--Details View Here -->
     
    <asp:SqlDataSource ID="dsRequests" runat="server" 
        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
        
                
                
                SelectCommand="SELECT [3TRequests].ReqId, [3TRequests].ReqDate, [3TRequests].ReqCloseDate, [3TRequestStatuses].RequestStatusName, [3TEmployees].EmpFirstName + ' ' + [3TEmployees].EmpLastName AS Employee, Tech.EmpFirstName + ' ' + Tech.EmpLastName AS Technician FROM [3TEmployees] INNER JOIN [3TRequests] ON [3TEmployees].EmployeeId = [3TRequests].ReqEmployeeId INNER JOIN [3TRequestStatuses] ON [3TRequests].ReqStatusId = [3TRequestStatuses].RequestStatusId LEFT OUTER JOIN [3TEmployees] AS Tech ON [3TRequests].ReqTechId = Tech.EmployeeId WHERE ([3TRequests].ReqStatusId IN (1, 2))" DeleteCommand="Update [3TRequests] set RequestStatusId = 3
WHERE ReqId=@ReqId" 
                >
        <DeleteParameters>
            <asp:Parameter Name="ReqId" />
        </DeleteParameters>
    </asp:SqlDataSource>
            <br />
    <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" 
        BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" 
        CellPadding="4" DataKeyNames="ReqId" DataSourceID="dsRequests" 
        ForeColor="Black" GridLines="Vertical" AllowPaging="True" 
        AllowSorting="True" Font-Names="Arial" 
                onselectedindexchanged="gvRequests_SelectedIndexChanged" Width="500px">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="Details" />
            <asp:BoundField DataField="ReqId" HeaderText="Ticket ID" InsertVisible="False" 
                ReadOnly="True" SortExpression="ReqId" />
            <asp:BoundField DataField="ReqDate" HeaderText="Posted" 
                SortExpression="ReqDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="Employee" HeaderText="Poster" ReadOnly="True" 
                SortExpression="Employee" />
            <asp:BoundField DataField="RequestStatusName" HeaderText="Status" 
                SortExpression="RequestStatusName" />
            <asp:BoundField DataField="Technician" HeaderText="Tech" ReadOnly="True" 
                SortExpression="Technician" />
            <asp:BoundField DataField="ReqCloseDate" HeaderText="Closed" 
                SortExpression="ReqCloseDate" Visible="False" />
        <%--<asp:TemplateField ShowHeader="false">
        <ItemTemplate>
        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure?')" Text="Discontinue">
        
        
        </asp:LinkButton>
        
        </ItemTemplate>
        </asp:TemplateField>--%>
        </Columns>
        <FooterStyle BackColor="#CCCC99" />
        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
        <RowStyle BackColor="#F7F7DE" />
        <SelectedRowStyle Font-Bold="True" />
        <SortedAscendingCellStyle BackColor="#FBFBF2" />
        <SortedAscendingHeaderStyle BackColor="#848384" />
        <SortedDescendingCellStyle BackColor="#EAEAD3" />
        <SortedDescendingHeaderStyle BackColor="#575357" />
    </asp:GridView>
            <asp:SqlDataSource ID="dsClosedRequests" runat="server" 
                ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" DeleteCommand="Update [3TRequests] set RequestStatusId = 3
WHERE ReqId=@ReqId" 
                SelectCommand="SELECT [3TRequests].ReqId, [3TRequests].ReqDate, [3TRequests].ReqCloseDate, [3TRequestStatuses].RequestStatusName, [3TEmployees].EmpFirstName + ' ' + [3TEmployees].EmpLastName AS Employee, Tech.EmpFirstName + ' ' + Tech.EmpLastName AS Technician FROM [3TEmployees] INNER JOIN [3TRequests] ON [3TEmployees].EmployeeId = [3TRequests].ReqEmployeeId INNER JOIN [3TRequestStatuses] ON [3TRequests].ReqStatusId = [3TRequestStatuses].RequestStatusId LEFT OUTER JOIN [3TEmployees] AS Tech ON [3TRequests].ReqTechId = Tech.EmployeeId WHERE ([3TRequests].ReqStatusId IN (3))">
                <DeleteParameters>
                    <asp:Parameter Name="ReqId" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <br />
           <%if (Page.User.IsInRole("tech"))
             { %>
            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" 
                Font-Names="Arial" ForeColor="#99CC00" 
                oncheckedchanged="CheckBox1_CheckedChanged" Text="VIEW CLOSED TICKETS" />
                <%} %>
            <br />
    <br />
            <asp:LinkButton ID="btnNewTicket" runat="server" Font-Names="Arial" 
                ForeColor="#669900" onclick="btnNewTicket_Click">CREATE NEW TICKET &gt;&gt;</asp:LinkButton>
            <br />

    </asp:View>
        <asp:View ID="vwDetails" runat="server">







    
    <asp:SqlDataSource ID="dsRequestDetails" runat="server" 
        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
        DeleteCommand="DELETE FROM [3TRequests] WHERE [ReqId] = @ReqId" 
        InsertCommand="INSERT INTO [3TRequests] (ReqDate, ReqCloseDate, ReqTechNotes, ReqScreenCapture, ReqStatusId, ReqEmployeeId, ReqTechId, ReqEmployeeNotes) VALUES (GetDate(), @ReqCloseDate, @ReqTechNotes, @ReqScreenCapture, 1,  @ReqEmployeeId, @ReqTechId, @ReqEmployeeNotes)" 
        SelectCommand="SELECT [3TRequests].ReqId, [3TRequests].ReqDate, [3TRequests].ReqCloseDate, [3TRequests].ReqScreenCapture, [3TRequests].ReqStatusId, [3TRequests].ReqEmployeeId, [3TRequests].ReqTechId, [3TEmployees].EmpFirstName + ' ' + [3TEmployees].EmpLastName AS Employee, [3TEmployees_1].EmpFirstName + ' ' + [3TEmployees_1].EmpLastName AS Technician, [3TRequests].ReqTechNotes, [3TRequestStatuses].RequestStatusName, [3TRequests].ReqEmployeeNotes FROM [3TRequests] INNER JOIN [3TEmployees] ON [3TRequests].ReqEmployeeId = [3TEmployees].EmployeeId INNER JOIN [3TRequestStatuses] ON [3TRequests].ReqStatusId = [3TRequestStatuses].RequestStatusId LEFT OUTER JOIN [3TEmployees] AS [3TEmployees_1] ON [3TRequests].ReqTechId = [3TEmployees_1].EmployeeId WHERE ([3TRequests].ReqId = @ReqId)" 
        
                
                UpdateCommand="UPDATE [3TRequests] SET ReqDate = @ReqDate, ReqCloseDate = @ReqCloseDate, ReqTechNotes = @ReqTechNotes, ReqScreenCapture = @ReqScreenCapture, ReqStatusId = @ReqStatusId, ReqEmployeeId = @ReqEmployeeId, ReqTechId = @ReqTechId, ReqEmployeeNotes = @ReqEmployeeNotes WHERE (ReqId = @ReqId)" 
                oninserting="dsRequestDetails_Inserting" 
                onupdating="dsRequestDetails_Updating" 
                onupdated="dsRequestDetails_Updated" oninserted="dsRequestDetails_Inserted" 
                >
        <DeleteParameters>
            <asp:Parameter Name="ReqId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ReqCloseDate" Type="DateTime" />
            <asp:Parameter Name="ReqScreenCapture" Type="String" />
            <asp:Parameter Name="ReqEmployeeId" Type="Int32" />
            <asp:Parameter Name="ReqTechId" Type="Int32" />
            <asp:Parameter Name="ReqEmployeeNotes" />
            <asp:Parameter Name="ReqTechNotes" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvRequests" Name="ReqId" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ReqDate" Type="DateTime" />
            <asp:Parameter Name="ReqCloseDate" Type="DateTime" />
            <asp:Parameter Name="ReqTechNotes" Type="String" />
            <asp:Parameter Name="ReqScreenCapture" Type="String" />
            <asp:Parameter Name="ReqStatusId" Type="Int32" />
            <asp:Parameter Name="ReqEmployeeId" Type="Int32" />
            <asp:Parameter Name="ReqTechId" Type="Int32" />
            <asp:Parameter Name="ReqId" Type="Int32" />
            <asp:Parameter Name="ReqEmployeeNotes" />
        </UpdateParameters>
    </asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="dsMaxRequest" runat="server" 
                ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                DeleteCommand="DELETE FROM [3TRequests] WHERE [ReqId] = @ReqId" 
                InsertCommand="INSERT INTO [3TRequests] (ReqDate, ReqCloseDate, ReqTechNotes, ReqScreenCapture, ReqStatusId, ReqEmployeeId, ReqTechId, ReqEmployeeNotes) VALUES (@ReqDate, @ReqCloseDate, @ReqTechNotes, @ReqScreenCapture, @ReqStatusId, @ReqEmployeeId, @ReqTechId, @ReqEmployeeNotes)" 
                oninserted="dsRequestDetails_Inserted" oninserting="dsRequestDetails_Inserting" 
                onupdated="dsRequestDetails_Updated" onupdating="dsRequestDetails_Updating" 
                SelectCommand="SELECT [3TRequests].ReqId, [3TRequests].ReqDate, [3TRequests].ReqCloseDate, [3TRequests].ReqScreenCapture, [3TRequests].ReqStatusId, [3TRequests].ReqEmployeeId, [3TRequests].ReqTechId, [3TEmployees].EmpFirstName + ' ' + [3TEmployees].EmpLastName AS Employee, [3TEmployees_1].EmpFirstName + ' ' + [3TEmployees_1].EmpLastName AS Technician, [3TRequests].ReqTechNotes, [3TRequestStatuses].RequestStatusName, [3TRequests].ReqEmployeeNotes FROM [3TRequests] INNER JOIN [3TEmployees] ON [3TRequests].ReqEmployeeId = [3TEmployees].EmployeeId INNER JOIN [3TRequestStatuses] ON [3TRequests].ReqStatusId = [3TRequestStatuses].RequestStatusId LEFT OUTER JOIN [3TEmployees] AS [3TEmployees_1] ON [3TRequests].ReqTechId = [3TEmployees_1].EmployeeId WHERE ([3TRequests].ReqId = (SELECT MAX(ReqId) AS EXPR1 FROM [3TRequests] AS [3TRequests_1]))" 
                UpdateCommand="UPDATE [3TRequests] SET ReqDate = @ReqDate, ReqCloseDate = @ReqCloseDate, ReqTechNotes = @ReqTechNotes, ReqScreenCapture = @ReqScreenCapture, ReqStatusId = @ReqStatusId, ReqEmployeeId = @ReqEmployeeId, ReqTechId = @ReqTechId, ReqEmployeeNotes = @ReqEmployeeNotes WHERE (ReqId = @ReqId)">
                <DeleteParameters>
                    <asp:Parameter Name="ReqId" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ReqDate" Type="DateTime" />
                    <asp:Parameter Name="ReqCloseDate" Type="DateTime" />
                    <asp:Parameter Name="ReqTechNotes" Type="String" />
                    <asp:Parameter Name="ReqScreenCapture" Type="String" />
                    <asp:Parameter Name="ReqStatusId" Type="Int32" />
                    <asp:Parameter Name="ReqEmployeeId" Type="Int32" />
                    <asp:Parameter Name="ReqTechId" Type="Int32" />
                    <asp:Parameter Name="ReqEmployeeNotes" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ReqDate" Type="DateTime" />
                    <asp:Parameter Name="ReqCloseDate" Type="DateTime" />
                    <asp:Parameter Name="ReqTechNotes" Type="String" />
                    <asp:Parameter Name="ReqScreenCapture" Type="String" />
                    <asp:Parameter Name="ReqStatusId" Type="Int32" />
                    <asp:Parameter Name="ReqEmployeeId" Type="Int32" />
                    <asp:Parameter Name="ReqTechId" Type="Int32" />
                    <asp:Parameter Name="ReqId" Type="Int32" />
                    <asp:Parameter Name="ReqEmployeeNotes" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:LinkButton ID="LinkButton1" runat="server" Font-Names="Arial" 
                ForeColor="#669900" onclick="LinkButton1_Click" CausesValidation="False">&lt;&lt; BACK TO TICKETS</asp:LinkButton>
            <br />
            <br />
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
        BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" 
        CellPadding="4" DataKeyNames="ReqId" DataSourceID="dsRequestDetails" 
        EnableViewState="False" ForeColor="Black" GridLines="Vertical" 
        Width="500px" Font-Names="Arial" 
                 >
        <AlternatingRowStyle BackColor="White" />
        <EditRowStyle Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="ReqId" HeaderText="Ticket ID" InsertVisible="False" 
                ReadOnly="True" SortExpression="ReqId" />
            <asp:TemplateField HeaderText="Posted" SortExpression="ReqDate" 
                InsertVisible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ReqDate") %>'></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox3" ErrorMessage="*Date is required" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                    <br />
                    <asp:CalendarExtender ID="TextBox3_CalendarExtender" runat="server" 
                        Enabled="True" TargetControlID="TextBox3"></asp:CalendarExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ReqDate") %>' 
                        ></asp:TextBox>
                    <br />
                    <asp:CalendarExtender ID="TextBox3_CalendarExtender" runat="server" 
                        Enabled="True" TargetControlID="TextBox3"></asp:CalendarExtender>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("ReqDate") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Poster" SortExpression="Employee">
                <EditItemTemplate>
                    <asp:SqlDataSource ID="dsEmployee" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                        SelectCommand="SELECT EmployeeId, EmpFirstName + ' ' + EmpLastName AS Employee FROM [3TEmployees] ORDER BY EmpLastName">
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="dsEmployee" 
                        DataTextField="Employee" DataValueField="EmployeeId" 
                        SelectedValue='<%# Bind("ReqEmployeeId") %>' AppendDataBoundItems="True">
                        <asp:ListItem Value="">- Choose an Employee -</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="*Choose an Employee" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                    <br />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:SqlDataSource ID="dsEmployee" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                        SelectCommand="SELECT EmployeeId, EmpFirstName + ' ' + EmpLastName AS Employee FROM [3TEmployees] ORDER BY EmpLastName">
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="dsEmployee" 
                        DataTextField="Employee" DataValueField="EmployeeId" 
                        SelectedValue='<%# Bind("ReqEmployeeId") %>' AppendDataBoundItems="True">
                        
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="*Choose an Employee" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                    <br />
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Employee") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Requester Notes" 
                SortExpression="ReqEmployeeNotes">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" 
                        Text='<%# Bind("ReqEmployeeNotes") %>' TextMode="MultiLine" Height="100px" 
                        Width="80%" CausesValidation="True"></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox2" ErrorMessage="*Notes are Required" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" 
                        Text='<%# Bind("ReqEmployeeNotes") %>' TextMode="MultiLine" Height="100px" 
                        Width="80%"></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox2" ErrorMessage="*Notes are Required" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                    <br />
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("ReqEmployeeNotes") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Screen Capture" 
                SortExpression="ReqScreenCapture">
                <EditItemTemplate>
                    <asp:FileUpload ID="screenCap" runat="server" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:FileUpload ID="screenCap" runat="server" />
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="scrImg" runat="server" 
                        ImageUrl='<%# Bind("ReqScreenCapture","~/screenImages/{0}") %>' Width="480px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Closed" SortExpression="ReqCloseDate" 
                InsertVisible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ReqCloseDate") %>'></asp:TextBox>
                    <asp:CalendarExtender ID="TextBox4_CalendarExtender" runat="server" 
                        Enabled="True" TargetControlID="TextBox4"></asp:CalendarExtender>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ReqCloseDate") %>'></asp:TextBox>
                    <asp:CalendarExtender ID="TextBox4_CalendarExtender" runat="server" 
                        Enabled="True" TargetControlID="TextBox4"></asp:CalendarExtender>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("ReqCloseDate") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tech" SortExpression="Technician" 
                InsertVisible="False">
                <EditItemTemplate>
                    <asp:SqlDataSource ID="dsTech" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                        SelectCommand="SELECT EmployeeId, EmpFirstName + ' ' + EmpLastName AS Tech FROM [3TEmployees] WHERE (EmpDeptId = 3) ORDER BY EmpLastName">
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="dsTech" 
                        DataTextField="Tech" DataValueField="EmployeeId" 
                        SelectedValue='<%# Bind("ReqTechId") %>' AppendDataBoundItems="true" 
                        CausesValidation="True">
                        <asp:ListItem Value="">- Choose a Tech -</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="DropDownList3" ErrorMessage="*Tech is Required" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:SqlDataSource ID="dsTech" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                        SelectCommand="SELECT EmployeeId, EmpFirstName + ' ' + EmpLastName AS Tech FROM [3TEmployees] WHERE (EmpDeptId = 3) ORDER BY EmpLastName">
                    </asp:SqlDataSource>
                    <br />
                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="dsTech" 
                        DataTextField="Tech" DataValueField="EmployeeId" 
                        SelectedValue='<%# Bind("ReqTechId") %>' AppendDataBoundItems="True">
                    </asp:DropDownList>
                    <br />
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Technician") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tech Notes" SortExpression="ReqTechNotes" 
                InsertVisible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReqTechNotes") %>' 
                        TextMode="MultiLine" Height="100px" Width="80%"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReqTechNotes") %>' 
                        TextMode="MultiLine" Height="100px" Width="80%"></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("ReqTechNotes") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="RequestStatusName" 
                InsertVisible="False">
                <EditItemTemplate>
                    <asp:SqlDataSource ID="dsStatus" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                        SelectCommand="SELECT RequestStatusId, RequestStatusName FROM [3TRequestStatuses] ORDER BY RequestStatusName">
                    </asp:SqlDataSource>
                    <br />
                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="dsStatus" 
                        DataTextField="RequestStatusName" DataValueField="RequestStatusId" 
                        SelectedValue='<%# Bind("ReqStatusId") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:SqlDataSource ID="dsStatus" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                        SelectCommand="SELECT RequestStatusId, RequestStatusName FROM [3TRequestStatuses] ORDER BY RequestStatusName">
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="dsStatus" 
                        DataTextField="RequestStatusName" DataValueField="RequestStatusId" 
                        SelectedValue='<%# Bind("ReqStatusId") %>'>
                    </asp:DropDownList>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("RequestStatusName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Update" Text="Update"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" Text="Cancel" onclick="LinkButton2_Click"></asp:LinkButton>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Insert" Text="Insert"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" Text="Cancel" onclick="LinkButton2_Click1"></asp:LinkButton>
                </InsertItemTemplate>
                <ItemTemplate>
                    <%if (Page.User.IsInRole("tech"))
                      { %>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Edit" Text="Edit"></asp:LinkButton>
                    <%} %>
                    &nbsp;
                    
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="New" Text="New"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
        <FooterStyle BackColor="#CCCC99" />
        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
        <RowStyle BackColor="#F7F7DE" />
    </asp:DetailsView>
    
       </asp:View>
    </asp:MultiView>








</asp:Content>

