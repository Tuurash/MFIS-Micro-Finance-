///----------Drop down Console--------//
$(function () {
    $.ajax({
        type: "POST",
        url: "../../../system/admin/priviledge/default.aspx/project_code",
        data: "{ }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {
            var ddlCustomers = $('#dll_project');
            ddlCustomers.empty().append('<option selected="selected" value="0">Please select</option>');
            $.each(r.d, function () {
                ddlCustomers.append($("<option></option>").val(this['Value']).html(this['Text']));
            });
            $("#menu").removeClass("ui-menu ui-widget ui-widget-content");
            $("ul").removeClass("ui-menu ui-widget ui-widget-content ui-front");
            $("li").removeClass("ui-menu-item");
            $("span").removeClass("ui-menu-icon ui-icon ui-icon-carat-1-e");
            $("ul").removeAttr("style");
            $("ul").removeClass("ui-autocomplete");
        }
    });

});

///----------Drop down Module--------//
$(function () {
    $.ajax({
        type: "POST",
        url: "../../../system/admin/priviledge/default.aspx/Module_code",
        data: "{ }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {
            var ddlCustomers = $('#dll_module');
            ddlCustomers.empty().append('<option selected="selected" value="0">Please select</option>');
            $.each(r.d, function () {
                ddlCustomers.append($("<option></option>").val(this['Value']).html(this['Text']));
            });
            $("#menu").removeClass("ui-menu ui-widget ui-widget-content");
            $("ul").removeClass("ui-menu ui-widget ui-widget-content ui-front");
            $("li").removeClass("ui-menu-item");
            $("span").removeClass("ui-menu-icon ui-icon ui-icon-carat-1-e");
            $("ul").removeAttr("style");
            $("ul").removeClass("ui-autocomplete");
        }
    });

});
///----------Drop down Parent--------//
$(function () {
    $.ajax({
        type: "POST",
        url: "../../../system/admin/priviledge/default.aspx/parent_code",
        data: "{ }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {
            var ddlCustomers = $('#dll_parent');
            ddlCustomers.empty().append('<option selected="selected" value="0">Please select</option>');
            $.each(r.d, function () {
                ddlCustomers.append($("<option></option>").val(this['Value']).html(this['Text']));
            });
            $("#menu").removeClass("ui-menu ui-widget ui-widget-content");
            $("ul").removeClass("ui-menu ui-widget ui-widget-content ui-front");
            $("li").removeClass("ui-menu-item");
            $("span").removeClass("ui-menu-icon ui-icon ui-icon-carat-1-e");
            $("ul").removeAttr("style");
            $("ul").removeClass("ui-autocomplete");
        }
    });

});

// ----------------- Save Master Data--------// 
$(document).on('click', '#btnSave', function () {
    $.ajax(
       {
           type: "POST",
           url: "../../../system/admin/priviledge/default.aspx/insertDt",
           data: "{dll_project: '" + $('#dll_project').val() + "',dll_module: '" + $('#dll_module').val() + "',txt_pv_name: '" + $('#txt_pv_name').val() + "',dll_parent: '" + $('#dll_parent').val() + "',txt_url: '" + $('#txt_url').val() + "',dll_active: '" + $('#dll_active').val() + "'}",
           contentType: "application/json; charset=utf-8",
           dataType: "json",
           success: function (msg) {
               $('#msg').html("Successfully Saved");
           }
       });
});