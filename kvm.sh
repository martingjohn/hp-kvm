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

HOST=$(nslookup -domain=${DOMAIN} $HOST_TEMP | grep Name: | awk '{print $2}')
if [ "x$HOST" == "x" ]
then
        echo "$HOST_TEMP not found"
        exit 2
fi

cat > $JNLP_FILE <<END
<?xml version="1.0" encoding="UTF-8"?>
<jnlp codebase="https://${HOST}:443/" spec="1.0+">
<information>
  <title>Virtual KVM Client</title>
  <vendor>Hewlett-Packard Corporation</vendor>
   <icon href="http://${HOST}:80/images/logo.gif" kind="splash"/>
   <shortcut online="true"/>
 </information>
 <application-desc main-class="com.avocent.kvm.client.Main">
   <argument>title=Virtual KVM Session - ${HOST}</argument>
   <argument>ip=${HOST}</argument>
   <argument>platform=ast2050</argument>
   <argument>vmprivilege=true</argument>
   <argument>user=${USERNAME}</argument>
   <argument>passwd=${PASSWORD}</argument>
   <argument>kmport=2068</argument>
   <argument>vport=2068</argument>
   <argument>apcp=1</argument>
   <argument>version=2</argument>
 </application-desc>
 <security>
   <all-permissions/>
 </security>
 <resources>
   <j2se version="1.6 1.5 1.4+"/>
   <jar href="http://${HOST}:80/software/avctKVM.jar" download="eager" main="true" />
 </resources>
 <resources os="Windows">
   <nativelib href="http://${HOST}:80/software/avctKVMIOWin32.jar" download="eager"/>
 </resources>
  <resources os="Linux">
    <nativelib href="http://${HOST}:80/software/avctKVMIOLinux.jar" download="eager"/>
  </resources>
</jnlp>
END

javaws ${JNLP_FILE}
rm ${JNLP_FILE}

