Return-Path: <netfilter-devel+bounces-4117-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8B987262
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Sep 2024 13:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652AF1F21881
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Sep 2024 11:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD761AFB06;
	Thu, 26 Sep 2024 11:07:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A125A1AED4E;
	Thu, 26 Sep 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348857; cv=none; b=Nj/976WbuNK/6AAkiclx3Bzz1i2R9Q9ZYRh2Pus1pcogxbc5lEyZ8eINsLGgMGCHqqFY47gaYfQZyRyE3p0z7nehFYPQbQ9mTj+9/k99ZUAly8qjYOEQSds9Iqp60Blx2CirJDuk+Pd1vd+AtH3C+G/sOKA0N+R3gvgoTB+I/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348857; c=relaxed/simple;
	bh=iw5rqZhlyRRvWig+zMEW4R2IZGqmW6nnfjeUJSwKezE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNiqJAFvavlpVyBANQuDp7FmymXmMWqEECpH1fbEawn9CYSAUkABesWfSKB01GgrNYo3RQnnZGaYB5Ybrg63XLvbKBTrgFfJCRCJZn/PR8uVgYFml4X0zEdmkKNf+TuGX2qm6Nk7rLM+FXYetmjWlyVLkqPWe50LSOWPMTqHeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 06/14] docs: tproxy: ignore non-transparent sockets in iptables
Date: Thu, 26 Sep 2024 13:07:09 +0200
Message-Id: <20240926110717.102194-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240926110717.102194-1-pablo@netfilter.org>
References: <20240926110717.102194-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

The iptables example was added in commit d2f26037a38a (netfilter: Add
documentation for tproxy, 2008-10-08), but xt_socket 'transparent'
option was added in commit a31e1ffd2231 (netfilter: xt_socket: added new
revision of the 'socket' match supporting flags, 2009-06-09).

Now add the 'transparent' option to the iptables example to ignore
non-transparent sockets, which is also consistent with the nft example.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 Documentation/networking/tproxy.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tproxy.rst b/Documentation/networking/tproxy.rst
index 00dc3a1a66b4..7f7c1ff6f159 100644
--- a/Documentation/networking/tproxy.rst
+++ b/Documentation/networking/tproxy.rst
@@ -17,7 +17,7 @@ The idea is that you identify packets with destination address matching a local
 socket on your box, set the packet mark to a certain value::
 
     # iptables -t mangle -N DIVERT
-    # iptables -t mangle -A PREROUTING -p tcp -m socket -j DIVERT
+    # iptables -t mangle -A PREROUTING -p tcp -m socket --transparent -j DIVERT
     # iptables -t mangle -A DIVERT -j MARK --set-mark 1
     # iptables -t mangle -A DIVERT -j ACCEPT
 
-- 
2.30.2


