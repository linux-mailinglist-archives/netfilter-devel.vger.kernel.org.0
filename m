Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0040B76C2AA
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Aug 2023 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHBCFQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Aug 2023 22:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjHBCFP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:05:15 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6686E212C
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Aug 2023 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PkY57qdaTrdD+o4h8omHf2iU17A4MuX/wHh84Dz1kT4=; b=VlFnzCG4ChOOkVJLXF1DE4a05g
        EVZHs46eFjmECUmo/rb8pcIgAVn77dNercQbKkxBeV9RIGBh4Npz3mB2z6Dtav5CskAo5eBj7T9zp
        g6PgZBybmNJs1chjfWT/bfMPDl919CIUBlPATCk/8Kp3Ij021vQY7GubaIfvyeSmMje7VTNsUtqYq
        KfO4frEnA8svVhpYnI6jqfA9S4EN9avCayx/1MsCbEjpFlUI9K9jzl1EaHPHXS5BpoNmhv/AKA0WW
        /F4bYIFiCBd/+7NTS6zhnYi/4A3MZ/mv1/hY9yCYKhTgCJ1G8PrLtNa8+Aw/KSY/WFDXWf4OfQ1i1
        P86KL3Dw==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qR1Ee-0002tA-O2; Wed, 02 Aug 2023 04:05:12 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     debian@helgefjell.de
Subject: [iptables PATCH 05/16] man: Use HTTPS for links to netfilter.org
Date:   Wed,  2 Aug 2023 04:03:49 +0200
Message-Id: <20230802020400.28220-6-phil@nwl.cc>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230802020400.28220-1-phil@nwl.cc>
References: <20230802020400.28220-1-phil@nwl.cc>
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

The browser is redirected there anyway, but who cares about such minor
details nowadays.

Reported-by: debian@helgefjell.de
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libxt_nfacct.man | 2 +-
 iptables/iptables.8.in      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/extensions/libxt_nfacct.man b/extensions/libxt_nfacct.man
index b755f9770451c..a818fedd6b1ac 100644
--- a/extensions/libxt_nfacct.man
+++ b/extensions/libxt_nfacct.man
@@ -26,5 +26,5 @@ nfacct get http\-traffic
 .PP
 You can obtain
 .B nfacct(8)
-from http://www.netfilter.org or, alternatively, from the git.netfilter.org
+from https://www.netfilter.org or, alternatively, from the git.netfilter.org
 repository.
diff --git a/iptables/iptables.8.in b/iptables/iptables.8.in
index c83275b294872..71a6251d6b00c 100644
--- a/iptables/iptables.8.in
+++ b/iptables/iptables.8.in
@@ -419,7 +419,7 @@ allocation or error messages from kernel cause an exit code of 4. Finally,
 other errors cause an exit code of 1.
 .SH BUGS
 Bugs?  What's this? ;-)
-Well, you might want to have a look at http://bugzilla.netfilter.org/
+Well, you might want to have a look at https://bugzilla.netfilter.org/
 \fBiptables\fP will exit immediately with an error code of 111 if it finds
 that it was called as a setuid-to-root program.
 iptables cannot be used safely in this manner because it trusts
@@ -463,7 +463,7 @@ not in the standard distribution,
 and the netfilter-hacking-HOWTO details the netfilter internals.
 .br
 See
-.BR "http://www.netfilter.org/" .
+.BR "https://www.netfilter.org/" .
 .SH AUTHORS
 Rusty Russell originally wrote iptables, in early consultation with Michael
 Neuling.
-- 
2.40.0

