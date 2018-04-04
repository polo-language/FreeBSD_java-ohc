--- ohc-core/src/main/java/org/caffinitas/ohc/linked/UnsExt7.java.orig	2016-04-12 19:48:04 UTC
+++ ohc-core/src/main/java/org/caffinitas/ohc/linked/UnsExt7.java
@@ -28,8 +28,8 @@ final class UnsExt7 extends UnsExt
 
     long getAndPutLong(long address, long offset, long value)
     {
-        long r = unsafe.getLong(null, address + offset);
-        unsafe.putLong(null, address + offset, value);
+        long r = unsafe.getLong(address + offset);
+        unsafe.putLong(address + offset, value);
         return r;
     }
 
