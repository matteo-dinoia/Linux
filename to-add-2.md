sudo nano /etc/passwd
root:x:0:0::/root:/usr/sbin/nologin

sudo nano /etc/security/faillock.conf
deny = 6
fail_interval = 2700
unlock_time = 300

sudo chmod 700 /bin/faillock
// cannot use faillock anymore


pdftk input.pdf cat 2-4 output out1.pdf
