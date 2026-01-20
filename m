Return-Path: <netfilter-devel+bounces-10350-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PLbEHcCcGmUUgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10350-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 23:32:23 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1494D02A
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 23:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96267745F0C
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 22:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC8836C5B8;
	Tue, 20 Jan 2026 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tKBiV6no"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077733451AB;
	Tue, 20 Jan 2026 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947432; cv=none; b=pQ6vkos30DB4reVKyxtFvfBJsG5KpwMRP25KU4ZyErRW1yjWHLuOK3zrn3RUzqrhEPbi6siAX9Eziq5zQJP6FRp3fW83xUf/2WGwowxDoeZ0dblA9X0DYE7Oqdqd25eTzlQrLkb8wggcucn3uCR+PRVNLzG7zRKRYz6wAeXtoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947432; c=relaxed/simple;
	bh=UxlsqwugPvD8LR7XY48QOQTZmggtMET6utD6Q+mBpfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuzVl0VGIbCiooUVEy26LRv76JC8KqtqDViFZ83vLRzrKF9cjA0rhAPWH1bkdVl7bIQyssIwNueR56t4oS6GJafB+aexC84KgvCHQaNJFXAdA0pfVhwNCuw5ZIJaxmYE1fNu/50VZTA/JOamukpKA/R6JORMiq7JBH27l4ChGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=tKBiV6no; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=JF0KQIEGWn2HYz/B51v506ZRihIJ31ziQ3oS4QAmx84=; b=tKBiV6nol2v1
	WYsN5KYlSBKahY1yWkmkuRybxcW3h8ze83ZMaE0Hvj3v/f3LyVIK+uPD9ySq19kmTXiALfjxmHILd
	JKl2zn511jnJJd1o1h9NSrfINpP5P5H9YMlydtUVNqwTolj6ASho18uU1UuJNhli7Vondh4nuTNgu
	M3R2mBLbkBtWHceDvo7ZWd3rthH0VZ8cY3M11KmpNErET78hIK6oVGEz2DydinuOmgjLp43pTpxxx
	6j35sxTFN14LpdlFgJmU5patjhWoIaSzUTYiwKh96VoVHHAN+lEV9v05rYrOuHlKkVj9nCODzbM+C
	IyBpnNkIo5qntmyykJnIIw==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viJmK-00E1oA-2n;
	Tue, 20 Jan 2026 23:01:09 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KM1HfU327795
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 22:01:17 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KM1COM327794;
	Tue, 20 Jan 2026 22:01:12 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: Aleksei Oladko <aleksey.oladko@virtuozzo.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: netfilter: ensure conntrack is enabled for helper test
Date: Tue, 20 Jan 2026 22:01:02 +0000
Message-ID: <20260120220103.327771-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10350-lists,netfilter-devel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_POLICY_ALLOW(0.00)[virtuozzo.com,quarantine];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nft_conntrack_helper.sh:url]
X-Rspamd-Queue-Id: CA1494D02A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The nft_conntrack_helper.sh assumes that conntrack entries are created
for the generated test traffic. This is not the case when only raw table
rules are installed, as conntrack is not required and remains disabled.

Add a stateful rule to force conntrack to be enabled, ensuring that
conntrack entries are created and the helper assignment can be verified.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 .../testing/selftests/net/netfilter/nft_conntrack_helper.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_conntrack_helper.sh b/tools/testing/selftests/net/netfilter/nft_conntrack_helper.sh
index abcaa7337197..43761f2eb3ec 100755
--- a/tools/testing/selftests/net/netfilter/nft_conntrack_helper.sh
+++ b/tools/testing/selftests/net/netfilter/nft_conntrack_helper.sh
@@ -60,6 +60,12 @@ table $family raw {
 		tcp dport 2121 ct helper set "ftp"
 	}
 }
+table $family filter {
+	chain forward {
+		type filter hook forward priority 0; policy accept;
+		ct state new,established,related accept
+	}
+}
 EOF
 	return $?
 }
-- 
2.43.0


