Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA5CF78A
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 12:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfJHKyS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Oct 2019 06:54:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33811 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfJHKyS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:54:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so13051972wrp.1
        for <netfilter-devel@vger.kernel.org>; Tue, 08 Oct 2019 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=8PRMpFMEShUJD3hk0FhdJAdfxv7IH5PnkwKGnknPWEo=;
        b=LIAbj6asGE0sHfxqpZGQnnjYlynVT1wjMaVa5mm8sr/fGbvB7dwS5ZaiV6Tsch+Whk
         nxbrkuuzNeBNK7+5BLnyRKepNZa1NvymG0GaTwaqzyALWENnVM+c/MWCCiu7zx5lvOYX
         7DNUyKeOTlGlkDe9AvqHp2px9P8Y9V6AmvIHRBfaohxjZxrvFZn1c278OUauptR/ViV0
         2bLk+A1a2do9o+lNCmR1NP8dBaPCsuStgwW+DvYeFReaL1NOEuDwri3Zg/mp9IHdTMnS
         M1UkffneFTPqLy3+zFafrkwYGrhe6CsHqfNAU0RZOb+UVLpafluZELbOzGxFa7CjD1om
         d90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8PRMpFMEShUJD3hk0FhdJAdfxv7IH5PnkwKGnknPWEo=;
        b=B96E2+vikDAmhrC7E8woh8Pp8SM0oyG43Qna/yhqFBTULfVM1VNnfdgZzMynFzIVs4
         kXY2VeWgLmLONt7d5x4EjpzNYaGQv9INq7SwZFz0q5HGRXC7Go3XS7bGv2rmAClBTHTo
         rfuMIDBJv6ksJPqKl8Ka/Ww2KPp/TV61ANhc9CJr+e7d5QboTWCb/ccP4q27fJZZNzso
         0lQotUAKWRA7TPeXNoFSqp74rbqz1IQP1eaAJAIl9FqsDkgKrnxXszn++WmOCaRGCa/i
         NU4zOg7ytrXGaomo1Lqb4AltCUYUpUje4/IaY0j2+2LFW0wJmlIok8O36C1UWK7oChsS
         oGEA==
X-Gm-Message-State: APjAAAVbhsSHStrxyvPIrMvfsDJWoA8lI5sMSzVx6GDNPljLJiT5rdJG
        WXvxEW1CgvGCe1ywNPvQMgbl3Ucw
X-Google-Smtp-Source: APXvYqxnD2M43PurcYFsrzJsHxsuUYsTX6uEyAMKtmufYMMrkUjq6/UrkTrvV3TZzIGrygcU4kg2fQ==
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr20177026wrs.101.1570532057100;
        Tue, 08 Oct 2019 03:54:17 -0700 (PDT)
Received: from cplx1037.edegem.eu.thmulti.com ([2001:4158:f013:0:2a10:7bff:fec5:6f08])
        by smtp.gmail.com with ESMTPSA id f3sm20874630wrq.53.2019.10.08.03.54.16
        for <netfilter-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Oct 2019 03:54:16 -0700 (PDT)
From:   Alin Nastac <alin.nastac@gmail.com>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] checksum: Fix TCP/UDP checksum computation on big endian arches
Date:   Tue,  8 Oct 2019 12:54:11 +0200
Message-Id: <1570532051-923-1-git-send-email-alin.nastac@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On big endian arches UDP/TCP checksum is incorrectly computed when
payload length is odd.

Signed-off-by: Alin Nastac <alin.nastac@gmail.com>
---
 src/extra/checksum.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/extra/checksum.c b/src/extra/checksum.c
index 4d52a99..42389aa 100644
--- a/src/extra/checksum.c
+++ b/src/extra/checksum.c
@@ -11,6 +11,7 @@
 
 #include <stdio.h>
 #include <stdbool.h>
+#include <endian.h>
 #include <arpa/inet.h>
 #include <netinet/ip.h>
 #include <netinet/ip6.h>
@@ -26,8 +27,13 @@ uint16_t nfq_checksum(uint32_t sum, uint16_t *buf, int size)
 		sum += *buf++;
 		size -= sizeof(uint16_t);
 	}
-	if (size)
-		sum += *(uint8_t *)buf;
+	if (size) {
+#if __BYTE_ORDER == __BIG_ENDIAN
+		sum += (uint16_t)*(uint8_t *)buf << 8;
+#else
+		sum += (uint16_t)*(uint8_t *)buf;
+#endif
+	}
 
 	sum = (sum >> 16) + (sum & 0xffff);
 	sum += (sum >>16);
-- 
2.7.4

