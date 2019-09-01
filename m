Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CCBA4C03
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Sep 2019 22:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfIAUva (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Sep 2019 16:51:30 -0400
Received: from kadath.azazel.net ([81.187.231.250]:53354 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbfIAUva (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y2uX4Nq+fO08QfKQpLlmhPngoasV9LseO0YHKuuTg70=; b=jbkLVEOuoFBPoJvpp/OkJO7qEJ
        +cIMIUsGfS9NBIYvV/eR2Jv7zl4iYudS9A4AC4OapTJUSY7IvOEyNLqr6hqpudgMdqq8FfqQwD8w8
        LeP/l7MWxU2h0r0DZLD4sUyC5UNLfeJWO4VpjonmUL1jeyPFEsJ+b9GrCa06Yp9rGUsOBLdBEWxFV
        Cz0qhH2f4iv7AR75L15zRJadi4cWo74dP4w+QkkUp3HMEf0/PqdISQqYAOkXegzYgi/Q+dySJnng3
        Rhuv397U6EwdaqV8nXfR7jVLnQHZRXRC8G5MqyBs+Gyw32s6OUvg5R3xUluksMJ5uF/+s/HPZhmBD
        7mvHPc4A==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4Wop-0002Uf-2O; Sun, 01 Sep 2019 21:51:27 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 06/29] netfilter: fix Kconfig formatting error.
Date:   Sun,  1 Sep 2019 21:51:02 +0100
Message-Id: <20190901205126.6935-7-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190901205126.6935-1-jeremy@azazel.net>
References: <20190901205126.6935-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Indent the type of CONFIG_NETFILTER_NETLINK_ACCT correctly.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 6244bf3de4af..34ec7afec116 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -20,7 +20,7 @@ config NETFILTER_FAMILY_ARP
 	bool
 
 config NETFILTER_NETLINK_ACCT
-tristate "Netfilter NFACCT over NFNETLINK interface"
+	tristate "Netfilter NFACCT over NFNETLINK interface"
 	depends on NETFILTER_ADVANCED
 	select NETFILTER_NETLINK
 	help
-- 
2.23.0.rc1

