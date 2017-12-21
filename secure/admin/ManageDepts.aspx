<%@ Page Title="Manage Departments" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageDepts.aspx.cs" Inherits="secure_admin_ManageDepts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    
    <asp:MultiView ID="mvDepartments" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!-- Gridview Here-->
       
        

    <asp:SqlDataSource ID="dsDepartments" runat="server" 
    ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
    DeleteCommand="DELETE FROM [3TDepartments] WHERE [DepartmentId] = @DepartmentId" 
    InsertCommand="INSERT INTO [3TDepartments] ([DepartmentName], [DepartmentDescription]) VALUES (@DepartmentName, @DepartmentDescription)" 
    SelectCommand="SELECT * FROM [3TDepartments] " 
    UpdateCommand="UPDATE [3TDepartments] SET [DepartmentName] = @DepartmentName, [DepartmentDescription] = @DepartmentDescription WHERE [DepartmentId] = @DepartmentId">
    <DeleteParameters>
        <asp:Parameter Name="DepartmentId" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="DepartmentName" Type="String" />
        <asp:Parameter Name="DepartmentDescription" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="DepartmentName" Type="String" />
        <asp:Parameter Name="DepartmentDescription" Type="String" />
        <asp:Parameter Name="DepartmentId" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
<br />
<asp:GridView ID="gvDeptartments" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
    BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
    DataKeyNames="DepartmentId" DataSourceID="dsDepartments" ForeColor="Black" 
    GridLines="Vertical" 
    onselectedindexchanged="gvDeptartments_SelectedIndexChanged" Width="580px" 
                Font-Names="Arial">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:CommandField ShowSelectButton="True" />
        <asp:BoundField DataField="DepartmentId" HeaderText="Department ID" 
            InsertVisible="False" ReadOnly="True" SortExpression="DepartmentId" 
            Visible="False" />
        <asp:BoundField DataField="DepartmentName" HeaderText="Department" 
            SortExpression="DepartmentName" />
        <asp:TemplateField HeaderText="Remove" ShowHeader="False">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                    CommandName="Delete" onclientclick="return confirm('Are you sure?')" 
                    Text="Discontinue"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
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
            <br />
            <asp:LinkButton ID="LinkButton1" runat="server" Font-Names="Arial" 
                ForeColor="#99CC00" onclick="LinkButton1_Click">CREATE NEW DEPARTMENT &gt;&gt;</asp:LinkButton>
 </asp:View>
        <asp:View ID="vwDetails" runat="server">
            <!--Details View Here -->

    <br />
    <asp:SqlDataSource ID="dsDepartmentDetails" runat="server" 
        ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
        DeleteCommand="DELETE FROM [3TDepartments] WHERE [DepartmentId] = @DepartmentId" 
        InsertCommand="INSERT INTO [3TDepartments] ([DepartmentName], [DepartmentDescription]) VALUES (@DepartmentName, @DepartmentDescription)" 
        SelectCommand="SELECT * FROM [3TDepartments] WHERE ([DepartmentId] = @DepartmentId)" 
        
                UpdateCommand="UPDATE [3TDepartments] SET [DepartmentName] = @DepartmentName, [DepartmentDescription] = @DepartmentDescription WHERE [DepartmentId] = @DepartmentId" 
                oninserted="dsDepartmentDetails_Inserted" 
                onupdated="dsDepartmentDetails_Updated">
        <DeleteParameters>
            <asp:Parameter Name="DepartmentId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="DepartmentName" Type="String" />
            <asp:Parameter Name="DepartmentDescription" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="gvDeptartments" Name="DepartmentId" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="DepartmentName" Type="String" />
            <asp:Parameter Name="DepartmentDescription" Type="String" />
            <asp:Parameter Name="DepartmentId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
            <asp:LinkButton ID="LinkButton2" runat="server" Font-Names="Arial" 
                ForeColor="#99CC00" onclick="LinkButton2_Click" CausesValidation="False">&lt;&lt; BACK TO DEPARTMENTS</asp:LinkButton>
            <br />
            <br />
            <asp:SqlDataSource ID="dsMaxDepartmentDetails" runat="server" 
                ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                DeleteCommand="DELETE FROM [3TDepartments] WHERE [DepartmentId] = @DepartmentId" 
                InsertCommand="INSERT INTO [3TDepartments] ([DepartmentName], [DepartmentDescription]) VALUES (@DepartmentName, @DepartmentDescription)" 
                oninserted="dsDepartmentDetails_Inserted" 
                onupdated="dsDepartmentDetails_Updated" 
                SelectCommand="SELECT DepartmentId, DepartmentName, DepartmentDescription FROM [3TDepartments] WHERE (DepartmentId = (SELECT MAX(DepartmentId) AS DEPT FROM [3TDepartments] AS [3TDepartments_1]))" 
                
                UpdateCommand="UPDATE [3TDepartments] SET [DepartmentName] = @DepartmentName, [DepartmentDescription] = @DepartmentDescription WHERE [DepartmentId] = @DepartmentId">
                <DeleteParameters>
                    <asp:Parameter Name="DepartmentId" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="DepartmentName" Type="String" />
                    <asp:Parameter Name="DepartmentDescription" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DepartmentName" Type="String" />
                    <asp:Parameter Name="DepartmentDescription" Type="String" />
                    <asp:Parameter Name="DepartmentId" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
    
    <asp:DetailsView ID="dvDepartment" runat="server" Width="580px" 
                AutoGenerateRows="False" BackColor="White" 
        BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
        DataKeyNames="DepartmentId" DataSourceID="dsDepartmentDetails" ForeColor="Black" 
        GridLines="Vertical" Font-Names="Arial" EnableViewState="False">
        <AlternatingRowStyle BackColor="White" />
        <EditRowStyle Font-Bold="True" />
        <Fields>
            <asp:TemplateField HeaderText="Department" SortExpression="DepartmentName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DepartmentName") %>'></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox2" ErrorMessage="*Department is Required" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DepartmentName") %>'></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox2" ErrorMessage="*Department is Required" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("DepartmentName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Department Description" 
                SortExpression="DepartmentDescription">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Height="100px" 
                        Text='<%# Bind("DepartmentDescription") %>' TextMode="MultiLine" Width="80%"></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox1" ErrorMessage="*Department notes are Required" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Height="100px" 
                        Text='<%# Bind("DepartmentDescription") %>' TextMode="MultiLine" Width="80%"></asp:TextBox>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox1" ErrorMessage="*Department notes are Required" 
                        ForeColor="#CC0000"></asp:RequiredFieldValidator>
                    <br />
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" 
                        Text='<%# Bind("DepartmentDescription") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Update" Text="Update"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" onclick="LinkButton2_Click1" Text="Cancel"></asp:LinkButton>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Insert" Text="Insert"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" onclick="LinkButton2_Click2" Text="Cancel"></asp:LinkButton>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Edit" Text="Edit"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
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

