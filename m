Return-Path: <netfilter-devel+bounces-13382-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9wmpGXoKOWo8lwcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13382-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 12:12:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0B36AE8F6
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 12:12:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13382-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13382-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59F4630237F3
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 10:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D363A48E6;
	Mon, 22 Jun 2026 10:11:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA593A4F47
	for <netfilter-devel@vger.kernel.org>; Mon, 22 Jun 2026 10:11:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123080; cv=none; b=geaE0GUpDMleVTX1Ccki4ZoQ99l1JxCsG9+B344NM631HVEUN6S0esMXe0z6GoiJ8uv/4r152fmxiIrBbyv+8YZVRYjxPOpWkJOlSuTPhT5W6/W0DYcSTU3VeThWuMfXpJKMvOzAqUcW8siFJC2gxSZVZtFBtSgxR0fXELvTQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123080; c=relaxed/simple;
	bh=JY7+d5VF1Xzy8uSO+SaUCr6dkcW5BmeTdQQvD5VxEmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzaVSaZi7wX4QAIBiC/EqtzT91bxeyxlnFcCG6hFu/iC0vqluK1K2/5YPwe47b97aawLDAAua5b6ZAPPOKbsyisgqV9W3hyyKz+gQmapEOmcYSAAAkeZ65BC351zIB/zpBOq6MpOc3xkV9peg+1XmXwBY7LQpG6dFDmp4RyIhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=4.193.249.245
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app3 (Coremail) with SMTP id ywmowAC3xvkkCjlqyIYsAA--.11269S4;
	Mon, 22 Jun 2026 18:10:57 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	lorenzo@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	chzhengyang2023@lzu.edu.cn,
	n05ec@lzu.edu.cn
Subject: [PATCH nf v3 2/2] selftests: netfilter: add bridge tunnel flowtable regression
Date: Mon, 22 Jun 2026 18:10:27 +0800
Message-ID: <5b8a9e87ff7b47401612bb0e0fc841d8bfdd333d.1782092221.git.chzhengyang2023@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782092221.git.chzhengyang2023@lzu.edu.cn>
References: <cover.1782092221.git.chzhengyang2023@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowAC3xvkkCjlqyIYsAA--.11269S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4kuFy3Zr4kZFW8CFWfZrb_yoWrGw4rpF
	W0g34YyryxZFn8G3yDAw43Kr1rZa95Arn8uFn5G3srZrykWFWIga1rK3yDW3WUCrs3XrWa
	vr45t34IgFn8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0GCWo48FMDwAAAsx
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	RECEIVED_BLOCKLISTDE(3.00)[4.193.249.245:received];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,kernel.org,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-13382-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:lorenzo@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:chzhengyang2023@lzu.edu.cn,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD0B36AE8F6

From: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>

Add a nft_flowtable.sh regression test for the bridge direct-xmit plus
IPIP/IP6IP6 underlay configuration that reproduces the reachable
DIRECT+tunnel tuple combination exercised by the flowtable fix.

The test reuses the existing bridge and tunnel topology, installs flow
rules for the tunnel egress and bridge reply path, verifies IPv4 and
IPv6 forwarding, and checks the flowtable counters after the transfer.

Signed-off-by: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v3:
  - Add nft_flowtable.sh coverage for the bridge direct-xmit plus
    IPIP/IP6IP6 underlay case
  - v2 Link: https://lore.kernel.org/all/7016923271a6bb3e26f9a21757922d3c5b1a7487.1781683535.git.chzhengyang2023@lzu.edu.cn/
---
 .../selftests/net/netfilter/nft_flowtable.sh  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 7a34ef468975..cecbec148bdb 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -736,6 +736,61 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "on bridge"; then
 	ret=1
 fi
 
+if ip -net "$nsr1" link show tun0 > /dev/null 2>&1 &&
+   ip -net "$nsr2" link show tun0 > /dev/null 2>&1; then
+	ip -net "$nsr1" route change default via 192.168.100.2
+	ip -net "$nsr2" route change default via 192.168.100.1
+	ip -6 -net "$nsr1" route delete default
+	ip -6 -net "$nsr1" route add default via fee1:3::2
+	ip -6 -net "$nsr2" route delete default
+	ip -6 -net "$nsr2" route add default via fee1:3::1
+	ip -net "$ns2" route add default via 10.0.2.1
+	ip -6 -net "$ns2" route add default via dead:2::1
+
+	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+		'meta oif "tun0" tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
+	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+		'meta oif "tun6" tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
+	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+		'meta oif "veth0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
+	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+		'meta oif "br0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
+	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+		'meta oif "tun0" accept'
+	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+		'meta oif "tun6" accept'
+
+	ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+
+	if test_tcp_forwarding "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
+		check_counters "bridge + IPIP tunnel"
+	else
+		echo "FAIL: flow offload for ns1/ns2 with bridge + IPIP tunnel" 1>&2
+		ip netns exec "$nsr1" nft list ruleset
+		ret=1
+	fi
+
+	if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+		check_counters "bridge + IP6IP6 tunnel"
+	else
+		echo "FAIL: flow offload for ns1/ns2 with bridge + IP6IP6 tunnel" 1>&2
+		ip netns exec "$nsr1" nft list ruleset
+		ret=1
+	fi
+
+	ip -net "$nsr1" route change default via 192.168.10.2
+	ip -net "$nsr2" route change default via 192.168.10.1
+	ip -net "$ns2" route del default via 10.0.2.1
+	ip -6 -net "$nsr1" route delete default
+	ip -6 -net "$nsr1" route add default via fee1:2::2
+	ip -6 -net "$nsr2" route delete default
+	ip -6 -net "$nsr2" route add default via fee1:2::1
+	ip -6 -net "$ns2" route del default via dead:2::1
+else
+	echo "SKIP: bridge + tunnel flowtable regression (tun0 missing)"
+	[ "$ret" -eq 0 ] && ret=$ksft_skip
+fi
+
 
 # Another test:
 # Add bridge interface br0 to Router1, with NAT and VLAN.
-- 
2.43.0


