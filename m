Return-Path: <netfilter-devel+bounces-12366-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKQeIABJ9GkGAQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12366-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 08:32:32 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E74234AA9FA
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 08:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACBFC301CDBF
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2026 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD635DA48;
	Fri,  1 May 2026 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="VN6omrF+"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55EA218EB1;
	Fri,  1 May 2026 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617144; cv=none; b=SMMaxcy+Y/sBA1/HdGbkiwsRaxIdWe3V0krY1N/fqBcZ4HvLSakMunmpIzQNk15c1HTksz/n3FCbBTdCDc8aJvn3NjKlq7/ii8La6YukBwXSIJm3N2VV59BjWki3i0MNz6KVSw2Sgoyh4aymSwt1HBarcIzcL5RjVoX0WxyX854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617144; c=relaxed/simple;
	bh=nLWDjCYG2VJb/niqMQC2v2WrYtWZ4BxwIhZ+B8UKc9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1roywhBZpgra4bXjTsoGOMyFwMTZ33/TvdpRkZRv/JHqWny2ZFfh6c3/ZdCUs4a0m4nsRmDClKtO1hdRV16fkwyUFIKwi5prP1uYemCJbDteZ3mK4JCNtpqx++cE0VBWB1oMoqeBTYutRaBdA1dbimikmyDZqycqvqihCrruPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=VN6omrF+ reason="key not found in DNS"; arc=none smtp.client-ip=63.250.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Received: from Kyren (unknown [49.207.224.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4g6Lmy3PK4z8sX2;
	Fri, 01 May 2026 06:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1777617142;
	bh=tq9jLvGxcCHzQiNF7PIsLncsroNls5TdwyWf8VNvfHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VN6omrF+AAUctom6MwiH1anKSomMA6DLWvOsiRpgtKA7rPmtuRtQ9jTI1rnn05yNV
	 oV/dnFN1ARm1kQOJvVV/VvQhx4MWbGbyj8ccOC4Ro7vHQpcaFgYAK5Vr/7TPQtqHHM
	 I+1vwS7APJNnNu7gKdUqFgalFpAUh2bSp2SCYsI4q4mDuVhsymN8KdIefP6hm2k2Pr
	 tlcsfl5Qht8bk+eec8HsMgyGzxcJrD8ayuFW6+oHEo2duGftxtMgICQKeNCCwNAS4H
	 8/l8auvcaGLR2vPRNNFT7FkSlJXww6i08GjYMrmBXBlsYzh4MA5+YA8nJzEHrBoZhr
	 7khA/BuTfygzw==
From: HACKE-RC <rc@rexion.ai>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HACKE-RC <rc@rexion.ai>
Subject: [PATCH net-next v2 2/3] netfilter: nf_conntrack_irc: use nf_ct_helper_parse_port()
Date: Fri,  1 May 2026 12:01:55 +0530
Message-ID: <20260501063156.2520780-3-rc@rexion.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501063156.2520780-1-rc@rexion.ai>
References: <20260501063156.2520780-1-rc@rexion.ai>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai
X-Rspamd-Queue-Id: E74234AA9FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-12366-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[rexion.ai];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[rexion.ai:s=spacemail];
	DKIM_TRACE(0.00)[rexion.ai:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_SPAM(0.00)[0.019];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rc@rexion.ai,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rexion.ai:mid,rexion.ai:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Replace the bare simple_strtoul() call for port parsing with the
shared nf_ct_helper_parse_port(). This avoids reliance on the
nul-terminated string guarantee (currently provided by the newline
scan earlier in parse_dcc) and validates the port fits in u16.

The simple_strtoul() for the IP address field is left as-is since
it returns unsigned long for a __be32 conversion, which is a
separate concern.

Fixes: 869f37d8e48f ("[NETFILTER]: nf_conntrack/nf_nat: add IRC helper port")
Signed-off-by: HACKE-RC <rc@rexion.ai>
---
 net/netfilter/nf_conntrack_irc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_irc.c b/net/netfilter/nf_conntrack_irc.c
index 522183b9a..1b51f5a6a 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -93,7 +93,9 @@ static int parse_dcc(char *data, const char *data_end, __be32 *ip,
 		data++;
 	}
 
-	*port = simple_strtoul(data, &data, 10);
+	if (nf_ct_helper_parse_port(data, data_end - data, port, &data))
+		return -1;
+
 	*ad_end_p = data;
 
 	return 0;
-- 
2.54.0


