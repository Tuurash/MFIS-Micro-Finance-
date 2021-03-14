<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Pages/Home.Master" AutoEventWireup="true" CodeBehind="frmDepositGrid.aspx.cs" Inherits="MFIS.Forms.LoanDeposit.frmDepositGrid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Last Entry</h3>
                            <br />
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <%--<table id="example2" class="table table-bordered table-hover">--%>


                            <asp:GridView runat="server" ID="gridLastPayment" AutoGenerateColumns="false" CssClass="table table-bordered table-hover">

                                <Columns>


                                    <asp:TemplateField HeaderText="Amount" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAmount" Text='<%# Bind("Cr")%>'>asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Date" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblLC" Text='<%# Bind("PDate")%>'>asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Type" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAmount2" Text='<%# Bind("DType")%>'>asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>

                            </asp:GridView>

                            <div align="center">
                                <br />
                                <asp:Button ID="btnGetReport" runat="server" CssClass="btn btn-default" Text="GetReport" OnClick="btnGetReport_Click" />
                                <asp:Button ID="btnShowAllHistory" runat="server" CssClass="btn btn-default" Text="Show All" OnClick="btnShowAllHistory_Click" />
                                <br />
                            </div>
                            <br />
                            <div id="divHistory" runat="server" visible="false">
                                <asp:GridView runat="server" ID="dgHistory" AutoGenerateColumns="false" CssClass="table table-bordered table-hover" AllowPaging="true" OnPageIndexChanging="dgHistory_PageIndexChanging" PageSize="10">
                                    <Columns>

                                        <asp:TemplateField HeaderText="A/C no" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblCustAcNo" Text='<%# Bind("AccountNo")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Amount" Visible="true">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblAmount" Text='<%# Bind("PaidAmount")%>'>asd</asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Date" Visible="true">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblLC" Text='<%# Bind("PDate","{0:dd.MMM.yy}")%>'>asd</asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Type" Visible="true">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblAmount2" Text='<%# Bind("DType")%>'>asd</asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </div>

                        </div>
                        <!-- /.card-body -->
                    </div>

                </div>

            </div>

        </div>

    </section>



</asp:Content>
