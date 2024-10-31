Return-Path: <netfilter-devel+bounces-4812-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0BB9B7844
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2024 11:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D33B2706B
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56A19A292;
	Thu, 31 Oct 2024 10:01:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FC19925D;
	Thu, 31 Oct 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368887; cv=none; b=nDv5upVMvlFvEFRF5KHZPR9tZUkUHb/Spv1Ts37hIMZjFyVdMYcft/nKgRPKhk/9qODcGSuzDt/BfFPiaIuUax4uAvlOv8uvSEGuvTa3ZOt6HmevkXcqvwdfI1otw+KxHf6+BU2fP6LbJ3hjaeCakbEaTQ0ls4o3S/MT86gVhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368887; c=relaxed/simple;
	bh=wVRTrWiIbds7p0oRXM3JkntNU0FVah64IXh8GSUFh9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGlspWib/uE+J6cC9Z6LfY2IydODWv6cc79+I8SBY/5tcZnTTQr5K9AKJ8DVuyY+Bp19s2/4BB3opoTJ2/PMfSeVaQ+NQpSk2l8M+G2KbLTeaCNmgZFdG1zDItH1hT5de2oNV34G4m9DbZ4pDULa4mwAbsK+r9aMHIssJKRAf/4=
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
Subject: [PATCH net 1/4] selftests: netfilter: remove unused parameter
Date: Thu, 31 Oct 2024 11:01:14 +0100
Message-Id: <20241031100117.152995-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241031100117.152995-1-pablo@netfilter.org>
References: <20241031100117.152995-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Jing <liujing@cmss.chinamobile.com>

err is never used, remove it.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../testing/selftests/net/netfilter/conntrack_dump_flush.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
index dc056fec993b..254ff03297f0 100644
--- a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
@@ -98,7 +98,7 @@ static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr *nlh,
 	char buf[MNL_SOCKET_BUFFER_SIZE];
 	struct nlmsghdr *rplnlh;
 	unsigned int portid;
-	int err, ret;
+	int ret;
 
 	portid = mnl_socket_get_portid(sock);
 
@@ -217,7 +217,7 @@ static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
 	struct nfgenmsg *nfh;
 	struct nlattr *nest;
 	unsigned int portid;
-	int err, ret;
+	int ret;
 
 	portid = mnl_socket_get_portid(sock);
 
@@ -264,7 +264,7 @@ static int conntrack_flush_zone(struct mnl_socket *sock, uint16_t zone)
 	struct nfgenmsg *nfh;
 	struct nlattr *nest;
 	unsigned int portid;
-	int err, ret;
+	int ret;
 
 	portid = mnl_socket_get_portid(sock);
 
-- 
2.30.2


