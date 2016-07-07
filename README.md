# burp_der_cert_to_android_cert
TL;DR - This script converts DER certificates from Burp Suite for usage into Android cert store. 

While pentesting, it is common to use Burp Suite Proxy to add a certificate to proxy traffic.  However, by adding a user certificate, there is a requirement to have a lock screen.
I found this to be annoying and read an article on how to convert the format.

I initially read http://wiki.cacert.org/FAQ/ImportRootCert on how to create certs to push into the /system partition so a lock screen is not necessary.  The instructions on the site gave me a rough understanding of how to do it, but I felt there should be a simple script that does the conversion.

