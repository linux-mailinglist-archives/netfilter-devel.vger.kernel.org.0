Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105B264F4B
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jul 2019 01:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGJXip (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 Jul 2019 19:38:45 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:59434 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfGJXio (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:38:44 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 19:38:44 EDT
Received: from leda.eworm.de (p5b101f53.dip0.t-ipconnect.de [91.16.31.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 48C1215F924;
        Thu, 11 Jul 2019 01:31:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 48C1215F924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1562801513; bh=V/OQmi6tn1BXzNYfG/lvuYyRqgrfTgpxiaY1dc/jHR8=;
        h=From:To:Cc:Subject:Date;
        b=ZrrXhpkA5q/UgPfnVeFmkVHMQLy67G47i6vb94yetpG3Kg7TEDMQ6UrBuEENxQeLi
         9obFbe/DKXCu3AQ1IWJ7yNrgdzm8nIOojUUVXus+Sv5+CDLS+AzKRrGhw9HHkiHld8
         TMQb8JpxgQPS/dG+Ggbf4W5NfRHLV2bXMPDDb01M=
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 0419D1206E7; Thu, 11 Jul 2019 01:31:23 +0200 (CEST)
From:   Christian Hesse <mail@eworm.de>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] netfilter: nf_tables: fix module autoload for redir
Date:   Thu, 11 Jul 2019 01:31:12 +0200
Message-Id: <20190710233112.3652-1-mail@eworm.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.32
X-Spamd-Bar: ++
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=smtp-only@eworm.de smtp.mailfrom=eworm@leda.eworm.de
X-Rspamd-Server: mx
X-Spam-Level: **
X-Stat-Signature: bmrmj1jf3ik6r5raom9soxknjbc7ozdy
X-Rspamd-Queue-Id: 48C1215F924
X-Spamd-Result: default: False [2.32 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-2.88)[-0.959,0];
         FORGED_SENDER(0.30)[mail@eworm.de,eworm@leda.eworm.de];
         RCVD_TLS_LAST(0.00)[];
         ASN(0.00)[asn:3320, ipnet:91.0.0.0/10, country:DE];
         FROM_NEQ_ENVFROM(0.00)[mail@eworm.de,eworm@leda.eworm.de];
         RCVD_COUNT_TWO(0.00)[2]
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix expression for autoloading.

Fixes: 5142967ab524 ("netfilter: nf_tables: fix module autoload with inet family")
Signed-off-by: Christian Hesse <mail@eworm.de>
---
 net/netfilter/nft_redir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 8487eeff5c0e..43eeb1f609f1 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -291,4 +291,4 @@ module_exit(nft_redir_module_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Arturo Borrero Gonzalez <arturo@debian.org>");
-MODULE_ALIAS_NFT_EXPR("nat");
+MODULE_ALIAS_NFT_EXPR("redir");
