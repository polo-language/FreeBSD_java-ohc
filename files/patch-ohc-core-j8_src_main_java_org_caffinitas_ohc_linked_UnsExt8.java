--- ohc-core-j8/src/main/java/org/caffinitas/ohc/linked/UnsExt8.java.orig	2020-05-24 08:57:42 UTC
+++ ohc-core-j8/src/main/java/org/caffinitas/ohc/linked/UnsExt8.java
@@ -28,12 +28,12 @@ final class UnsExt8 extends UnsExt
 
     long getAndPutLong(long address, long offset, long value)
     {
-        return unsafe.getAndSetLong(null, address + offset, value);
+        return unsafe.getAndSetLong(address + offset, value);
     }
 
     int getAndAddInt(long address, long offset, int value)
     {
-        return unsafe.getAndAddInt(null, address + offset, value);
+        return unsafe.getAndAddInt(address + offset, value);
     }
 
     long crc32(long address, long offset, long len)
