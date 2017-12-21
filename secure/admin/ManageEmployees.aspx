<%@ Page Title="Manage Employees" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageEmployees.aspx.cs" Inherits="secure_admin_ManageEmployees" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    
    <asp:MultiView ID="mvEmployees" runat="server" ActiveViewIndex="0">
        <asp:View ID="vwMaster" runat="server">
            <!-- Gridview Here-->
        
        
    <asp:SqlDataSource ID="dsEmployees" runat="server" 
    ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
    
                SelectCommand="SELECT EmployeeId, EmpTitle, EmpFirstName + ' ' + EmpLastName AS Expr1, EmpPhotoUrl, EmpPhone, EmpEmail, EmpHireDate, EmpNotes, EmpIsActive FROM [3TEmployees] ORDER BY EmpLastName" 
                ></asp:SqlDataSource>

<asp:GridView ID="gvEmployees" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
    BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
    DataKeyNames="EmployeeId" DataSourceID="dsEmployees" Font-Names="Arial" 
    ForeColor="Black" GridLines="Vertical" Width="600px" 
                onselectedindexchanged="gvEmployees_SelectedIndexChanged">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:CommandField SelectText="Details" ShowSelectButton="True" />
        <asp:BoundField DataField="EmployeeId" HeaderText="ID" InsertVisible="False" 
            ReadOnly="True" SortExpression="EmployeeId" />
        <asp:BoundField DataField="EmpTitle" HeaderText="Title" 
            SortExpression="EmpTitle" />
        <asp:BoundField DataField="Expr1" HeaderText="Name" ReadOnly="True" 
            SortExpression="Expr1" />
        <asp:BoundField DataField="EmpHireDate" DataFormatString="{0:d}" 
            HeaderText="Hire Date" SortExpression="EmpHireDate" />
        <asp:CheckBoxField DataField="EmpIsActive" HeaderText="Active" 
            SortExpression="EmpIsActive" />
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
                ForeColor="#99CC00" onclick="LinkButton1_Click">ADD NEW EMPLOYEE &gt;&gt;</asp:LinkButton>

</asp:View>
        <asp:View ID="vwDetails" runat="server">
            <!--Details View Here -->
<asp:SqlDataSource ID="dsEmployeeDetails" runat="server" 
    ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
    DeleteCommand="DELETE FROM [3TEmployees] WHERE [EmployeeId] = @EmployeeId" 
    InsertCommand="INSERT INTO [3TEmployees] (EmpTitle, EmpFirstName, EmpLastName, EmpPhotoUrl, EmpPhone, EmpEmail, EmpHireDate, EmpNotes, EmpIsActive, EmpDeptId) VALUES (@EmpTitle, @EmpFirstName, @EmpLastName, @EmpPhotoUrl, @EmpPhone, @EmpEmail, @EmpHireDate, @EmpNotes, @EmpIsActive, @EmpDeptId)" 
    oninserted="dsEmployeeDetails_Inserted" onupdated="dsEmployeeDetails_Updated" 
    SelectCommand="SELECT [3TEmployees].EmployeeId, [3TEmployees].EmpTitle, [3TEmployees].EmpFirstName, [3TEmployees].EmpLastName, [3TEmployees].EmpPhotoUrl, [3TEmployees].EmpPhone, [3TEmployees].EmpEmail, [3TEmployees].EmpHireDate, [3TEmployees].EmpNotes, [3TEmployees].EmpIsActive, [3TEmployees].EmpDeptId, [3TDepartments].DepartmentName, [3TDepartments].DepartmentId FROM [3TEmployees] INNER JOIN [3TDepartments] ON [3TEmployees].EmpDeptId = [3TDepartments].DepartmentId WHERE ([3TEmployees].EmployeeId = @EmployeeId)" 
    
        UpdateCommand="UPDATE [3TEmployees] SET [EmpTitle] = @EmpTitle, [EmpFirstName] = @EmpFirstName, [EmpLastName] = @EmpLastName, [EmpPhotoUrl] = @EmpPhotoUrl, [EmpPhone] = @EmpPhone, [EmpEmail] = @EmpEmail, [EmpHireDate] = @EmpHireDate, [EmpNotes] = @EmpNotes, [EmpIsActive] = @EmpIsActive, [EmpDeptId] = @EmpDeptId WHERE [EmployeeId] = @EmployeeId" 
        oninserting="dsEmployeeDetails_Inserting" 
        onupdating="dsEmployeeDetails_Updating">
    <DeleteParameters>
        <asp:Parameter Name="EmployeeId" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="EmpTitle" Type="String" />
        <asp:Parameter Name="EmpFirstName" Type="String" />
        <asp:Parameter Name="EmpLastName" Type="String" />
        <asp:Parameter Name="EmpPhotoUrl" Type="String" />
        <asp:Parameter Name="EmpPhone" Type="String" />
        <asp:Parameter Name="EmpEmail" Type="String" />
        <asp:Parameter Name="EmpHireDate" Type="DateTime" />
        <asp:Parameter Name="EmpNotes" Type="String" />
        <asp:Parameter Name="EmpIsActive" Type="Boolean" />
        <asp:Parameter Name="EmpDeptId" Type="Int32" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="gvEmployees" Name="EmployeeId" 
            PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="EmpTitle" Type="String" />
        <asp:Parameter Name="EmpFirstName" Type="String" />
        <asp:Parameter Name="EmpLastName" Type="String" />
        <asp:Parameter Name="EmpPhotoUrl" Type="String" />
        <asp:Parameter Name="EmpPhone" Type="String" />
        <asp:Parameter Name="EmpEmail" Type="String" />
        <asp:Parameter Name="EmpHireDate" Type="DateTime" />
        <asp:Parameter Name="EmpNotes" Type="String" />
        <asp:Parameter Name="EmpIsActive" Type="Boolean" />
        <asp:Parameter Name="EmpDeptId" Type="Int32" />
        <asp:Parameter Name="EmployeeId" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="dsMaxEmployee" runat="server" 
                ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                DeleteCommand="DELETE FROM [3TEmployees] WHERE [EmployeeId] = @EmployeeId" 
                InsertCommand="INSERT INTO [3TEmployees] ([EmpTitle], [EmpFirstName], [EmpLastName], [EmpPhotoUrl], [EmpPhone], [EmpEmail], [EmpHireDate], [EmpNotes], [EmpIsActive], [EmpDeptId]) VALUES (@EmpTitle, @EmpFirstName, @EmpLastName, @EmpPhotoUrl, @EmpPhone, @EmpEmail, @EmpHireDate, @EmpNotes, @EmpIsActive, @EmpDeptId)" 
                oninserted="dsEmployeeDetails_Inserted" 
                oninserting="dsEmployeeDetails_Inserting" onupdated="dsEmployeeDetails_Updated" 
                onupdating="dsEmployeeDetails_Updating" 
                SelectCommand="SELECT [3TEmployees].EmployeeId, [3TEmployees].EmpTitle, [3TEmployees].EmpFirstName, [3TEmployees].EmpLastName, [3TEmployees].EmpPhotoUrl, [3TEmployees].EmpPhone, [3TEmployees].EmpEmail, [3TEmployees].EmpHireDate, [3TEmployees].EmpNotes, [3TEmployees].EmpIsActive, [3TEmployees].EmpDeptId, [3TDepartments].DepartmentName, [3TDepartments].DepartmentId FROM [3TEmployees] INNER JOIN [3TDepartments] ON [3TEmployees].EmpDeptId = [3TDepartments].DepartmentId WHERE ([3TEmployees].EmployeeId = (SELECT MAX(EmployeeId) AS EMP FROM [3TEmployees] AS [3TEmployees_1]))" 
                UpdateCommand="UPDATE [3TEmployees] SET [EmpTitle] = @EmpTitle, [EmpFirstName] = @EmpFirstName, [EmpLastName] = @EmpLastName, [EmpPhotoUrl] = @EmpPhotoUrl, [EmpPhone] = @EmpPhone, [EmpEmail] = @EmpEmail, [EmpHireDate] = @EmpHireDate, [EmpNotes] = @EmpNotes, [EmpIsActive] = @EmpIsActive, [EmpDeptId] = @EmpDeptId WHERE [EmployeeId] = @EmployeeId">
                <DeleteParameters>
                    <asp:Parameter Name="EmployeeId" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="EmpTitle" Type="String" />
                    <asp:Parameter Name="EmpFirstName" Type="String" />
                    <asp:Parameter Name="EmpLastName" Type="String" />
                    <asp:Parameter Name="EmpPhotoUrl" Type="String" />
                    <asp:Parameter Name="EmpPhone" Type="String" />
                    <asp:Parameter Name="EmpEmail" Type="String" />
                    <asp:Parameter Name="EmpHireDate" Type="DateTime" />
                    <asp:Parameter Name="EmpNotes" Type="String" />
                    <asp:Parameter Name="EmpIsActive" Type="Boolean" />
                    <asp:Parameter Name="EmpDeptId" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="EmpTitle" Type="String" />
                    <asp:Parameter Name="EmpFirstName" Type="String" />
                    <asp:Parameter Name="EmpLastName" Type="String" />
                    <asp:Parameter Name="EmpPhotoUrl" Type="String" />
                    <asp:Parameter Name="EmpPhone" Type="String" />
                    <asp:Parameter Name="EmpEmail" Type="String" />
                    <asp:Parameter Name="EmpHireDate" Type="DateTime" />
                    <asp:Parameter Name="EmpNotes" Type="String" />
                    <asp:Parameter Name="EmpIsActive" Type="Boolean" />
                    <asp:Parameter Name="EmpDeptId" Type="Int32" />
                    <asp:Parameter Name="EmployeeId" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <asp:LinkButton ID="LinkButton2" runat="server" Font-Names="Arial" 
                ForeColor="#99CC00" onclick="LinkButton2_Click" CausesValidation="False">&lt;&lt; BACK TO EMPLOYEE LIST</asp:LinkButton>
            <br />
            <br />
<asp:DetailsView ID="dvEmployees" runat="server" AutoGenerateRows="False" 
    BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" 
    CellPadding="4" DataKeyNames="EmployeeId" DataSourceID="dsEmployeeDetails" 
    EnableViewState="False" Font-Names="Arial" ForeColor="Black" 
    GridLines="Vertical" Height="50px" Width="600px">
    <AlternatingRowStyle BackColor="White" />
    <EditRowStyle Font-Bold="True" />
    <Fields>
        <asp:BoundField DataField="EmployeeId" HeaderText="ID" InsertVisible="False" 
            ReadOnly="True" SortExpression="EmployeeId" />
        <asp:TemplateField HeaderText="Active" SortExpression="EmpIsActive">
            <EditItemTemplate>
                <asp:SqlDataSource ID="dsActive" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                    SelectCommand="SELECT [EmployeeId], [EmpIsActive] FROM [3TEmployees]">
                </asp:SqlDataSource>
                <asp:CheckBox ID="cbActive" runat="server" Checked='<%# Bind("EmpIsActive") %>' 
                    />
                <br />
                <br />
            </EditItemTemplate>  
            <InsertItemTemplate>
                <asp:SqlDataSource ID="dsActive" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                    SelectCommand="SELECT [EmployeeId], [EmpIsActive] FROM [3TEmployees]">
                </asp:SqlDataSource>
                <br />
                <asp:CheckBox ID="cbActive" runat="server" Checked='<%# Bind("EmpIsActive") %>' 
                    onprerender="cbActive_PreRender" />
                <br />
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Bind("EmpIsActive") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="EmpTitle" SortExpression="EmpTitle">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("EmpTitle") %>'></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="TextBox1" ErrorMessage="*Title is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("EmpTitle") %>'></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="TextBox1" ErrorMessage="*Title is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("EmpTitle") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Department" SortExpression="EmpTitle">
            <EditItemTemplate>
                <asp:SqlDataSource ID="dsDepartment" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                    SelectCommand="SELECT DepartmentId, DepartmentName FROM [3TDepartments]">
                </asp:SqlDataSource>
                <br />
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="dsDepartment" 
                    DataTextField="DepartmentName" DataValueField="DepartmentId" 
                    SelectedValue='<%# Bind("EmpDeptId") %>'>
                </asp:DropDownList>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="DropDownList1" ErrorMessage="*Department is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:SqlDataSource ID="dsDepartment" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:TSTConnectionString %>" 
                    SelectCommand="SELECT DepartmentId, DepartmentName FROM [3TDepartments]">
                </asp:SqlDataSource>
                <br />
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="dsDepartment" 
                    DataTextField="DepartmentName" DataValueField="DepartmentId" 
                    SelectedValue='<%# Bind("EmpDeptId") %>'>
                </asp:DropDownList>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="DropDownList1" ErrorMessage="*Department is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("DepartmentName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="First Name" SortExpression="EmpFirstName">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("EmpFirstName") %>'></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                    ControlToValidate="TextBox2" ErrorMessage="*First Name is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("EmpFirstName") %>'></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                    ControlToValidate="TextBox2" ErrorMessage="*First Name is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Bind("EmpFirstName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Last Name" SortExpression="EmpLastName">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("EmpLastName") %>'></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                    ControlToValidate="TextBox5" ErrorMessage="*Last Name is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("EmpLastName") %>'></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                    ControlToValidate="TextBox5" ErrorMessage="*Last Name is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Bind("EmpLastName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Photo" SortExpression="EmpPhotoUrl">
            <EditItemTemplate>
                <asp:FileUpload ID="fuEmp" runat="server" />
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:FileUpload ID="fuEmp" runat="server" />
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" Width="200px" 
                    ImageUrl='<%# Bind("EmpPhotoUrl","~/screenImages/{0}") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Phone" SortExpression="EmpPhone">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("EmpPhone") %>'></asp:TextBox>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="TextBox6" ErrorMessage="*Valid Phone Number Required" 
                    ForeColor="#CC0000" 
                    ValidationExpression="^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$"></asp:RegularExpressionValidator>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("EmpPhone") %>'></asp:TextBox>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="TextBox6" ErrorMessage="*Valid Phone Number Required" 
                    ForeColor="#CC0000" 
                    ValidationExpression="^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$"></asp:RegularExpressionValidator>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label8" runat="server" Text='<%# Bind("EmpPhone") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email" SortExpression="EmpEmail">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("EmpEmail") %>'></asp:TextBox>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="TextBox7" ErrorMessage="*Valid Email is Required" 
                    ForeColor="#CC0000" 
                    ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"></asp:RegularExpressionValidator>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("EmpEmail") %>'></asp:TextBox>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="TextBox7" ErrorMessage="*Valid Email is Required" 
                    ForeColor="#CC0000" 
                    ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"></asp:RegularExpressionValidator>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label9" runat="server" Text='<%# Bind("EmpEmail") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Hire Date" SortExpression="EmpHireDate">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("EmpHireDate") %>'></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                    ControlToValidate="TextBox3" ErrorMessage="*Hire Date is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
                <asp:CalendarExtender ID="TextBox3_CalendarExtender" runat="server" 
                    Enabled="True" TargetControlID="TextBox3">
                    

                </asp:CalendarExtender>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" 
                    Text='<%# Bind("EmpHireDate", "{0:d}") %>'></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                    ControlToValidate="TextBox3" ErrorMessage="*Hire Date is Required" 
                    ForeColor="#CC0000"></asp:RequiredFieldValidator>
                <asp:CalendarExtender ID="TextBox3_CalendarExtender" runat="server" 
                    Enabled="True" TargetControlID="TextBox3">
                    

                </asp:CalendarExtender>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" 
                    Text='<%# Bind("EmpHireDate", "{0:d}") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Notes" SortExpression="EmpNotes">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("EmpNotes") %>' 
                    TextMode="MultiLine" Height="100px" Width="80%"></asp:TextBox>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("EmpNotes") %>' 
                    TextMode="MultiLine" Height="100px" Width="80%"></asp:TextBox>
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("EmpNotes") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ShowHeader="False">
            <EditItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                    CommandName="Update" Text="Update"></asp:LinkButton>
                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                    CommandName="Cancel" onclick="LinkButton2_Click1" Text="Cancel"></asp:LinkButton>
            </EditItemTemplate>
            <InsertItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                    CommandName="Insert" Text="Insert"></asp:LinkButton>
                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                    CommandName="Cancel" Text="Cancel" onclick="LinkButton2_Click2"></asp:LinkButton>
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

<br />


</asp:Content>

