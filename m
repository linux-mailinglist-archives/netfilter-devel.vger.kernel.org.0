Return-Path: <netfilter-devel+bounces-11844-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE4zKNrk3GnBXwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11844-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 14:43:06 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49683EC282
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 14:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F033025904
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B4361666;
	Mon, 13 Apr 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="fXFMM9IE"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from outbound.pv.icloud.com (pv-2002c-snip4-11.eps.apple.com [57.103.64.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069323AE87
	for <netfilter-devel@vger.kernel.org>; Mon, 13 Apr 2026 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083869; cv=none; b=ZnDmWbpVnFDhtOF7tBcTvmTXhzw5Ibbu4C7SZ0LgvQ4OkFG/0Q5XjbEEKQ7bbfcf3Ge+32HtCf7pmxKon/FyKYwuc6I0qHqQX7vluXzYJkKqzO+6wiJVW43JkHJ0u7CZ+ad2wZuc2QyR44LE+kpMfEy8BzYWHK6WL3+BjMdC26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083869; c=relaxed/simple;
	bh=Yi2SCb/x739mnqpz6VMd55tLi+SxnfCZQHYhRPRCCXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sg69WL0H4jWsgNmCeoA50R/a3U/uZGvrWBQ+jw6zORJMxBXVs6OWL2O8/1yt6el5/oeCaUTVVVuLx5ewajGE1ggN33mXfb9YOmMfBkzT0vZVLwirIcEChqIfomG2Nll7fU6U10GrX8YXTBXCWB9ELFX5ZnOt3n203R3GS4memUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=fXFMM9IE; arc=none smtp.client-ip=57.103.64.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-6 (Postfix) with ESMTPS id 54F6818006AC;
	Mon, 13 Apr 2026 12:37:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1776083865; x=1778675865; bh=O3uMIPCrvYHywSHyF1zNBfItb8oOyRiSHxcpO2wLAug=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=fXFMM9IE0NJBw4Z/AOIr2TCOsGFHSilp0Fb/Ki95WIZRV8zH095l0qEPT8GelXF5CgoHCbQUX4a/6zGCECE+0pXbfTeTpl5gHBMGBRsgqjZryuwRdvSjhZJXUWU/1iUU3z7sl8aNqhKda7JxK1rHJAeHS2/ED9cKdNLp0Is8/nPE1wMPQNq6gvm/DxuIelzBLFH4U9xRCiv5y5FOxRNd0LtwYCW5HLkvJ0vxGeCjn9gZCQ82H3DtJzOmFFd1GUIUOqhjEaNOztMA3XjBPre4qwDMrcPa+0hpfbbd8j7QYLc9xVMjwGl/tFc3Qweye1ztXDdJj+u0X7oQDFii6P8MCg==
mail-alias-created-date: 1621344842221
Received: from localhost.localdomain (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-6 (Postfix) with ESMTPSA id 5605318006B8;
	Mon, 13 Apr 2026 12:37:39 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: netfilter-devel@vger.kernel.org
Cc: Vladimir Vdovin <deliran@verdict.gg>,
	pablo@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	phil@nwl.cc
Subject: [PATCH nf-next] netfilter: nf_conncount: make number of hash slots configurable
Date: Mon, 13 Apr 2026 15:37:07 +0300
Message-ID: <20260413123712.42993-1-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEyNCBTYWx0ZWRfX0WsI0LtM4Tam
 612qNyNelxxIOTWL6BnFn3gsDXavxkoeOaqK93ajmd3zOnZ28mcLcsybA6K3N78zD3XTimLHXvW
 IWTZGqEopmhFOjJzrOFXQeQkf59APVyPQHKF2pwdjTZzgJhv9q+zG6vGyvcymaMEiKTVxnOqDhO
 2BVqr/PuTSj72eIPROjpbxXzIyV7ukNJ0A1IP/M5sSx9GSGA3sVjkrRyb96JqHPOad7Spx3E9Qt
 XMi9Io1cTDJB0j7S1ewNsDiHn6yAOGbBpI5FfEZrWgfDqHBm4lz/1vCjdm/5Bx6xH/zTjME9sBq
 VOGWanXZZE6HI8EWi/iWUQ4ft6UM6icExoRrg5PzO+wIIRkkkTV4md2KIr36HE=
X-Proofpoint-GUID: nu28hS9DGZQLQKXZo1odM1j2WesxA4bo
X-Authority-Info-Out: v=2.4 cv=B9K0EetM c=1 sm=1 tr=0 ts=69dce397
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=E3O_fn2r2lR9tnkCD14A:9
X-Proofpoint-ORIG-GUID: nu28hS9DGZQLQKXZo1odM1j2WesxA4bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=772 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130124
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[verdict.gg];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11844-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[verdict.gg:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,verdict.gg:dkim,verdict.gg:email,verdict.gg:mid]
X-Rspamd-Queue-Id: A49683EC282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some workloads with high conntrack rate
generate high lock contention on insert_tree(), so
constant 256 CONNCOUNT_SLOTS can be too small.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 net/netfilter/Kconfig        | 12 ++++++++++++
 net/netfilter/nf_conncount.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 6cdc994fdc8a..38df2829d4d6 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -111,6 +111,18 @@ if NF_CONNTRACK
 config NETFILTER_CONNCOUNT
 	tristate
 
+config NF_CONNCOUNT_SLOTS
+	int "Number of hash slots for nf_conncount"
+	depends on NF_CONNTRACK
+	default 256
+	range 1 4096
+	help
+	  Number of hash slots used by the nf_conncount module.
+	  Each slot has its own spinlock and rb-tree, so increasing
+	  this value reduces lock contention at the cost of additional
+	  memory.
+	  Default is 256. Allowed range: 1 - 4096.
+
 config NF_CONNTRACK_MARK
 	bool  'Connection mark tracking support'
 	depends on NETFILTER_ADVANCED
diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 00eed5b4d1b1..bdb9081a6c05 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -32,7 +32,7 @@
 #include <net/netfilter/nf_conntrack_tuple.h>
 #include <net/netfilter/nf_conntrack_zones.h>
 
-#define CONNCOUNT_SLOTS		256U
+#define CONNCOUNT_SLOTS		CONFIG_NF_CONNCOUNT_SLOTS
 
 #define CONNCOUNT_GC_MAX_NODES		8
 #define CONNCOUNT_GC_MAX_COLLECT	64

base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.47.0


