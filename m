Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFD16A702
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Feb 2020 14:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBXNMD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Feb 2020 08:12:03 -0500
Received: from kadath.azazel.net ([81.187.231.250]:58258 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgBXNMD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u5Xj54wNsouiaQG2C3G1asAwvwl/5AJR12w34FQqm2E=; b=G/aQ9h2d0AsPaOIKYnYfJ5DlMM
        PM5BOmouuAJ1UyRS7TceGIjH0w3SvPa0+SXu36LduhPGAUzvIkvKqomFvkdGyVRIwyF49w1RVWpiL
        PJ7RU70ZGHHO48SUo1uIOLdEuc8Wry+2WaN5DBYeoq+RUBRvWeCUtEnBsPIy8zmHfz/1D2/XDU//E
        sBXmVKcBueioPUSJsPsAS17kZNW7q+UKQzwCjB6vJk0L8liHGJdPNij1H82ebzpzFPZlcSJ2KnuqQ
        GEsljUKC1WiWDqhXt023qJnGluSGejHT8CRV3IFDvq9+D/vRFVhYaIVGyHHxr2YqpnNOJ7gxd9zxU
        oQQENtAA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j6DWk-0001wB-2L; Mon, 24 Feb 2020 13:12:02 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH libnftnl 2/3] include: update nf_tables.h.
Date:   Mon, 24 Feb 2020 13:12:00 +0000
Message-Id: <20200224131201.512755-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224131201.512755-1-jeremy@azazel.net>
References: <20200224131201.512755-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pick up a couple of new bitwise netlink attributes.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/linux/netfilter/nf_tables.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index 065218a20bb7..57e83e152bf3 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -526,6 +526,8 @@ enum nft_bitwise_ops {
  * @NFTA_BITWISE_OP: type of operation (NLA_U32: nft_bitwise_ops)
  * @NFTA_BITWISE_DATA: argument for non-boolean operations
  *                     (NLA_NESTED: nft_data_attributes)
+ * @NFTA_BITWISE_MREG: mask register (NLA_U32: nft_registers)
+ * @NFTA_BITWISE_XREG: xor register (NLA_U32: nft_registers)
  *
  * The bitwise expression supports boolean and shift operations.  It implements
  * the boolean operations by performing the following operation:
@@ -549,6 +551,8 @@ enum nft_bitwise_attributes {
 	NFTA_BITWISE_XOR,
 	NFTA_BITWISE_OP,
 	NFTA_BITWISE_DATA,
+	NFTA_BITWISE_MREG,
+	NFTA_BITWISE_XREG,
 	__NFTA_BITWISE_MAX
 };
 #define NFTA_BITWISE_MAX	(__NFTA_BITWISE_MAX - 1)
-- 
2.25.0

