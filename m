Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC3720072
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Jun 2023 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjFBLcS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Jun 2023 07:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjFBLcS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:32:18 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A455196
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Jun 2023 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mk2La
        Rnj9k+l/wJnY2FAIgOQ1I9Y+YgYfVYIt3HBAmg=; b=oScs1YIusxSgtgcEDswgt
        LVXuoAjaAVssoAs0rR9fD/kwvDtZZi5/ipzEXNiLObycO6AKoWoYKkzSVVTC/QgX
        W5wnI6uA6luONl3VLOqOJBtNQfX1EWMde1MbS0Owlh0qPVoJrBw41lse4mWaWgXs
        E64boAtafGEAtrITaGlZLc=
Received: from localhost.localdomain (unknown [58.101.35.131])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wCHwRAr03lkqlK6Ag--.14561S4;
        Fri, 02 Jun 2023 19:31:56 +0800 (CST)
From:   tongxiaoge1001@126.com
To:     tongxiaoge1001@126.com
Cc:     netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        shixuantong1@huawei.com
Subject: [PATCH] fix typo
Date:   Fri,  2 Jun 2023 19:31:53 +0800
Message-Id: <20230602113153.75428-1-tongxiaoge1001@126.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230601155323.65484-1-tongxiaoge1001@126.com>
References: <20230601155323.65484-1-tongxiaoge1001@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHwRAr03lkqlK6Ag--.14561S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1DtrWkAF18CF1xAFy3twb_yoW3Grg_G3
        45ZFsrW3yjyF1vvw4kXas5A3s7GrnrJr1xXwn3JF9rtryjyr4Yk3WkWFW8Aw1UWrW5KasI
        qwnFvrykGw47WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU11EE7UUUUU==
X-Originating-IP: [58.101.35.131]
X-CM-SenderInfo: pwrqw55ldrwvirqqiqqrswhudrp/1tbiHA+CWlpEKGjKagAAs1
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

