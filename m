Return-Path: <netfilter-devel+bounces-10344-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLQNGyPmb2lhUQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10344-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 21:31:31 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD254B530
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF4AA9324
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE5947AF6D;
	Tue, 20 Jan 2026 19:18:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56447AF6E;
	Tue, 20 Jan 2026 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936734; cv=none; b=upvCpVEwoNMFAmWcNh4soZ8uXyA+TWdEkq0brSO0UYd+yvOA8+qBujh5EyKcslP7he4CzJxQui/JxESspYCsm1gCS6qA8s30B9NUrE8cf7sa53crHWFKxQHvIyg/1OX6JdFHh88Er/GJFx8SVVOZMOxUHcNLx3K36hEmxISa5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936734; c=relaxed/simple;
	bh=nzVXgQAQoyL8xiY7gW4NenIUPxls1oLfHqIsY8KhDhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLHj+ime0uwvLq9pG4qYHbqy6wdW1Pq31PyD627Qax0MaT1zrw7R7rMuPT7uSu7/aa71ZVjgTwqD3fV4RIFyegmskHwnomo4X6Ze7yVfMsGzSCEteznPXBCGad57PUecB2oYkUaYOkMJyhHqGlLgDCOKfhVMZurvn1+PFI8RH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 951BA608AC; Tue, 20 Jan 2026 20:18:50 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 10/10] netfilter: xt_tcpmss: check remaining length before reading optlen
Date: Tue, 20 Jan 2026 20:18:03 +0100
Message-ID: <20260120191803.22208-11-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120191803.22208-1-fw@strlen.de>
References: <20260120191803.22208-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-10344-lists,netfilter-devel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: EAD254B530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Quoting reporter:
  In net/netfilter/xt_tcpmss.c (lines 53-68), the TCP option parser reads
 op[i+1] directly without validating the remaining option length.

  If the last byte of the option field is not EOL/NOP (0/1), the code attempts
  to index op[i+1]. In the case where i + 1 == optlen, this causes an
  out-of-bounds read, accessing memory past the optlen boundary
  (either reading beyond the stack buffer _opt or the
  following payload).

Reported-by: sungzii <sungzii@pm.me>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_tcpmss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_tcpmss.c b/net/netfilter/xt_tcpmss.c
index 37704ab01799..0d32d4841cb3 100644
--- a/net/netfilter/xt_tcpmss.c
+++ b/net/netfilter/xt_tcpmss.c
@@ -61,7 +61,7 @@ tcpmss_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			return (mssval >= info->mss_min &&
 				mssval <= info->mss_max) ^ info->invert;
 		}
-		if (op[i] < 2)
+		if (op[i] < 2 || i == optlen - 1)
 			i++;
 		else
 			i += op[i+1] ? : 1;
-- 
2.52.0


