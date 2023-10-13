Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CCE7C8E10
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Oct 2023 22:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJMUCb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Oct 2023 16:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjJMUCb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:02:31 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CB595
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Oct 2023 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iMtOBr1wyVT8QuaCS5GRXP/20jQShKGSnICPbx6gJ1k=; b=XzALIkdWgFS0pKc6RGKgBzVGl/
        7mkuJu1xTws0A+po+vxUZ8JnvuZFjdxlWYw2HtEnFuQrtPb/pmMB8ZO3Qe/9EYJ7hiDmZuNvvTRY1
        FwnNzEaMBUxouW6vSuFfaVSKgBKcZEbF0einqNZGGDl2mJX3rjGeorILHGZD5xysPhKLTs5psU28s
        U4ooHUEwIEdl5nTU69xnXh3IPpfEiNG/izLdd0s04qQODqnGuwV4h32UDkM8SVP3arZ8kxq3Wh5mq
        jeUHOa82f8KydTM/mVfvrZAo/CY1/o5iVgAj7yCUsKi5u6DmOJ4OZPVTuJ2jj1TsAX8ye2N/PIRd5
        2O7oa6MA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qrOMe-00045X-FR; Fri, 13 Oct 2023 22:02:28 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: [nf PATCH] selftests: netfilter: Run nft_audit.sh in its own netns
Date:   Fri, 13 Oct 2023 22:02:24 +0200
Message-ID: <20231013200224.6663-1-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Don't mess with the host's firewall ruleset. Since audit logging is not
per-netns, add an initial delay of a second so other selftests' netns
cleanups have a chance to finish.

Fixes: e8dbde59ca3fe ("selftests: netfilter: Test nf_tables audit logging")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tools/testing/selftests/netfilter/nft_audit.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/netfilter/nft_audit.sh b/tools/testing/selftests/netfilter/nft_audit.sh
index e94a80859bbdb..99ed5bd6e8402 100755
--- a/tools/testing/selftests/netfilter/nft_audit.sh
+++ b/tools/testing/selftests/netfilter/nft_audit.sh
@@ -11,6 +11,12 @@ nft --version >/dev/null 2>&1 || {
 	exit $SKIP_RC
 }
 
+# Run everything in a separate network namespace
+[ "${1}" != "run" ] && { unshare -n "${0}" run; exit $?; }
+
+# give other scripts a chance to finish - audit_logread sees all activity
+sleep 1
+
 logfile=$(mktemp)
 rulefile=$(mktemp)
 echo "logging into $logfile"
-- 
2.41.0

