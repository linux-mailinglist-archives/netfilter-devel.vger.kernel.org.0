Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDFD17679A
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 23:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgCBWob (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 17:44:31 -0500
Received: from kadath.azazel.net ([81.187.231.250]:42610 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCBWoa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CfIj8SjzYfP4YiB2+5RctARo6IJjv/WXWUaoUxy/BUc=; b=pHkfWmWAaVmDdk+vUInowcuu8G
        LnZTBkyooybEs/6eAeW4UimdEWdkvsQFSQCwSL6ApkTdEewr0+2VM4nZ3qpsUur6oXEt/drotFZMX
        mPZtDqnoPCwGSI/f13MWkbgphMnEE1ZjtzXSK1ABh9zqcXLwuycQWOekztv9jc7udUy9rTkyY+SvU
        JDUNCuuybVgL3WkwQeo+7QXk672rPVn+Iffmd2s/wJjo2xOxJaMWkI442Y22Oea9neI64QPX3m6aF
        jB7Rce8d9Ca3B0x0CfEckIIaNAS+DditDfEASRBEv5z1KjeHFxQVCto+kAKbDidZrpjVn0TsOgnc/
        wbsfzw2A==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j8tPC-0000Sg-LM; Mon, 02 Mar 2020 22:19:18 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 16/18] tests: shell: remove stray debug flag.
Date:   Mon,  2 Mar 2020 22:19:14 +0000
Message-Id: <20200302221916.1005019-17-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302221916.1005019-1-jeremy@azazel.net>
References: <20200302221916.1005019-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

0040mark_shift_0 was passing --debug=eval to nft.  Remove it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 tests/shell/testcases/chains/0040mark_shift_0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shell/testcases/chains/0040mark_shift_0 b/tests/shell/testcases/chains/0040mark_shift_0
index 55447f0b9737..ef3dccfa049a 100755
--- a/tests/shell/testcases/chains/0040mark_shift_0
+++ b/tests/shell/testcases/chains/0040mark_shift_0
@@ -8,4 +8,4 @@ RULESET="
   add rule t c oif lo ct mark set (meta mark | 0x10) << 8
 "
 
-$NFT --debug=eval -f - <<< "$RULESET"
+$NFT -f - <<< "$RULESET"
-- 
2.25.1

