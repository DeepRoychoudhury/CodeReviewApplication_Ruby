//= require jquery

$(document).ready(function(){
        $("input[type='radio']").click(function(){
            var radioValue = document.getElementById("customreviewrule_reviewtype_default").checked;
            if(radioValue){
                document.getElementById("customreviewrule_numberoflinesincontroller").value = 100;
                document.getElementById("customreviewrule_numberoflinesincontroller").readOnly = true;
                document.getElementById("customreviewrule_numberoflinesinmodel").value = 100;
                document.getElementById("customreviewrule_numberoflinesinmodel").readOnly = true;
                document.getElementById("customreviewrule_numberoflinesinhelper").value = 100;
                document.getElementById("customreviewrule_numberoflinesinhelper").readOnly = true;
                document.getElementById("customreviewrule_numberoflinesinview").value = 100;
                document.getElementById("customreviewrule_numberoflinesinview").readOnly = true;
            }
            else{
                document.getElementById("customreviewrule_numberoflinesincontroller").value ='';
                document.getElementById("customreviewrule_numberoflinesincontroller").readOnly = false;
                document.getElementById("customreviewrule_numberoflinesinmodel").value = '';
                document.getElementById("customreviewrule_numberoflinesinmodel").readOnly = false;
                document.getElementById("customreviewrule_numberoflinesinhelper").value = '';
                document.getElementById("customreviewrule_numberoflinesinhelper").readOnly = false;
                document.getElementById("customreviewrule_numberoflinesinview").value = '';
                document.getElementById("customreviewrule_numberoflinesinview").readOnly = false;
            }
        });
});