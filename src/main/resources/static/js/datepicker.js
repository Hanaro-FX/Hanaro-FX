let datePickerOption = function (option) {
    return {
        startYear: 2000,
        finalYear: new Date().getFullYear(),
        monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        dateFormat: 'yy-mm-dd',
        showOtherMonths: true,
        showMonthAfterYear: true,
        changeYear: true,
        changeMonth: true,
        showOn: 'both',
        buttonImage: "https://cdn-icons-png.flaticon.com/512/2838/2838779.png",
        buttonImageOnly: true,
        minDate: new Date(2000, 0),
        maxDate: new Date(2024, 2, 31),
        yearRange: '2000:c',
        beforeShowDay: function (date) {
            let day = date.getDay();
            return [(day !== 0 && day !== 6), ''];
        },
        onSelect: function (selected) {
            let selectedDate = $('#endDate').datepicker('getDate');
            selectedDate.setDate(selectedDate.getDate() - 1);
            $('#startDate').datepicker('option', option, selectedDate);
            $("#ui-datepicker-div").find(".ui-state-active").removeClass("ui-state-active");
        }
    }
}