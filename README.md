# eap74-sample

watch -n1 "ss -anp | grep 3306 | grep ESTAB | wc -l"

ab -n20 -c20 https://eap-app-ss.apps.pst.local/simple/delay.jsp

