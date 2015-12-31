
# Create the server and application client key stores and certificates
keytool -genkeypair -alias serverkey -keyalg RSA -keysize 2048 -dname "CN=Test Server,OU=Brase Clinic,O=Kenya Relief,L=Detroit,S=MI,C=US" -keypass password -storepass password -keystore server.jks
keytool -genkeypair -alias clientkey -keyalg RSA -keysize 2048 -dname "CN=Test Client,OU=Brase Clinic,O=Kenya Relief,L=Detroit,S=MI,C=US" -keypass password -storepass password -keystore client.jks
 
# Copy the client's public certificate to the server's keystore
keytool -exportcert -keystore client.jks -storepass password -file client-public.cer -alias clientkey
keytool -importcert -keystore server.jks -storepass password -file client-public.cer -alias clientcert -noprompt
 
# Take a peek at the server's keystore to make sure that the client's certificate is there
keytool -v -list -keystore server.jks -storepass password
 
# Copy the server's public certificate to the client's keystore
keytool -exportcert -keystore server.jks -storepass password -file server-public.cer -alias serverkey
keytool -importcert -keystore client.jks -storepass password -file server-public.cer -alias servercert -noprompt
 
# Take a peek at the client's keystore to make sure that the client's certificate is there
keytool -v -list -keystore client.jks -storepass password
 
# Create a browser keystore most browsers can read easily
keytool -importkeystore -srckeystore client.jks -srcstorepass password -srcalias clientkey -destkeystore client.p12 -deststoretype PKCS12 -deststorepass password -destalias clientkey -noprompt
 
# Take a peek at the browser's keystore to make sure that the client's certificate is there
keytool -v -list -keystore client.p12 -storetype pkcs12 -storepass password

