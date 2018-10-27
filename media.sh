#!/bin/bash
HOST_TEMP=$KVM_HOST
USERNAME=$KVM_USER
PASSWORD=$KVM_PASSWORD
JNLP_FILE=temp.$$.jnlp
DOMAIN=$KVM_DOMAIN

#check host is passed in
if [ "x$HOST_TEMP" == "x" ]
then
        echo "usage: $0 <host>"
        exit 2
fi

HOST=$(nslookup -domain=home $HOST_TEMP | grep Name: | awk '{print $2}')
if [ "x$HOST" == "x" ]
then
        echo "$HOST_TEMP not found"
        exit 2
fi

cat > $JNLP_FILE <<END
<?xml version="1.0" encoding="UTF-8"?>
<jnlp codebase="https://${HOST}:443/" spec="1.0+">
<information>
  <title>Virtual Media Client</title>
  <vendor>Hewlett-Packard Corporation</vendor>
   <icon href="http://${HOST}:80/images/logo.gif" kind="splash"/>
   <shortcut online="true"/>
 </information>
 <application-desc main-class="com.avocent.vm.VirtualMedia">
   <argument>ip=${HOST}</argument>
   <argument>port=2068</argument>
   <argument>user=${USERNAME}</argument>
   <argument>password=${PASSWORD}</argument>
   <argument>title=${HOST}</argument>
 </application-desc>
 <security>
   <all-permissions/>
 </security>
 <resources>
   <j2se version="1.6 1.5 1.4+"/>
   <jar href="http://${HOST}:80/software/avctVM.jar" download="eager" main="true" />
   <jar href="http://${HOST}:80/software/jpcsc.jar" download="eager"/>
 </resources>
 <resources os="Windows">
   <nativelib href="http://${HOST}:80/software/avctVMWin32.jar" download="eager"/>
  </resources>
  <resources os="Linux">
    <nativelib href="http://${HOST}:80/software/avctVMLinux.jar" download="eager"/>
  </resources>
</jnlp>
END

javaws ${JNLP_FILE}
rm ${JNLP_FILE}

