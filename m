Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA77210B2
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Jun 2023 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFCO6B (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Jun 2023 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFCO6A (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:58:00 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11BF1CE
        for <netfilter-devel@vger.kernel.org>; Sat,  3 Jun 2023 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=s9BxC
        VTKtKzT1E/O+FWLlVinJlewSAqNwAzDGL9kbsg=; b=Wz3kvMArN4cLo24OzFDE8
        tw8q6VIIlPIl8fg3M1nL2V5v9vProczSURTg0iY2gOc96U7uh53sO36hzd0K0KLK
        bxbNIyKI8b9PkdzVAfS3cWjZu2JIxtIDpYeZDzP7r1oQ0/E0CXVhm265miqlnx6E
        xQ7fTo9IRYxiQFkylk81b0=
Received: from localhost.localdomain (unknown [58.101.35.131])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wCXTDLVVHtkE9HaAg--.17309S4;
        Sat, 03 Jun 2023 22:57:27 +0800 (CST)
From:   tongxiaoge1001@126.com
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, shixuantong1@huawei.com,
        tongxiaoge1001@126.com
Subject: [PATCH] fix typo
Date:   Sat,  3 Jun 2023 22:57:23 +0800
Message-Id: <20230603145723.79748-1-tongxiaoge1001@126.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ZHjqV4Nj5/ALy9fN@calendula>
References: <ZHjqV4Nj5/ALy9fN@calendula>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXTDLVVHtkE9HaAg--.17309S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4UXF1UKF1xtF1kZw47urg_yoWfGFc_G3
        yUXFsrWay2yFn2yan7Xas5Jr97KwnrJr4fXwn3Jasrt34jkr4Yy3Z5XFW8Aw4UXrW5KasI
        qwnFvrWkCw47WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8cVy3UUUUU==
X-Originating-IP: [58.101.35.131]
X-CM-SenderInfo: pwrqw55ldrwvirqqiqqrswhudrp/1tbibR6DWlpEDmnLTgAAsW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: shixuantong <tongxiaoge1001@126.com>

Sorry, I'm not sure how to reply to the message, so I have to write it in the patch file. 
Of course you can add "Signed-off-by".

Fix: https://bugzilla.netfilter.org/show_bug.cgi?id=1681
---
 tests/nft-table-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nft-table-test.c b/tests/nft-table-test.c
index 1b2f280..53cf3d1 100644
--- a/tests/nft-table-test.c
+++ b/tests/nft-table-test.c
@@ -34,7 +34,7 @@ static void cmp_nftnl_table(struct nftnl_table *a, struct nftnl_table *b)
 		print_err("table flags mismatches");
 	if (nftnl_table_get_u32(a, NFTNL_TABLE_FAMILY) !=
 	    nftnl_table_get_u32(b, NFTNL_TABLE_FAMILY))
-		print_err("tabke family mismatches");
+		print_err("table family mismatches");
 }
 
 int main(int argc, char *argv[])
-- 
2.33.0

