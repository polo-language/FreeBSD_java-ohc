--- ohc-core/src/main/java/org/caffinitas/ohc/linked/Uns.java.orig	2016-08-27 18:00:44 UTC
+++ ohc-core/src/main/java/org/caffinitas/ohc/linked/Uns.java
@@ -236,49 +236,49 @@ final class Uns
     static void putLong(long address, long offset, long value)
     {
         validate(address, offset, 8L);
-        unsafe.putLong(null, address + offset, value);
+        unsafe.putLong(address + offset, value);
     }
 
     static long getLong(long address, long offset)
     {
         validate(address, offset, 8L);
-        return unsafe.getLong(null, address + offset);
+        return unsafe.getLong(address + offset);
     }
 
     static void putInt(long address, long offset, int value)
     {
         validate(address, offset, 4L);
-        unsafe.putInt(null, address + offset, value);
+        unsafe.putInt(address + offset, value);
     }
 
     static int getInt(long address, long offset)
     {
         validate(address, offset, 4L);
-        return unsafe.getInt(null, address + offset);
+        return unsafe.getInt(address + offset);
     }
 
     static void putShort(long address, long offset, short value)
     {
         validate(address, offset, 2L);
-        unsafe.putShort(null, address + offset, value);
+        unsafe.putShort(address + offset, value);
     }
 
     static short getShort(long address, long offset)
     {
         validate(address, offset, 2L);
-        return unsafe.getShort(null, address + offset);
+        return unsafe.getShort(address + offset);
     }
 
     static void putByte(long address, long offset, byte value)
     {
         validate(address, offset, 1L);
-        unsafe.putByte(null, address + offset, value);
+        unsafe.putByte(address + offset, value);
     }
 
     static byte getByte(long address, long offset)
     {
         validate(address, offset, 1L);
-        return unsafe.getByte(null, address + offset);
+        return unsafe.getByte(address + offset);
     }
 
     static boolean decrement(long address, long offset)
