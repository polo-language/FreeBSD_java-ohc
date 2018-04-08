--- ohc-core/src/test/java/org/caffinitas/ohc/tables/UnsTest.java.orig	2018-04-08 18:49:03 UTC
+++ ohc-core/src/test/java/org/caffinitas/ohc/tables/UnsTest.java
@@ -390,17 +390,18 @@ public class UnsTest
         {
             for (int i = 0; i < 120; i++)
             {
-                long v = Uns.getLong(adr, i);
+                String loop = "at loop #" + i;
+                long v = Uns.getInt(adr, i);
                 Uns.increment(adr, i);
-                assertEquals(Uns.getLong(adr, i), v + 1);
+                assertEquals(Uns.getInt(adr, i), v + 1, loop);
                 Uns.increment(adr, i);
-                assertEquals(Uns.getLong(adr, i), v + 2);
+                assertEquals(Uns.getInt(adr, i), v + 2, loop);
                 Uns.increment(adr, i);
-                assertEquals(Uns.getLong(adr, i), v + 3);
+                assertEquals(Uns.getInt(adr, i), v + 3, loop);
                 Uns.decrement(adr, i);
-                assertEquals(Uns.getLong(adr, i), v + 2);
+                assertEquals(Uns.getInt(adr, i), v + 2, loop);
                 Uns.decrement(adr, i);
-                assertEquals(Uns.getLong(adr, i), v + 1);
+                assertEquals(Uns.getInt(adr, i), v + 1, loop);
             }
 
             Uns.putLong(adr, 8, 1);
