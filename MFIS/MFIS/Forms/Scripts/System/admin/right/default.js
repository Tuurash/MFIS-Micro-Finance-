$(function () {
    initial_work();
});
function initial_work() {   
    empty_details_data();
}
///---Load Details Part----//
function empty_details_data() {
    //alert('didar');
    $("#tbl_details tbody tr").remove();
    var rows = '<tr class="input_fields_box">'
    + '<td><select id="dll_privelege1" style="width:95%;"></select></td>'
    + '<td><select id="ddl_add1" width:100%; style="width:95%"> <option value="1">Yes</option><option value="0">No</option></select></td>'
    + '<td><select id="ddl_edit1" width:100%; style="width:95%"> <option value="1">Yes</option><option value="0">No</option></select></td>'
    + '<td><select id="ddl_delete1" width:100%; style="width:95%"> <option value="1">Yes</option><option value="0">No</option></select></td>'
    + '<td><select id="ddl_status1" width:100%; style="width:95%"> <option value="1">Yes</option><option value="0">No</option></select></td>'
    + '<td><input id="btn_temp_add1" style="width:100%" class="add_field_button" type="button" value="Add" /></td>'
    + '<td><input id="" class="remove_field" style="width:100%" type="button" value="Remove" /></td>'
    + '</tr>';
    $('#tbl_details tbody').append(rows);
}
//-----------------Add Multiple Element--------------------//
jQuery_1_7_2(window).load(function () {
    var x = 1; //initilal text box count
    var max_elements = 50; //maximum input elements allowed      
    //--------------------------//
    jQuery_1_7_2(".add_field_button").live('click', function () {
        var x = document.getElementById('hdn_count_element').value;
        if (x <= max_elements) {
            var $tr = $(this).closest('.input_fields_box');
            var $clone = $tr.clone();
            $clone.find(':text').val('');
            $clone.find('textarea').val('');
            $clone.find('.remove_field').attr("id", ''); //Remove Button ID Set Empty For New Clone Data Update.
            $clone.find('select option:first-child').attr("selected", "selected");
            $clone.find('*').each(function (index, element) {
                var ele_id = element.id;
                $('#' + ele_id).attr("id", ele_id + x);
            });
            $tr.after($clone);
            x++;
            document.getElementById('hdn_count_element').value = x;
        }
    });
});
//------------------Remove Element-----------------//
var total_remove_element_id = "";
jQuery_1_7_2(window).load(function () {
    jQuery_1_7_2(".remove_field").live("click", function () {
        var x = document.getElementById('hdn_count_element').value;
        if (x > 1) {
            $(this).parents(".input_fields_box").remove();
            x--;
            document.getElementById('hdn_count_element').value = x;
            //---------------------------------//
            var remove_single_id = $(this).attr("id");
            total_remove_element_id += remove_single_id + "#";
            $('#hdn_remove_all_id').val(total_remove_element_id);
            //---------------------------------//
            //summation_price();
        }
    });
});
///----------Drop down User Name--------//
$(function () {
    $.ajax({
        type: "POST",
        url: "../../../system/admin/right/default.aspx/user_name",
        data: "{ }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {
            var ddlCustomers = $('#dll_user_name');
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
///----------Drop down Deaprtment--------//
$(function () {
    $.ajax({
        type: "POST",
        url: "../../../system/admin/right/default.aspx/department",
        data: "{ }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {
            var ddlCustomers = $('#dll_Department');
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
///----------Drop down privilege--------//
$(function () {
    $.ajax({
        type: "POST",
        url: "../../../system/admin/right/default.aspx/privilege",
        data: "{ }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (r) {
            var ddlCustomers = $('#dll_privelege1');
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

//--------Get Details table data dynamically--------//
var DetailsTable =
{
    getData: function (table) {
        var data = [];
        table.find('tr').not(':first').each(function (rowIndex, r) {
            var cols = [];
            $(this).find('td').each(function (colIndex, c) {
                if ($(this).children(':text,textarea,select,input[type="hidden"]').length > 0)
                    cols.push($(this).children('input,textarea,select,input[type="hidden"]').val().trim());
                    //if dropdown text is needed then uncomment it and remove SELECT from above IF condition//
                else if ($(this).children('select').length > 0)
                    cols.push($(this).find('option:selected').text());
                else if ($(this).children(':checkbox').length > 0)
                    cols.push($(this).children(':checkbox').is(':checked') ? 1 : 0);
                else {
                    //cols.push($(this).text().trim());
                    cols.push($(this).find('.remove_field').attr('id'));
                }
            });
            data.push(cols);
        });
        return data;
    }
}


// ----------------- Save Master Data--------// 
$(document).on('click', '#btnSave', function () {
    var master_id = $('#dll_user_name').val();
    if (master_id != "" || master_id != 0) {
        $('#msg').html("Row saved ");
        //--------------For Details Table----------------//
        var data = DetailsTable.getData($('#tbl_details'));  // passing that table's ID //
        var parameters = {};
        var identify_data = [["master_id", master_id]];
        parameters.array = data;
        parameters.array1 = identify_data;
        var request = $.ajax({
            async: true,
            cache: false,
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../../system/admin/right/default.aspx/SaveDetails",
            data: JSON.stringify(parameters)
        });

        request.done(function (msg) {
            $('#msg').html("Data Saved ");
            //show_data('show');
            empty_element('#tbl_details');
        });

        request.fail(function (jqXHR, textStatus) {
            $('#msg').html("Request failed: " + textStatus);
        });
        //------------End Details Part--------------------//
    }

});

//------------------Search Data-------------------//
function search_data(action) {
    var master_id = "";
    var search_data = "";
    if (action == "show") {
        $('#dll_user_name').val('');
    }
    else if (action == "search") {
        search_data = $('#dll_user_name').val();
    }
    else {
        search_data = action;
    }
    //---------------Remove Old Data----------------//
    $("#tblCustomers tbody tr").remove();
    $("#tbl_details tbody tr").remove();
    //---------------Call Ajax Function-------------//
    $.ajax({
        type: "POST",
        url: "../../../system/admin/right/default.aspx/show_data",
        data: "{ 'search_data': '" + search_data + "','action': '" + action + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var Employees = response.d;
            $.each(Employees, function (index, item) {
                if (search_data != "") {
                    $('#hdn_master_id').val(item.emp_id);
                }
                // To convert Date
                //var pattern = /Date\(([^)]+)\)/;
                //var results = pattern.exec(item.PDate);
                //var dt = new Date(parseFloat(results[1]));
                //var date = (dt.getMonth() + 1) + "/" + dt.getDate() + "/" + dt.getFullYear();
                //$('#Txtdate').val(date);
                $('#txtEmpId').val(item.emp_id);
                $('#txt_emp_name').val(item.emp_name);
                $('#txtaddresss').val(item.adddresss);
                $('#txtaddresss').val(item.adddresss);
                $('#txt_pwd').val(item.pass);
                //var myRadio = $('input[name=merit_status]');
                //var checkedValue = myRadio.filter(':checked').val(item.meritial_status);
                var $radios = $('input:radio[name=merit_status]');
                $radios.filter('[value=' + item.meritial_status + ']').prop('checked', true);
                $('#txt_teritory').val(item.territory_name);
                $('#msg').html("");
                $("#btnSave").attr("disabled", true);
                set_drop_down_list('drp_district', 'Select Please', item.district_code, ' zilla_info', 'zilla_code', 'zilla_name', '', '');
            });
            var master_id = $('#hdn_master_id').val();
            show_details_data(master_id);
            //show_specialization_details_data(master_id)
        },
        error: function (data, success, error) {
            $('#msg').html("Error:" + error);
        }
    });
}

