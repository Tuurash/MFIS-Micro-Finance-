<%@ Page Title="" Language="C#" MasterPageFile="~/home/admin/dashboard/Home.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="CRM.data.system_admin.priviledge._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="default.js"></script>
    <center><h3 class="box-title">Add New Privilege</h3></center>
     <table id="tbldata" style="border-style: none; border-color: inherit; border-width: 0; width:100%;" >
            <tr>
                <td style="width:6%"></td>
                <td style="width:9%; text-align:left;">Console</td>
                <td style="width:1%">:</td>
                <td style="width:20%">
                    <select id="dll_project" style="height:22px;width:80%;" onchange="voucher_no()" name="D3">
                    </select></td>
                <td style="width:8%">&nbsp;</td>
                <td style="width:1%">
                    &nbsp;</td>
                <td style=" width:17%">
                    &nbsp;</td>
                <td style="width:34%"></td>
            </tr>
            <tr>
                <td></td>
                <td>Module</td>
                <td>:</td>
                <td>                   
                    <select id="dll_module" style="height:22px;width:80%;" name="D2" >
                    </select></td>
                <td >&nbsp;</td>
                <td >&nbsp;</td>
                <td >
                    &nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td class="auto-style498"></td>
                <td class="auto-style485">Privilege Name</td>
                <td class="auto-style470">:</td>
                <td class="auto-style499">
                    <input id="txt_pv_name" type="text" style="width:90%"/></td>
                <td class="auto-style497">&nbsp;</td>
                <td class="auto-style470">&nbsp;</td>
                <td class="auto-style500">
                    <input id="account_code" type="hidden" />
                    </td>
                <td class="auto-style495"></td>
            </tr>
            <tr>
                <td class="auto-style498"></td>
                <td class="auto-style485">Parent</td>
                <td class="auto-style470">:</td>
                <td class="auto-style499">
                    <input id="txt_supplier_code" type="hidden" />
                    <select id="dll_parent" style="height:22px;width:80%;" name="D5" >
                    </select></td>
                <td class="auto-style497">&nbsp;</td>
                <td class="auto-style470">&nbsp;</td>
                <td class="auto-style500">
                    &nbsp;</td>
                <td class="auto-style495"></td>
            </tr>
           <tr>
                <td class="auto-style498"></td>
                <td class="auto-style485">URL</td>
                <td class="auto-style470">:</td>
                <td class="auto-style499">
                    <input id="txt_supplier_code" type="hidden" />
                    <input id="txt_url" type="text" style="width:90%"/></td>
                <td class="auto-style497">&nbsp;</td>
                <td class="auto-style470">&nbsp;</td>
                <td class="auto-style500">
                    &nbsp;</td>
                <td class="auto-style495"></td>
            </tr>
            <tr>
                <td class="auto-style498"></td>
                <td class="auto-style485">
                    
                    Active</td>
                <td class="auto-style470">:</td>
                <td class="auto-style499">                   
                    <select id="dll_active" style="height:22px;width:80%;" name="D4" ><option value="1"> Yes</option>
                        <option value="0"> No</option>
                    </select></td>
                <td class="auto-style497">&nbsp;</td>
                <td class="auto-style470">&nbsp;</td>
                <td class="auto-style500">&nbsp;</td>
                <td class="auto-style495"></td>
            </tr>
        </table> 
    <div id="msg">
    </div>
    <br/>
       <table style="width:100%">
        <tr>
            <td style="width:20%">
                  <input id="hdn_total_rec" type="hidden" value="0"/>  <%--total record--%>
            </td>
            <td style="width:33%">
        <input type="button" id="btnSave"  style="width:70px; height:30px; font-weight: 700; color: #FFFFFF; background-color: #333333;" value="Save" />
                    
         </td>
         <td style="width:46%">
            </td>
        </tr>
    </table>
</asp:Content>
