Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BC5F209D
	for <lists+netfilter-devel@lfdr.de>; Sun,  2 Oct 2022 01:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJAXjU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Oct 2022 19:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJAXjT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Oct 2022 19:39:19 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C5D2CE35
        for <netfilter-devel@vger.kernel.org>; Sat,  1 Oct 2022 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=280J40IPWuN4C8MA4kdsGHFF9Je2oDx2zy9Gpq0eJ4g=; b=Zdr3MWczt6lXdQSX/E9I0a+IbB
        7Ttsq00GJ1CaLPT4RWcNQn4QABcZ0hwSoJYbLGLotA0XvYxVc+KRI0zmiSsjxv7h/tmeC33I5Bgxc
        FUjSTkkdESBBLMY2OLox5dHnP3lvj9NMn+8O8HXlcOJWN5rI9aAjzoReQ61FfLBHEcHi++Opv2Oaf
        Q1VxFAOMquMngQwGsX8wJpHMm/SkBU5jWtP3RNH52Pk/w6MLmfe3EUhdO3SNLiGdWIAVjtVJZwqI8
        lRbCyhFvaLWhyEmK3R2gKHLzpiqh/JcoITpSOjEjvPGsq141RxQ/Y1UlFHFYzttHlwM2FNa/seeOP
        PxyFgkBA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1oem4g-0004qD-Rb
        for netfilter-devel@vger.kernel.org; Sun, 02 Oct 2022 01:39:14 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 3/3] extensions: TCPOPTSTRIP: Do not print empty options
Date:   Sun,  2 Oct 2022 01:39:06 +0200
Message-Id: <20221001233906.5386-3-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221001233906.5386-1-phil@nwl.cc>
References: <20221001233906.5386-1-phil@nwl.cc>
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

No point in printing anything if none of the bits are set.

Fixes: aef4c1e727563 ("libxt_TCPOPTSTRIP")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libxt_TCPOPTSTRIP.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/extensions/libxt_TCPOPTSTRIP.c b/extensions/libxt_TCPOPTSTRIP.c
index 6ea3489224602..ff873f98b3aaa 100644
--- a/extensions/libxt_TCPOPTSTRIP.c
+++ b/extensions/libxt_TCPOPTSTRIP.c
@@ -142,6 +142,13 @@ tcpoptstrip_print_list(const struct xt_tcpoptstrip_target_info *info,
 	}
 }
 
+static bool tcpoptstrip_empty(const struct xt_tcpoptstrip_target_info *info)
+{
+	static const struct xt_tcpoptstrip_target_info empty = {};
+
+	return memcmp(info, &empty, sizeof(empty)) == 0;
+}
+
 static void
 tcpoptstrip_tg_print(const void *ip, const struct xt_entry_target *target,
                      int numeric)
@@ -149,6 +156,9 @@ tcpoptstrip_tg_print(const void *ip, const struct xt_entry_target *target,
 	const struct xt_tcpoptstrip_target_info *info =
 		(const void *)target->data;
 
+	if (tcpoptstrip_empty(info))
+		return;
+
 	printf(" TCPOPTSTRIP options ");
 	tcpoptstrip_print_list(info, numeric);
 }
@@ -159,6 +169,9 @@ tcpoptstrip_tg_save(const void *ip, const struct xt_entry_target *target)
 	const struct xt_tcpoptstrip_target_info *info =
 		(const void *)target->data;
 
+	if (tcpoptstrip_empty(info))
+		return;
+
 	printf(" --strip-options ");
 	tcpoptstrip_print_list(info, true);
 }
-- 
2.34.1

