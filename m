Return-Path: <netfilter-devel+bounces-11383-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uENJFTWuwmkyggQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11383-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Mar 2026 16:31:01 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5E3180E2
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Mar 2026 16:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 073AF3190028
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Mar 2026 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F840629A;
	Tue, 24 Mar 2026 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chu9seF0"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9A40627D
	for <netfilter-devel@vger.kernel.org>; Tue, 24 Mar 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365555; cv=none; b=GhoZlH4ko0ltRe5Yt7tLmI+wL6+q83PIZc7vdHrBiQUSO/ujaJoXL3OX1BYu2OC+zck1sSUO0yExdaY4YuQGRxXVjyvbVhT+rl6vkCxCSjlnU3Ztjp8eauxQwHueQpP/tnLSnh2NmJ5RMOvZotmxQfnfse2AIrHKm4MWtUt8JFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365555; c=relaxed/simple;
	bh=Wx3rCjft+f2xsQztl0u/tUkCuC3NJhEmQV+HjeE0iDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pM8+12s+z2W8c6BmTqZTQQDPukBtMFpkD0fcS+DEbeS82ZJmA/Kg3t2MV2Urw31/dQ7fttSuueDKSRnstNSBppZ2dpVlhAvQIjWLQEeonmP1VKrJ+UFhipov9lEUXBIbVnyMvGJi+eBdbmv6i6emGzagyIilncIEUvznV0eo6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chu9seF0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NM71jEPy1P0WHGHdPzJuToYXqWbTBefaY9NqYpg0IOU=;
	b=chu9seF0UM5HWcvKxFx+jsaWJQ9lKeUN/dTRDBwgOxIZirQPgCB/qU0kNYPKuERTLlUmW7
	YaqPeTyPIlc9XFVEzQ7KyMr79V6QUZDHtZ+gqvlWFh7eSZdxaJk/7mV+7Eg1fduFdIFElQ
	a4FgZjonDAidLTU+WH31CdopB8TBGEY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-M9C8THMbPsyL3eIxAPqsKA-1; Tue,
 24 Mar 2026 11:19:07 -0400
X-MC-Unique: M9C8THMbPsyL3eIxAPqsKA-1
X-Mimecast-MFC-AGG-ID: M9C8THMbPsyL3eIxAPqsKA_1774365545
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 363C61944DCB;
	Tue, 24 Mar 2026 15:19:04 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A712D18001FE;
	Tue, 24 Mar 2026 15:18:57 +0000 (UTC)
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
Subject: [PATCH 1/2] sched/isolation: Make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
Date: Tue, 24 Mar 2026 11:18:26 -0400
Message-ID: <20260324151827.2006656-2-longman@redhat.com>
In-Reply-To: <20260324151827.2006656-1-longman@redhat.com>
References: <20260324151827.2006656-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11383-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADD5E3180E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 041ee6f3727a ("kthread: Rely on HK_TYPE_DOMAIN for preferred
affinity management"), kthreads default to use the HK_TYPE_DOMAIN
cpumask. IOW, it is no longer affected by the setting of the nohz_full
boot kernel parameter.

That means HK_TYPE_KTHREAD should now be an alias of HK_TYPE_DOMAIN
instead of HK_TYPE_KERNEL_NOISE to correctly reflect the current kthread
behavior. Make the change as HK_TYPE_KTHREAD is still being used in
some networking code.

Fixes: 041ee6f3727a ("kthread: Rely on HK_TYPE_DOMAIN for preferred affinity management")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/isolation.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index dc3975ff1b2e..cf0fd03dd7a2 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -20,6 +20,11 @@ enum hk_type {
 	HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_MAX,
 
+	/*
+	 * HK_TYPE_KTHREAD is now an alias of HK_TYPE_DOMAIN
+	 */
+	HK_TYPE_KTHREAD = HK_TYPE_DOMAIN,
+
 	/*
 	 * The following housekeeping types are only set by the nohz_full
 	 * boot commandline option. So they can share the same value.
@@ -29,7 +34,6 @@ enum hk_type {
 	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
 };
 
 #ifdef CONFIG_CPU_ISOLATION
-- 
2.53.0


