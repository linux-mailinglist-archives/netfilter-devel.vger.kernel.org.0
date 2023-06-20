Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD36736E41
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jun 2023 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjFTOEG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Jun 2023 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjFTOEG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:04:06 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9824DA4
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Jun 2023 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q5wuhQgG49UvRV7MRuo96JDusVTvSc0f31FTTIw+FFc=; b=M2gMjyae7T8yvP3t/EkhPs4k8F
        g1eHYN28AjoLBn2xN4gG2Idy7hUVhz6lSiVRbUqnIihJ/x63WniY68xf9VAqCJSVOhwyFr4KvAt3f
        wIMXmwOvhE7vv2nAk8ooMSwJPxYayRTIbs7pR9219gxAXVVWIGUMveSs5fmq7U5nXbFBjx3wpZ/OA
        +BU+VQE9OBZK3sJpHQfCgGPRSR/sStyIvkELqfxAsoLih9DWRR36MAGViYKPLlqu+aAr6QTbuR6ok
        SIwa0b7Njl51VjFyOzXDOGvBUvA2MxP0tBHiKf9KwS0zaDS5wAPEtLtPGIQTxd+LbQ6qV1vrFHNGa
        yw3aswlQ==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qBbxh-0000mW-E6; Tue, 20 Jun 2023 16:04:01 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] cli: Make valgrind happy
Date:   Tue, 20 Jun 2023 16:03:52 +0200
Message-Id: <20230620140352.21633-1-phil@nwl.cc>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Missing call to nft_ctx_free() upsets valgrind enough to suspect
possible losses, add them where sensible. This fixes reports with
readline-lined builds at least. The same code is shared for libedit
though, and there's an obvious spot for linenoise.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/cli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/cli.c b/src/cli.c
index 11fc85abeaa2b..bc7f64ef0b762 100644
--- a/src/cli.c
+++ b/src/cli.c
@@ -126,6 +126,7 @@ static void cli_complete(char *line)
 	if (line == NULL) {
 		printf("\n");
 		cli_exit();
+		nft_ctx_free(cli_nft);
 		exit(0);
 	}
 
@@ -141,6 +142,7 @@ static void cli_complete(char *line)
 
 	if (!strcmp(line, CMDLINE_QUIT)) {
 		cli_exit();
+		nft_ctx_free(cli_nft);
 		exit(0);
 	}
 
@@ -244,6 +246,7 @@ int cli_init(struct nft_ctx *nft)
 		linenoiseFree(line);
 	}
 	cli_exit();
+	nft_ctx_free(nft);
 	exit(0);
 }
 
-- 
2.40.0

