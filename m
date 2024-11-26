Return-Path: <netfilter-devel+bounces-5325-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A39D95F9
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Nov 2024 12:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EDC166DC6
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Nov 2024 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705FD1C878E;
	Tue, 26 Nov 2024 11:04:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E97DA68
	for <netfilter-devel@vger.kernel.org>; Tue, 26 Nov 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619096; cv=none; b=I7WsLgwIWY6LfGdV7acZzdqxxAmsJvm4b3PB4t+hZiNIcdXDJSxuTxT5ShqmwFtk1gkq16E1dyP3ELM8shx44vZYLOsEtiMJ6ehhl0pIGy05XuRDr+YJbOk6FUwalIVeyNHZDQIab3xSnuHSrNkkYAgc00lQ2soYpTh7u2T1IrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619096; c=relaxed/simple;
	bh=QkK+4o+GxL8Vwgw3KI84zT5wXflQ89/VDVRsXipyGzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZcDb45v7hAMVbQP95aXccXzKyRuEmnRs9PjD4gsFlYOddIS2ngH/+dvu/s7M59nY/T7f86PJSBMwPZFT5+eVEGHPMGIOY8yyfimMRCNnQ2Dl2WugpJLxuDczhPvfqWU23zSAQbUVrAo/sNF8kTbJI8LGIi/H+e2hqfjD6yn2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf] netfilter: nft_socket: remove WARN_ON_ONCE on maximum cgroup level
Date: Tue, 26 Nov 2024 12:04:48 +0100
Message-Id: <20241126110448.13269-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup maximum depth is INT_MAX by default, there is a cgroup toggle to
restrict this maximum depth to a more reasonable value not to harm
performance. Remove unnecessary WARN_ON_ONCE which is reachable from
userspace.

Fixes: 7f3287db6543 ("netfilter: nft_socket: make cgroupsv2 matching work with namespaces")
Reported-by: syzbot+57bac0866ddd99fe47c0@syzkaller.appspotmail.com
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index f5da0c1775f2..35d0409b0095 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -68,7 +68,7 @@ static noinline int nft_socket_cgroup_subtree_level(void)
 
 	cgroup_put(cgrp);
 
-	if (WARN_ON_ONCE(level > 255))
+	if (level > 255)
 		return -ERANGE;
 
 	if (WARN_ON_ONCE(level < 0))
-- 
2.30.2


