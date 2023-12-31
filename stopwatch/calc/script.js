console.log("JS started.");
a = document.querySelectorAll("input");
console.log(a);
function do_action(sign)
{
    return eval( document.querySelectorAll("input")[0].value + sign +  document.querySelectorAll("input")[1].value )   ;
}
function add()
{
    do_action("+");
}