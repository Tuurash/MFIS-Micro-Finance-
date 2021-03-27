<%@ Page Title="" Language="C#" MasterPageFile="~/home/admin/dashboard/Home.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="CRM.data.system_admin.right._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script src="default.js"></script>
<center><h3 class="box-title">User Right</h3></center>
     <table id="tbldata" style="border-style: none; border-color: inherit; border-width: 0; width:100%;" >
            <tr>
                <td style="width:6%; height:50px"></td>
                <td style="width:9%; text-align:left; height:50px">User Name</td>
                <td style="width:1%; height:50px">:</td>
                <td style="width:20%; height:50px">
                    <select id="dll_user_name" style="height:30px;width:80%;" onchange="" name="D3">
                    </select></td>
                <td style="width:8%; height:50px">
                    <button id="btn-find" class="btn btn-default" onclick="search_data('search')" type="button">
                        Find
                    </button>
                </td>
                <td style="width:1%; height:50px">
                    &nbsp;</td>
                <td style=" width:17%; height:50px">
                    &nbsp;</td>
                <td style="width:34%; height:50px"></td>
            </tr>     
           <tr>
                <td style="width:6%; height:50px"></td>
                <td style="width:9%; text-align:left; height:50px">Department<td style="width:1%; height:50px">:</td>
                <td style="width:20%; height:50px">
                    <select id="dll_Department" style="height:30px;width:80%;">
                    </select></td>
                <td style="width:8%; height:50px">&nbsp;</td>
                <td style="width:1%; height:50px">
                    &nbsp;</td>
                <td style=" width:17%; height:50px">
                    &nbsp;</td>
                <td style="width:34%; height:50px"></td>
            </tr>   
        </table> 

   
      <input id="hdn_master_id" type="hidden" /> 
    <input id="hdn_count_element" type="hidden" value="1"/>
    <input id="hdn_remove_all_id" type="hidden"/>  
<div class="box-body table-responsive no-padding">
  <table class="table table-hover table-bordered" style="background-color:white" id="tbl_details">
        <thead>
            <tr>                
            <th style="width:50%">Privilege Name</th>
            <th style="width:10%">Add</th>
            <th style="width:10%">Edit</th>
            <th style="width:10%">Delete</th>
            <th style="width:10%">Status</th>
            <th colspan="2" style="width:5%">Action</th>
            </tr>
        </thead>
        <tbody>
        <%-- empty_details_data() Function work for comments Tag--%>
        </tbody>             
   </table>
</div>
        <div id="msg"> </div> 
    <br/>
       <table style="width:100%">
        <tr>
            <td style="width:20%">
                  <input id="hdn_total_rec" type="hidden" value="0"/>  <%--total record--%>
            </td>
        <td style="width:33%">
            <input type="button" id="btn_new"  style="width:70px; height:30px; font-weight: 700; color: #FFFFFF; background-color: #333333;" value=" New " onclick="set_new_button()"/>
            <input type="button" id="btnSave"  style="width:70px; height:30px; font-weight: 700; color: #FFFFFF; background-color: #333333;" value="Save" />
            <input type="button" id="btnedit"  style="width:70px; height:30px; font-weight: 700; color: #FFFFFF; background-color: #333333;" value="Edit" />
            <input type="button" id="btndel"  style="width:70px; height:30px; font-weight: 700; color: #FFFFFF; background-color: #333333;" value="Delete" />             
                    
        </td>
         <td style="width:46%">
            </td>
        </tr>
    </table>

</asp:Content>
