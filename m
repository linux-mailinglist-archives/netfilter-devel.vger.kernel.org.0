Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD8101076
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 Nov 2019 02:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKSBGz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Nov 2019 20:06:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51541 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726905AbfKSBGz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574125613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1xZ3cOH2y8j9DKUoiATHFgDHBepWRYFWfXVD7sBzGc=;
        b=P/lqV9iYvPt7mokg7VTDqxjBNTU0jiCpYI+0OmZyC4fuvtaItuAGPD6MRTF6QHdYW0QiO8
        7F1rcwGYCzEZgWy/MJPewrGX93MtUe8f4FllP9lzMk+t33/IlXFOY9/VHs0oBixSzfrzKj
        H5kuJ9WxTrnGUwC/EVLS4clLkEBdUEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-wEwXhwWyMYyPranGdRKlxw-1; Mon, 18 Nov 2019 20:06:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A450802693;
        Tue, 19 Nov 2019 01:06:48 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2366F1B5C2;
        Tue, 19 Nov 2019 01:06:44 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        =?UTF-8?q?Kadlecsik=20J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jay Ligatti <ligatti@usf.edu>,
        Ori Rottenstreich <or@cs.technion.ac.il>,
        Kirill Kogan <kirill.kogan@gmail.com>
Subject: [PATCH nf-next 2/8] bitmap: Introduce bitmap_cut(): cut bits and shift remaining
Date:   Tue, 19 Nov 2019 02:06:29 +0100
Message-Id: <a5ef1b10588af8af1d5fd792e67937375942e8ff.1574119038.git.sbrivio@redhat.com>
In-Reply-To: <cover.1574119038.git.sbrivio@redhat.com>
References: <cover.1574119038.git.sbrivio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: wEwXhwWyMYyPranGdRKlxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The new bitmap function bitmap_cut() copies bits from source to
destination by removing the region specified by parameters first
and cut, and remapping the bits above the cut region by right
shifting them.

Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 include/linux/bitmap.h |  4 +++
 lib/bitmap.c           | 66 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 29fc933df3bf..e66cff371688 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -53,6 +53,7 @@
  *  bitmap_find_next_zero_area_off(buf, len, pos, n, mask)  as above
  *  bitmap_shift_right(dst, src, n, nbits)      *dst =3D *src >> n
  *  bitmap_shift_left(dst, src, n, nbits)       *dst =3D *src << n
+ *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, cop=
y rest
  *  bitmap_remap(dst, src, old, new, nbits)     *dst =3D map(old, new)(src=
)
  *  bitmap_bitremap(oldbit, old, new, nbits)    newbit =3D map(old, new)(o=
ldbit)
  *  bitmap_onto(dst, orig, relmap, nbits)       *dst =3D orig relative to =
relmap
@@ -130,6 +131,9 @@ extern void __bitmap_shift_right(unsigned long *dst, co=
nst unsigned long *src,
 =09=09=09=09unsigned int shift, unsigned int nbits);
 extern void __bitmap_shift_left(unsigned long *dst, const unsigned long *s=
rc,
 =09=09=09=09unsigned int shift, unsigned int nbits);
+extern void bitmap_cut(unsigned long *dst, const unsigned long *src,
+=09=09       unsigned int first, unsigned int cut,
+=09=09       unsigned int nbits);
 extern int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 =09=09=09const unsigned long *bitmap2, unsigned int nbits);
 extern void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
diff --git a/lib/bitmap.c b/lib/bitmap.c
index f9e834841e94..90ac4f413275 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -168,6 +168,72 @@ void __bitmap_shift_left(unsigned long *dst, const uns=
igned long *src,
 }
 EXPORT_SYMBOL(__bitmap_shift_left);
=20
+/**
+ * bitmap_cut() - remove bit region from bitmap and right shift remaining =
bits
+ * @dst: destination bitmap, might overlap with src
+ * @src: source bitmap
+ * @first: start bit of region to be removed
+ * @cut: number of bits to remove
+ * @nbits: bitmap size, in bits
+ *
+ * Set the n-th bit of @dst iff the n-th bit of @src is set and
+ * n is less than @first, or the m-th bit of @src is set for any
+ * m such that @first <=3D n < nbits, and m =3D n + @cut.
+ *
+ * In pictures, example for a big-endian 32-bit architecture:
+ *
+ * @src:
+ * 31                                   63
+ * |                                    |
+ * 10000000 11000001 11110010 00010101  10000000 11000001 01110010 0001010=
1
+ *                 |  |              |                                    =
|
+ *                16  14             0                                   3=
2
+ *
+ * if @cut is 3, and @first is 14, bits 14-16 in @src are cut and @dst is:
+ *
+ * 31                                   63
+ * |                                    |
+ * 10110000 00011000 00110010 00010101  00010000 00011000 00101110 0100001=
0
+ *                    |              |                                    =
|
+ *                    14 (bit 17     0                                   3=
2
+ *                        from @src)
+ *
+ * Note that @dst and @src might overlap partially or entirely.
+ *
+ * This is implemented in the obvious way, with a shift and carry
+ * step for each moved bit. Optimisation is left as an exercise
+ * for the compiler.
+ */
+void bitmap_cut(unsigned long *dst, const unsigned long *src,
+=09=09unsigned int first, unsigned int cut, unsigned int nbits)
+{
+=09unsigned int len =3D BITS_TO_LONGS(nbits);
+=09unsigned long keep =3D 0, carry;
+=09int i;
+
+=09memmove(dst, src, len * sizeof(*dst));
+
+=09if (first % BITS_PER_LONG) {
+=09=09keep =3D src[first / BITS_PER_LONG] &
+=09=09       (~0UL >> (BITS_PER_LONG - first % BITS_PER_LONG));
+=09}
+
+=09while (cut--) {
+=09=09for (i =3D first / BITS_PER_LONG; i < len; i++) {
+=09=09=09if (i < len - 1)
+=09=09=09=09carry =3D dst[i + 1] & 1UL;
+=09=09=09else
+=09=09=09=09carry =3D 0;
+
+=09=09=09dst[i] =3D (dst[i] >> 1) | (carry << (BITS_PER_LONG - 1));
+=09=09}
+=09}
+
+=09dst[first / BITS_PER_LONG] &=3D ~0UL << (first % BITS_PER_LONG);
+=09dst[first / BITS_PER_LONG] |=3D keep;
+}
+EXPORT_SYMBOL(bitmap_cut);
+
 int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 =09=09=09=09const unsigned long *bitmap2, unsigned int bits)
 {
--=20
2.20.1

