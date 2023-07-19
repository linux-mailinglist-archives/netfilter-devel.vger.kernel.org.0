Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC9759623
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Jul 2023 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGSNEp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Jul 2023 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGSNEp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:04:45 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44B113
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Jul 2023 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Og37k5xZ9dJOHPJGIwpyj/Tl50Nv0SbTEV9S1X+XYIk=; b=bgQ1ONlsKopff+AJaqv4MTwz8Y
        W5//kbfDpviIhVh72jQJJlioa6Mc16XavcoM2/aV2yCUyxHbiF2AxwBEp+xCsRyyHFfOcHAXL3idd
        X8zgpUQvIA+9e2NXk2AzzhuTI3u4rveGz96HJwR1NrrfYLBQuukv3bOjIrJobPbywbn/IXDlaDAQq
        ElsXiPoFIXWbJPLH78JLeEr9OnVjk7/rmq6iczzY3H5nJHZruLSr3VqHthtwTtCt52hWxNteQlnmz
        3+igPN1K2hMVO0dYFW4xbQCCSr4SqdeB9EC2nbUFBTdXfJsyK0kYNYbmE20kBTZk4KQSNGo01jhvy
        6ex0C0Cw==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qM6rA-00079A-Tr
        for netfilter-devel@vger.kernel.org; Wed, 19 Jul 2023 15:04:41 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests: shell: Sanitize nft-only/0009-needless-bitwise_0
Date:   Wed, 19 Jul 2023 15:04:32 +0200
Message-Id: <20230719130432.1306-1-phil@nwl.cc>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Some versions of awk (gawk-4.2.1-4.el8 in particular) also print the
non-debug ruleset listing's empty lines, causing the diff to fail. Catch
this by exiting upon seeing the first table heading. For the sake of
comparing bytecode, the actual ruleset listing is not interesting,
anyway.

Fixes: 0f7ea0390b336 ("tests/shell: Fix nft-only/0009-needless-bitwise_0")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0 b/iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0
index 41588a10863ec..34802cc26aad4 100755
--- a/iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0
+++ b/iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0
@@ -340,7 +340,7 @@ bridge filter OUTPUT 10 9
 # - lines with bytecode (starting with '  [')
 # - empty lines (so printed diff is not a complete mess)
 filter() {
-	awk '/^(  \[|$)/{print}'
+	awk '/^table /{exit} /^(  \[|$)/{print}'
 }
 
 diff -u -Z <(filter <<< "$EXPECT") <(nft --debug=netlink list ruleset | filter)
-- 
2.40.0

