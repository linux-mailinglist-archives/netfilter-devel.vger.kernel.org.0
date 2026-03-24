Return-Path: <netfilter-devel+bounces-11382-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKj9JjqvwmmRkwQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11382-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Mar 2026 16:35:22 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD29031823A
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Mar 2026 16:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F6033040D28
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Mar 2026 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB403E0C45;
	Tue, 24 Mar 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUzNkpBI"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9693D5246
	for <netfilter-devel@vger.kernel.org>; Tue, 24 Mar 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365548; cv=none; b=W5mOcjIbsV+TPgMpQy3rTz7v8JT21LeyuQ7ifuCEE+FkS7zWf000/lacCkzQKf6c+UXv9cHepldZ4HNBL6QhgfoM/zdZ6j/DWS49/7qr8GiysFauNgtCfjJw5skzjwOh3rSZpuWqxJChHuseYV3M/FR4vkbGfMRzvkUO9na5om4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365548; c=relaxed/simple;
	bh=6HhVUYhmyMTvcAMswOM3dLmuCaP1Ju8W9ZRentoH7XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7mTj7n3bKfYBOP2cRzNEd89Nl2rHl4WuNhZBFa+f2k7obZlErF3AtQ86FLF0Wp4Pc2/BamL2/8bScuEeq92joX3pK059Mh4aYDvPyHj73pjrcds2PfMvfE70qXvHQDlEtfcSr4KieFVsiRDahNpt3pfaPhVFhkEGIMD7t4liS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUzNkpBI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CSqalb9riJujooqwq7rgCHpq/1IqNcmhKMRp2FBzELY=;
	b=DUzNkpBIauuMdzVH0+aYwNorIO/KgrWhap7Z7bBCe8/M7AGQ6fNAcYXHbU5ozC5TpchYaO
	LYrdFvAYGaAoc9g8xkJ11mRzN7CqoKzZbwWv1jel44cCrICxtPtfZbV/7E/em2AujqtyPC
	J9yEIj3JBYoi4o7Z6V5nXqiGAm7UhPU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-vuqiLqJEN7aqlqKNrZsWVw-1; Tue,
 24 Mar 2026 11:19:01 -0400
X-MC-Unique: vuqiLqJEN7aqlqKNrZsWVw-1
X-Mimecast-MFC-AGG-ID: vuqiLqJEN7aqlqKNrZsWVw_1774365538
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4E511955EAC;
	Tue, 24 Mar 2026 15:18:57 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F104180075C;
	Tue, 24 Mar 2026 15:18:51 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Frederic Weisbecker <frederic@kernel.org>,
	Chen Ridong <chenridong@huawei.com>,
	Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	sheviks <sheviks@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] ipvs: Fix incorrect use of HK_TYPE_KTHREAD housekeeping cpumask
Date: Tue, 24 Mar 2026 11:18:25 -0400
Message-ID: <20260324151827.2006656-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11382-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD29031823A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 041ee6f3727a ("kthread: Rely on HK_TYPE_DOMAIN for preferred
affinity management"), the HK_TYPE_KTHREAD housekeeping cpumask may no
longer be correct in showing the actual CPU affinity of kthreads that
have no predefined CPU affinity. As the ipvs networking code is still
using HK_TYPE_KTHREAD, we need to make HK_TYPE_KTHREAD reflect the
reality.

This patch series makes HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
and uses RCU to protect access to the HK_TYPE_KTHREAD housekeeping
cpumask.

Waiman Long (2):
  sched/isolation: Make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
  ipvs: Guard access of HK_TYPE_KTHREAD cpumask with RCU

 include/linux/sched/isolation.h |  6 +++++-
 include/net/ip_vs.h             | 20 ++++++++++++++++----
 net/netfilter/ipvs/ip_vs_ctl.c  | 13 ++++++++-----
 3 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.53.0


