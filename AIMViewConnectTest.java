import java.io.*;
import java.net.*;

public class AIMViewConnectTest {
 public static final int MESSAGE_GET_AUDIENCE_STATUS = 0;
 public static final int EVENT_ACK = 128;
 public static final int EVENT_NACK = 129;
 public static final int EVENT_AUDIENCE_STATUS = 130;

 public static void main(String[] args) {

 try {
   System.out.println("Start AIM Suite Connect Test");

   // Open a socket on the local host, port 12500 (default for AIM Suite)

   Socket myClient = new Socket("192.168.100.66", 12500);

   System.out.println("myClient = " + myClient);
   DataInputStream input;
   DataOutputStream output;
   input = new DataInputStream(myClient.getInputStream());
   System.out.println("input = " + input);
   output = new DataOutputStream(myClient.getOutputStream());
   System.out.println("output = " + output);

   // First we will set up the request message as a byte stream
   byte request[] = new byte[5];
   request[0] = (byte)0xFA; // Magic word (first byte)
   request[1] = (byte)0xCE; // Magic word (second byte)
   request[2] = (byte)0x01; // Version
   request[3] = (byte)MESSAGE_GET_AUDIENCE_STATUS; // Command
   request[4] = (byte)0x00; // Payload size (0 for apiGetAudienceStatus)
   output.write(request, 0, 5); // Send the request

   boolean reading = true;
   int bytesRead = 0;

   // For apiGetAudienceStatus, we will read back
   // the 5 byte header + 1 byte for the payload.
   // Other response messages could have different
   // types of payload sizes, but this one is really simple.

   byte response[] = new byte[6];

   // Loop until we have read the desired number of bytes (or an error occurs)

   while(reading && bytesRead < 6) {
     try {
       response[bytesRead] = input.readByte();
       System.out.println("bytesRead" + " "+ bytesRead);
       bytesRead++;
     }

     catch(IOException e) {
       reading = false;
     }
   }

   // Verify that the returned byte stream has the magic word

   if(response[0] == (byte)0xFA && response[1] == (byte)0xCE) {

     System.out.println("Magic word detected");

     // Verify that the version is correct

     if(response[2] == (byte)0x01) {
       System.out.println("Version is correct");

       // Verify that we got the desired response (EVENT_AUDIENCE_STATUS)

       if(response[3] == (byte)AIMViewConnectTest.EVENT_AUDIENCE_STATUS) {
         System.out.println("Received EVENT_AUDIENCE_STATUS message");

         // Verify that the payload size is correct
         if(response[4] == (byte)1) {
           // The audience size will be in the payload of the
           // returned message (located at element 5 in the array)
           System.out.println("Audience Size: " + response[5]);
         }

         else {
           System.out.println("Incorrect payload size: " + response[4]);
         }

       }

       else {
         System.out.println("Incorrect response message: " + response[3]);
       }
     }

     else {
       System.out.println("Incorrect version: " + response[2]);
     }

   }

   else {
     System.out.println("Incorrect magic word: 0x" + response[0] + response[1]);
   }

   input.close();
   output.close();

   }

   catch(Exception exp) {
     exp.printStackTrace();
   }
 }
}
