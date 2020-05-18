$(document).ready(function(){
        $("input[type='radio']").click(function(){
            var radioValue = document.getElementById("customreviewrule_reviewtype_default").checked;
            //var radioValue = $("#customreviewrule_reviewtype_default").val();
            if(radioValue){
                document.getElementById("customreviewrule_numberoflinesincontroller").value = 20;
                document.getElementById("customreviewrule_numberoflinesinmodel").value = 20;
                document.getElementById("customreviewrule_numberoflinesinhelper").value = 20;
                document.getElementById("customreviewrule_numberoflinesinview").value = 20;
            }
            else{
                document.getElementById("customreviewrule_numberoflinesincontroller").value ='';
                document.getElementById("customreviewrule_numberoflinesinmodel").value = '';
                document.getElementById("customreviewrule_numberoflinesinhelper").value = '';
                document.getElementById("customreviewrule_numberoflinesinview").value = '';
            }
        });
});