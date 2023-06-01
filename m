Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4671A34D
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Jun 2023 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjFAPyC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Jun 2023 11:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjFAPxy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:53:54 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70FB8E2
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Jun 2023 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jz9J1
        7qPdzKxSrE6AEZwO9U/5asKmv5w1Avw9vbbjEU=; b=G/6KdIK4Yj+YtNeYvutMF
        qv3alu8WTLtHdw1P4tcnKaWMePIczgOZ0+CAHoCJzr4PDNyqrToZbNLIfWMKAN2R
        qgOGvz82VbL1t6SF6nocYblv0VRIGpxlwYXIPY4MZtuwwk/cj717RPSWHdeAC9QK
        2FEc8xqgB7oXrfELElNwiI=
Received: from localhost.localdomain (unknown [39.170.41.95])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wD3sxv9vnhkjcWoAg--.13594S2;
        Thu, 01 Jun 2023 23:53:34 +0800 (CST)
From:   tongxiaoge1001@126.com
To:     pablo@netfilter.org, netfilter-devel@vger.kernel.org
Cc:     shixuantong1@huawei.com, shixuantong <tongxiaoge1001@126.com>
Subject: [PATCH] fix typo
Date:   Thu,  1 Jun 2023 23:53:23 +0800
Message-Id: <20230601155323.65484-1-tongxiaoge1001@126.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3sxv9vnhkjcWoAg--.13594S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr43KryxZrW5Aw4DWF17KFg_yoWxCFX_G3
        45ZFs7Way2yF1qva1kX3Z5A34xGrnrJr1xXwn3JFnrt3yUAr4Yk3WkWFW8Aw1UWrW5KasI
        qwnIvrykCw47GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjwvttUUUUU==
X-Originating-IP: [39.170.41.95]
X-CM-SenderInfo: pwrqw55ldrwvirqqiqqrswhudrp/1tbiGB+BWlpEKFk2lQAAsQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: shixuantong <tongxiaoge1001@126.com>

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

